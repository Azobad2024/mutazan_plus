// lib/features/invoice/data/datasources/invoice_remote_data_source.dart

import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../models/invoice_model.dart';

class InvoiceRemoteDataSource {
  final ApiConsumer api;
  InvoiceRemoteDataSource(this.api);

  /// الآن ترجع List<InvoiceModel>
  Future<List<InvoiceModel>> getInvoices(String xSchema) async {
    final raw = await api.get(EndPoint.invoices);
    return (raw as List)
        .map((e) => InvoiceModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> reportInvoice(String path, Map<String, dynamic> data) =>
      api.post(path, data: data);
}




// // lib/features/invoice/data/datasources/invoice_remote_data_source.dart
// import '../../../../core/databases/api/api_consumer.dart';
// import '../../../../core/databases/api/end_points.dart';
// import '../../domain/entities/invoice_entity.dart';


// class InvoiceRemoteDataSource {
//   final ApiConsumer api;
//   InvoiceRemoteDataSource(this.api);

//   Future<List<InvoiceEntity>> getInvoices(String xSchema) async {
//     final response = await api.get(EndPoint.invoices);
//     return (response as List).map((json) {
//       return InvoiceEntity(
//         id: json[ApiKey.id],
//         weightCard: json[ApiKey.weightCard],
//         datetime: DateTime.parse(json[ApiKey.datetime]),
//         netWeight: json[ApiKey.netWeight].toString(),
//         invoiceMaterials: json[ApiKey.invoiceMaterials],
//       );
//     }).toList();
//   }

//   Future<void> reportInvoice(String path, Map<String, dynamic> data) async {
//     await api.post(path, data: data);
//   }
// }
