import 'package:mutazan_plus/core/databases/api/end_points.dart';

import '../../domain/entities/invoice_entity.dart';

class InvoiceModel extends InvoiceEntity {
  InvoiceModel({
    required super.id,
    required super.weightCard,
    required super.material,
    required super.quantity,
    required super.datetime,
    required super.netWeight,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json[ApiKey.invoiceId] as int,
      weightCard: json[ApiKey.weightCard] as int,
      material: json[ApiKey.material] as int,
      quantity: json[ApiKey.quantity] as String,
      datetime: json[ApiKey.datetime] as DateTime,
      netWeight: json[ApiKey.netWeight] as String,
    );
  }
}
