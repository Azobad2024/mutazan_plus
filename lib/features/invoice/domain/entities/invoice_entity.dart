// lib/features/invoice/domain/entities/invoice_entity.dart

import 'package:mutazan_plus/features/invoice/domain/entities/sub_entite/invoice_materials_entity.dart';

class InvoiceEntity {
  final int id;
  final int weightCard;
  final DateTime datetime;
  final String netWeight;
  final List<InvoiceMaterialsEntity> invoiceMaterials;  // ← قائمة
  bool isVerified;

  InvoiceEntity({
    required this.id,
    required this.weightCard,
    required this.datetime,
    required this.netWeight,
    required this.invoiceMaterials,
    this.isVerified = false,
  });

  // اختصارات للوصول إلى أول مادة (التي سنعرضها في الكرت)
  String get materialName =>
      invoiceMaterials.isNotEmpty ? invoiceMaterials.first.materialName : '';

  String get quantity =>
      invoiceMaterials.isNotEmpty ? invoiceMaterials.first.quantity : '';
}
