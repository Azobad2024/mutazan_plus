import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:mutazan_plus/core/connection/network_info.dart';
import 'package:mutazan_plus/core/databases/api/api_consumer.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/errors/expentions.dart';
import 'package:mutazan_plus/features/auth/data/models/sign_in_model.dart';
import 'package:mutazan_plus/features/auth/data/models/user_model.dart';

// class UserRepository {
//   final ApiConsumer api;
//   final NetworkInfo networkInfo;

//   UserRepository({ required this.networkInfo, required this.api });

//   /// بعد تسجيل الدخول نخزن user_id من التوكين
//   Future<Either<String, SignInModel>> signIn({
//     required String username,
//     required String password,
//   }) async {
//     final cache = CacheHelper();
//     // ... تحقق من الاتصال (offline fallback) ...

//     final resp = await api.post(EndPoint.signIn, data: {
//       ApiKey.username: username,
//       ApiKey.password: password,
//     });

//     final user = SignInModel.fromJson(resp as Map<String, dynamic>);
//     final decoded = JwtDecoder.decode(user.access);

//     await cache.saveData(key: ApiKey.access, value: user.access);
//     await cache.saveData(key: ApiKey.refresh, value: user.refresh);
//     await cache.saveData(key: ApiKey.username, value: username);
//     await cache.saveData(key: ApiKey.password, value: password);

//     return Right(user);
//   }

//   Future<Either<String, UserModel>> getUserProfile() async {
//   try {
//     final resp = await api.get(EndPoint.getUserDataMe());
//     return Right(UserModel.fromJson(resp as Map<String, dynamic>));
//   } on ServerException catch (e) {
//     return Left(e.errModel.detail ?? ' خطأ في الخادم ');
//   } catch (e) {
//     return Left('خطأ غير متوقع: $e');
//   }
// }

// }

class UserRepository {
  final ApiConsumer api;
  final NetworkInfo networkInfo;

  UserRepository({required this.networkInfo, required this.api});

  Future<Either<String, SignInModel>> signIn({
    required String username,
    required String password,
  }) async {
    final cache = CacheHelper();

    // 1. OFLINE fallback
    if (!await networkInfo.isConnected) {
      final cachedUser = cache.getDataString('username');
      final cachedPass = cache.getDataString('password');
      final cachedAccess = cache.getDataString(ApiKey.access);
      final cachedRefresh = cache.getDataString(ApiKey.refresh);
      if (cachedUser == username &&
          cachedPass == password &&
          cachedAccess != null &&
          cachedRefresh != null) {
        return Right(SignInModel(access: cachedAccess, refresh: cachedRefresh));
      }
      return Left('لا يوجد اتصال والاعتماديات غير محفوظة محليًا');
    }

    // 2. ONLINE: إرسال بيانات إلى API
    try {
      final resp = await api.post(
        EndPoint.signIn,
        data: {
          ApiKey.username: username,
          ApiKey.password: password,
        },
      );

      if (resp is! Map<String, dynamic>) {
        return Left('استجابة غير متوقعة من الخادم');
      }
      if (!resp.containsKey(ApiKey.access) ||
          !resp.containsKey(ApiKey.refresh)) {
        return Left('لم يتم استلام التوكن من الخادم');
      }

      final user = SignInModel.fromJson(resp);
      // فك التوكن لحفظ البيانات
      final decoded = JwtDecoder.decode(user.access);

      final userId = decoded['user_id']?.toString();
      if (userId != null) {
        await cache.saveData(key: ApiKey.id, value: userId);
      }

      // حفظ في الكاش
      await cache.saveData(key: ApiKey.access, value: user.access);
      await cache.saveData(key: ApiKey.refresh, value: user.refresh);
      await cache.saveData(
          key: ApiKey.id, value: decoded[ApiKey.id].toString());
      await cache.saveData(key: 'username', value: username);
      await cache.saveData(key: 'password', value: password);

      return Right(user);
    } on ServerException catch (e) {
      return Left(e.errModel.detail);
    } catch (e) {
      return Left('خطأ غير متوقع: $e');
    }
  }

  Future<Either<String, UserModel>> getUserProfile() async {
    try {
      final resp = await api.get(EndPoint.getUserDataMe());
      return Right(UserModel.fromJson(resp as Map<String, dynamic>));
    } on ServerException catch (e) {
      return Left(e.errModel.detail ?? ' خطأ في الخادم ');
    } catch (e) {
      return Left('خطأ غير متوقع: $e');
    }
  }
}


 // Profile
  // Future<Either<String, UserModel>> getUserProfile() async {
  //   try {
  //     final response = await api.get(
  //       EndPoint.getUserDataEndPoint(
  //         CacheHelper().getData(key: ApiKey.id),
  //       ),
  //     );
  //     return Right(UserModel.fromJson(response));
  //   } on ServerException catch (e) {
  //     return Left(e.errModel.errorMessage ?? 'حدث خطأ في الخادم');
  //   }
  // }