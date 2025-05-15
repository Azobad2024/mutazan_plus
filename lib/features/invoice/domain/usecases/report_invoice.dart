import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../repositories/invoice_repository.dart';

class ReportInvoice {
  final InvoiceRepository repository;
  ReportInvoice(this.repository);

  Future<Either<Failure, Unit>> call(int id, int violationId) =>
      repository.reportInvoice(id, violationId);
}
