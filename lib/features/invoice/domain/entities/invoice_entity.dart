// lib/features/invoice/domain/entities/invoice_entity.dart

enum ViolationType {
  wrongDirection(1),
  noPlate(2),
  noWeightCard(3),
  overweight(4),
  incompleteData(5),
  invalidInvoice(6);

  final int id;
  const ViolationType(this.id);
}

class InvoiceEntity {
  final int id;
  final int weightCard;
  final int material;
  final String quantity;
  final DateTime datetime;
  final String netWeight;
  bool isVerified; // قابل للتغيير عند التحقق

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



// class InvoiceEntity {
//   final int id;
//   final int weightCard;
//   final int material;
//   final String quantity;
//   final DateTime  datetime;
//   final String netWeight;
//   // final bool isVerified;

//   const InvoiceEntity({
//     required this.id,
//     required this.weightCard,
//     required this.material,
//     required this.quantity,
//     required this.datetime,
//     required this.netWeight,
//     // this.isVerified = false,
//   });
// }
