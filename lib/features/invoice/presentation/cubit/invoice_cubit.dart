import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/usecases/get_invoices.dart';
import '../../domain/usecases/verify_invoice.dart';
import '../../domain/usecases/report_invoice.dart';
import 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final GetInvoices getInvoices;
  final VerifyInvoice verifyInvoiceUseCase;
  final ReportInvoice reportInvoiceUseCase;

  InvoiceCubit({
    required this.getInvoices,
    required this.verifyInvoiceUseCase,
    required this.reportInvoiceUseCase,
  }) : super(InvoiceInitial());

  Future<void> fetchInvoices(String xSchema) async {
    emit(InvoiceLoading());
    final Either<Failure, List<InvoiceEntity>> result = await getInvoices(xSchema);
    result.fold(
      (f) => emit(InvoiceFailure(f.errMessage)),
      (list) => emit(InvoiceSuccess(list)),
    );
  }

  Future<Either<Failure, Unit>> verify(int id) =>
    verifyInvoiceUseCase(id);

  Future<Either<Failure, Unit>> report(int id, int violationId) =>
    reportInvoiceUseCase(id, violationId);
}



// // lib/features/invoice/presentation/cubit/invoice_cubit.dart

// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/failure.dart';
// import '../../domain/entities/invoice_entity.dart';
// import '../../domain/usecases/get_invoices.dart';
// import 'invoice_state.dart';

// class InvoiceCubit extends Cubit<InvoiceState> {
//   final GetInvoices getInvoices;
//   InvoiceCubit({required this.getInvoices}) : super(InvoiceInitial());

//   Future<void> fetchInvoices(String xSchema) async {
//     emit(InvoiceLoading());
//     final Either<Failure, List<InvoiceEntity>> result = await getInvoices(xSchema);
//     result.fold(
//       (f) => emit(InvoiceFailure(f.errMessage)),
//       (list) => emit(InvoiceSuccess(list)),
//     );
//   }
// }
