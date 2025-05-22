// lib/features/invoice/presentation/cubit/invoice_state.dart

import 'package:equatable/equatable.dart';
import '../../domain/entities/invoice_entity.dart';

abstract class InvoiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceSuccess extends InvoiceState {
  final List<InvoiceEntity> invoices;
  InvoiceSuccess(this.invoices);
  @override
  List<Object?> get props => [invoices];
}

class InvoiceFailure extends InvoiceState {
  final String message;
  InvoiceFailure(this.message);
  @override
  List<Object?> get props => [message];
}
class InvoiceActionInProgress extends InvoiceState {}
class InvoiceActionSuccess    extends InvoiceState {}
class InvoiceActionFailure    extends InvoiceState {
  final String message;
  InvoiceActionFailure(this.message);
  @override List<Object?> get props => [message];
}
