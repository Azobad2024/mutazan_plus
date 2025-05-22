// lib/features/invoice/domain/entities/invoice_entity.dart

class InvoiceEntity {
  final int id;
  final int weightCard;
  final int material;
  final String quantity;
  final DateTime datetime;
  final String netWeight;
  bool isVerified;

  InvoiceEntity({
    required this.id,
    required this.weightCard,
    required this.material,
    required this.quantity,
    required this.datetime,
    required this.netWeight,
    this.isVerified = false,
  });
}