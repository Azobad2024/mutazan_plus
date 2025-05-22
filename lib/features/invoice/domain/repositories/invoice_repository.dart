// lib/features/invoice/domain/repositories/invoice_repository.dart

import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/invoice_entity.dart';

abstract class InvoiceRepository {
  Future<Either<Failure, List<InvoiceEntity>>> getInvoices(String xSchema);
  Future<Either<Failure, Unit>> verifyInvoice(int invoiceId);
}