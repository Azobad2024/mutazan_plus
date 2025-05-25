// lib/features/invoice/data/repositories/invoice_repository_impl.dart

import 'package:dartz/dartz.dart';
import '../../../../core/connection/network_info.dart';
import '../../../../core/errors/expentions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/repositories/invoice_repository.dart';
import '../datasources/invoice_remote_data_source.dart';
import '../datasources/invoice_local_data_source.dart';

class InvoiceRepositoryImpl implements InvoiceRepository {
  final NetworkInfo networkInfo;
  final InvoiceRemoteDataSource remoteDataSource;
  final InvoiceLocalDataSource localDataSource;

  InvoiceRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<InvoiceEntity>>> getInvoices(
      String xSchema) async {
    if (!await networkInfo.isConnected) {
      // offline: اقرأ من الكاش
      try {
        final cached = await localDataSource.getAllInvoices(); // List<InvoiceModel>
        if (cached.isEmpty) {
          return Left(
            Failure(errMessage: 'لا يوجد اتصال ولا توجد بيانات محفوظة'),
          );
        }
        return Right(cached); // InvoiceModel يرث InvoiceEntity
      } catch (_) {
        return Left(Failure(
            errMessage: 'حدث خطأ أثناء قراءة الفواتير من التخزين المحلي'));
      }
    }

    // online: اِجلب من الـ API
    try {
      final models = await remoteDataSource.getInvoices(xSchema);
      await localDataSource.saveAllInvoices(models);
      return Right(models);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errModel.detail));
    } catch (_) {
      return Left(Failure(errMessage: 'حدث خطأ غير متوقع أثناء جلب الفواتير'));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyInvoice(int invoiceId) async {
    // تحقق محلي فقط
    return Right(unit);
  }
}





// import 'package:dartz/dartz.dart';
// import '../../../../core/connection/network_info.dart';
// import '../../../../core/errors/expentions.dart';
// import '../../../../core/errors/failure.dart';
// import '../../domain/entities/invoice_entity.dart';
// import '../../domain/repositories/invoice_repository.dart';
// import '../datasources/invoice_remote_data_source.dart';
// import '../datasources/invoice_local_data_source.dart';
// import '../models/invoice_model.dart';

// class InvoiceRepositoryImpl implements InvoiceRepository {
//   final NetworkInfo networkInfo;
//   final InvoiceRemoteDataSource remoteDataSource;
//   final InvoiceLocalDataSource localDataSource;

//   InvoiceRepositoryImpl({
//     required this.networkInfo,
//     required this.remoteDataSource,
//     required this.localDataSource,
//   });

//   @override
//   Future<Either<Failure, List<InvoiceEntity>>> getInvoices(
//       String xSchema) async {
//     if (!await networkInfo.isConnected) {
//       try {
//         final cached = await localDataSource.getAllInvoices();
//         if (cached.isEmpty) {
//           return Left(
//               Failure(errMessage: 'لا يوجد اتصال ولا توجد بيانات محفوظة'));
//         }
//         return Right(cached);
//       } catch (_) {
//         return Left(Failure(
//             errMessage: 'حدث خطأ أثناء قراءة الفواتير من التخزين المحلي'));
//       }
//     }

//     try {
//       final list = await remoteDataSource.getInvoices(xSchema);
//       // حفظ الفواتير في الكاش بعد النجاح
//       await localDataSource.saveAllInvoices(
//         list
//             .map((e) => InvoiceModel(
//                   id: e.id,
//                   weightCard: e.weightCard,
//                   invoiceMaterials: e.invoiceMaterials,
//                   emptyWeightInv: e.emptyWeightInv, // Make sure e has this property
//                   loadedWeightInv: e.loadedWeightInv, // Make sure e has this property
//                   datetime: e.datetime,
//                   netWeight: e.netWeight,
//                 ))
//             .toList(),
//       );
//       return Right(list);
//     } on ServerException catch (e) {
//       return Left(Failure(errMessage: e.errModel.detail));
//     } catch (_) {
//       return Left(Failure(errMessage: 'حدث خطأ غير متوقع أثناء جلب الفواتير'));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> verifyInvoice(int invoiceId) async {
//     return Right(unit);
//   }
// }




// import 'package:dartz/dartz.dart';
// import '../../../../core/connection/network_info.dart';
// import '../../../../core/databases/api/api_consumer.dart';
// import '../../../../core/errors/expentions.dart';
// import '../../../../core/errors/failure.dart';
// import '../../domain/entities/invoice_entity.dart';
// import '../../domain/repositories/invoice_repository.dart';
// import '../datasources/invoice_remote_data_source.dart';

// class InvoiceRepositoryImpl implements InvoiceRepository {
//   final NetworkInfo networkInfo;
//   final InvoiceRemoteDataSource remoteDataSource;
//   final ApiConsumer api;

//   InvoiceRepositoryImpl({
//     required this.networkInfo,
//     required this.remoteDataSource,
//     required this.api,
//   });

//   @override
//   Future<Either<Failure, List<InvoiceEntity>>> getInvoices(String xSchema) async {
//     if (!await networkInfo.isConnected) {
//       return Left(Failure(errMessage: 'لا يوجد اتصال بالإنترنت'));
//     }
//     try {
//       final list = await remoteDataSource.getInvoices(xSchema);
//       return Right(list);
//     } on ServerException catch (e) {
//       return Left(Failure(errMessage: e.errModel.detail));
//     } catch (_) {
//       return Left(Failure(errMessage: 'حدث خطأ غير متوقع أثناء جلب الفواتير'));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> verifyInvoice(int invoiceId) async {
//     // هنا فقط نخزن محلياً، لذا نرجع Right(unit) مباشرة
//     return Right(unit);
//   }

// }
