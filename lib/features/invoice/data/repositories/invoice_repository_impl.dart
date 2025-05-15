import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/connection/network_info.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/errors/expentions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';
import '../datasources/invoice_remote_data_source.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final NetworkInfo networkInfo;
  final InvoiceRemoteDataSource remoteDataSource;
  final ApiConsumer api;

  InvoiceRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.api,
  });

  @override
  Future<Either<Failure, List<InvoiceEntity>>> getInvoices(String xSchema) async {
    if (!await networkInfo.isConnected) {
      return Left(Failure(errMessage: 'لا يوجد اتصال بالإنترنت'));
    }
    try {
      final list = await remoteDataSource.getInvoices(xSchema);
      return Right(list);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errModel.detail));
    } catch (_) {
      return Left(Failure(errMessage: 'حدث خطأ غير متوقع أثناء جلب الفواتير'));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyInvoice(int invoiceId) async {
    // هنا فقط نخزن محلياً، لذا نرجع Right(unit) مباشرة
    return Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> reportInvoice(int invoiceId, int violationId) async {
    if (!await networkInfo.isConnected) {
      return Left(Failure(errMessage: 'لا يوجد اتصال بالإنترنت'));
    }
    try {
      await api.post(
        EndPoint.reportInvoice(invoiceId), 
        data: {'violation_id': violationId},
      );
      return Right(unit);
    } on DioException catch (e) {
      return Left(Failure(errMessage: e.message ?? 'خطأ في الإبلاغ'));
    }
  }
}







// // lib/features/invoice/data/repositories/invoice_repository_impl.dart

// import 'package:dartz/dartz.dart';
// import '../../../../core/connection/network_info.dart';
// import '../../../../core/errors/expentions.dart';
// import '../../../../core/errors/failure.dart';
// import '../../domain/entities/invoice_entity.dart';
// import '../../domain/repositories/invoice_repository.dart';
// import '../datasources/invoice_remote_data_source.dart';

// class InvoiceRepositoryImpl implements InvoiceRepository {
//   final NetworkInfo networkInfo;
//   final InvoiceRemoteDataSource remoteDataSource;

//   InvoiceRepositoryImpl({
//     required this.networkInfo,
//     required this.remoteDataSource,
//   });

//   @override
//   Future<Either<Failure, List<InvoiceEntity>>> getInvoices(String xSchema) async {
//     if (!await networkInfo.isConnected) {
//       return Left(Failure(errMessage: 'لا يوجد اتصال بالإنترنت'));
//     }
//     try {
//       final list = await remoteDataSource.getInvoices();
//       return Right(list);
//     } on ServerException catch (e) {
//       return Left(Failure(errMessage: e.errModel.detail));
//     } catch (_) {
//       return Left(Failure(errMessage: 'حدث خطأ غير متوقع أثناء جلب الفواتير'));
//     }
//   }
// }
