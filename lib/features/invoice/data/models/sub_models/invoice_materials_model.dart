// lib/features/invoice/data/models/sub_models/invoice_materials_model.dart

import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/features/invoice/domain/entities/sub_entite/invoice_materials_entity.dart';

class InvoiceMaterialsModel extends InvoiceMaterialsEntity {
  final int id;
  final int material; // الكود الداخلي للمادّة إن احتجت له

  InvoiceMaterialsModel({
    required this.id,
    required this.material,
    required super.materialName,
    required super.quantity,
  });

  factory InvoiceMaterialsModel.fromJson(Map<String, dynamic> json) {
    return InvoiceMaterialsModel(
      id: json[ApiKey.id] as int,
      material: json[ApiKey.material] as int,
      materialName: json[ApiKey.materialName] as String,
      quantity: json[ApiKey.quantity] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        ApiKey.id: id,
        ApiKey.material: material,
        ApiKey.materialName: materialName,
        ApiKey.quantity: quantity,
      };
}
