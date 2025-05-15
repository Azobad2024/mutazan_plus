// lib/features/invoice/domain/usecases/get_invoices.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/invoice_entity.dart';
import '../repositories/invoice_repository.dart';

class GetInvoices {
  final InvoiceRepository repository;
  GetInvoices(this.repository);
  Future<Either<Failure, List<InvoiceEntity>>> call(String xSchema) =>
      repository.getInvoices(xSchema);
}
