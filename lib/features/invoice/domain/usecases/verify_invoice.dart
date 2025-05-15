import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/invoice_repository.dart';

class VerifyInvoice {
  final InvoiceRepository repository;
  VerifyInvoice(this.repository);

  Future<Either<Failure, Unit>> call(int id) =>
      repository.verifyInvoice(id);
}
