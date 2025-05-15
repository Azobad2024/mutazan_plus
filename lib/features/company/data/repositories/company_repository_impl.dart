// lib/features/company/data/repositories/company_repository_impl.dart

import 'package:dartz/dartz.dart';
import 'package:mutazan_plus/features/company/domain/entities/company_entitiy.dart';
import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/expentions.dart';
import '../../../../../core/errors/failure.dart';
import '../../domain/repositories/company_repository.dart';
import '../datasources/company_local_data_source.dart';
import '../datasources/company_remote_data_source.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final NetworkInfo networkInfo;
  final CompanyRemoteDataSource remoteDataSource;
  final CompanyLocalDataSource localDataSource;

  CompanyRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<CompanyEntity>>> getCompanies() async {
    final isOnline = await networkInfo.isConnected;
    if (isOnline) {
      try {
        final remoteList = await remoteDataSource.getCompanies();
        await localDataSource.cacheCompanies(remoteList);
        return Right(remoteList);
      } on ServerException catch (e) {
        return Left(ServerFailure(errMessage: e.errModel.detail));
      } catch (_) {
        return Left(
            ServerFailure(errMessage: 'خطأ أثناء جلب الشركات من الخادم'));
      }
    } else {
      final cached = await localDataSource.getLastCompanies();
      if (cached.isNotEmpty) {
        return Right(cached);
      } else {
        return Left(CacheFailure(errMessage: 'لا توجد بيانات محفوظة محلياً'));
      }
    }
  }
}

// // lib/features/company/data/repositories/company_repository_impl.dart
// import 'package:dartz/dartz.dart';
// import 'package:mutazan_plus/features/company/domain/entities/company_entitiy.dart';
// import '../../../../core/connection/network_info.dart';
// import '../../../../core/errors/expentions.dart';
// import '../../../../core/errors/failure.dart';
// import '../../domain/repositories/company_repository.dart';
// import '../datasources/company_local_data_source.dart';
// import '../datasources/company_remote_data_source.dart';

// class CompanyRepositoryImpl implements CompanyRepository {
//   final NetworkInfo networkInfo;
//   final CompanyRemoteDataSource remoteDataSource;
//   final CompanyLocalDataSource localDataSource;

//   CompanyRepositoryImpl({
//     required this.networkInfo,
//     required this.remoteDataSource,
//     required this.localDataSource,
//   });

//   @override
//   Future<Either<Failure, List<CompanyEntity>>> getCompanies() async {
//     if (await networkInfo.isConnected) {
//       try {
//         final remoteList = await remoteDataSource.getCompanies();
//         await localDataSource.cacheCompanies(remoteList);
//         return Right(remoteList);
//       } on ServerException catch (e) {
//         return Left(ServerFailure(errMessage: e.errModel.detail));
//       } catch (_) {
//         return Left(ServerFailure(errMessage: 'حدث خطأ أثناء جلب الشركات'));
//       }
//     } else {
//       try {
//         final local = await localDataSource.getLastCompanies();
//         if (local.isEmpty) {
//           return Left(CacheFailure(errMessage: 'لا توجد بيانات محفوظة'));
//         }
//         return Right(local);
//       } on CacheExeption catch (e) {
//         return Left(CacheFailure(errMessage: e.errorMessage));
//       } catch (_) {
//         return Left(CacheFailure(errMessage: 'حدث خطأ في استرجاع البيانات المحلية'));
//       }
//     }
//   }
// }
