// ignore_for_file: public_member_api_docs, sort_constructors_first
// lib/features/invoice/data/models/invoice_model.dart

import 'package:mutazan_plus/core/databases/api/end_points.dart';

import '../../domain/entities/invoice_entity.dart';
import 'sub_models/invoice_materials_model.dart';

class InvoiceModel extends InvoiceEntity {
  final int emptyWeightInv;
  final int loadedWeightInv;
  @override
  bool isVerified = false;

  InvoiceModel({
    required super.id,
    required super.weightCard,
    required super.datetime,
    required super.netWeight,
    required List<InvoiceMaterialsModel> super.invoiceMaterials,
    required this.emptyWeightInv,
    required this.loadedWeightInv,
    required this.isVerified,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    final rawMats = json[ApiKey.invoiceMaterials] as List<dynamic>;
    final mats = rawMats
        .map((e) => InvoiceMaterialsModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return InvoiceModel(
      id: json[ApiKey.id] as int,
      weightCard: json[ApiKey.weightCard] as int,
      datetime: DateTime.parse(json[ApiKey.datetime] as String),
      netWeight: json[ApiKey.netWeight] as String,
      emptyWeightInv: json[ApiKey.emptyWeightInv] as int,
      loadedWeightInv: json[ApiKey.loadedWeightInv] as int,
      invoiceMaterials: mats,
      isVerified: json['is_verified'] == true,
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        ApiKey.id: id,
        ApiKey.weightCard: weightCard,
        ApiKey.datetime: datetime.toIso8601String(),
        ApiKey.netWeight: netWeight,
        ApiKey.emptyWeightInv: emptyWeightInv,
        ApiKey.loadedWeightInv: loadedWeightInv,
        ApiKey.invoiceMaterials: invoiceMaterials
            .map((m) => (m as InvoiceMaterialsModel).toJson())
            .toList(),
        ApiKey.isVerified: isVerified,
      };
}



// // lib/features/invoice/data/models/invoice_model.dart

// import 'package:mutazan_plus/core/databases/api/end_points.dart';
// import 'package:mutazan_plus/features/invoice/data/models/sub_models/invoice_materials_model.dart';
// import '../../domain/entities/invoice_entity.dart';

// class InvoiceModel extends InvoiceEntity {
//   final int emptyWeightInv;
//   final int loadedWeightInv;

//   InvoiceModel({
//     required super.id,
//     required super.weightCard,
//     required super.datetime,
//     required super.netWeight,
//     required super.invoiceMaterials,
//     required this.emptyWeightInv,
//     required this.loadedWeightInv,
//   }) : super(
//           invoiceMaterials: super.invoiceMaterials,
//         );

//   factory InvoiceModel.fromJson(Map<String, dynamic> json) {
//     // نحوّل المصفوفة إلى List<InvoiceMaterialsModel>
//     final materialsJson = json[ApiKey.invoiceMaterials] as List<dynamic>;
//     final materials = materialsJson
//         .map((e) => InvoiceMaterialsModel.fromJson(e as Map<String, dynamic>))
//         .toList();

//     return InvoiceModel(
//       id: json[ApiKey.invoiceId] as int,
//       weightCard: json[ApiKey.weightCard] as int,
//       datetime: DateTime.parse(json[ApiKey.datetime] as String),
//       netWeight: json[ApiKey.netWeight] as String,
//       emptyWeightInv: json[ApiKey.emptyWeightInv] as int,
//       loadedWeightInv: json[ApiKey.loadedWeightInv] as int,
//       invoiceMaterials: materials,  // ← تمرير القائمة
//     );
//   }

//   @override
//   Map<String, dynamic> toJson() => {
//         ApiKey.invoiceId: id,
//         ApiKey.weightCard: weightCard,
//         ApiKey.datetime: datetime.toIso8601String(),
//         ApiKey.netWeight: netWeight,
//         ApiKey.emptyWeightInv: emptyWeightInv,
//         ApiKey.loadedWeightInv: loadedWeightInv,
//         ApiKey.invoiceMaterials:
//             invoiceMaterials.map((m) => (m as InvoiceMaterialsModel).toJson()).toList(),
//       };
// }









// import 'package:mutazan_plus/core/databases/api/end_points.dart';
// import 'package:mutazan_plus/features/invoice/data/models/sub_models/invoice_materials_model.dart';
// import '../../domain/entities/invoice_entity.dart';

// class InvoiceModel extends InvoiceEntity {
//   int emptyWeightInv;
//   int loadedWeightInv;
//   InvoiceModel({
//     required super.id,
//     required super.weightCard,
//     required super.datetime,
//     required super.netWeight,
//     required super.invoiceMaterials,
//     required this.emptyWeightInv,
//     required this.loadedWeightInv,
//   });

//   factory InvoiceModel.fromJson(Map<String, dynamic> json) {
//     return InvoiceModel(
//       id: json[ApiKey.invoiceId] as int,
//       weightCard: json[ApiKey.weightCard] as int,
//       datetime: DateTime.parse(json[ApiKey.datetime] as String),
//       netWeight: json[ApiKey.netWeight] as String,
//       emptyWeightInv: json[ApiKey.emptyWeightInv] as int,
//       loadedWeightInv: json[ApiKey.loadedWeightInv] as int, 
//       invoiceMaterials: InvoiceMaterialsModel.fromJson( json[ApiKey.invoiceMaterials]),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       ApiKey.invoiceId: id,
//       ApiKey.weightCard: weightCard,
//       ApiKey.datetime: datetime.toIso8601String(),
//       ApiKey.netWeight: netWeight,
//       ApiKey.emptyWeightInv: emptyWeightInv,
//       ApiKey.loadedWeightInv: loadedWeightInv,
//       ApiKey.invoiceMaterials: invoiceMaterials,

//     };
//   }
// }
