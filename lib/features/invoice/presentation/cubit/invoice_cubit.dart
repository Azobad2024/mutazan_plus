import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/invoice_entity.dart';
import '../../domain/usecases/get_invoices.dart';
import '../../domain/usecases/verify_invoice.dart';
import 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final GetInvoices getInvoices;
  final VerifyInvoice verifyInvoiceUseCase;

  InvoiceCubit({
    required this.getInvoices,
    required this.verifyInvoiceUseCase,
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
}
