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

//يتم استرجاع البيانات من التخزين المحلي في حال عدم توفر الإنترنت
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
