// lib/features/invoice/data/datasources/invoice_remote_data_source.dart
import '../../../../core/databases/api/api_consumer.dart';
import '../../../../core/databases/api/end_points.dart';
import '../../domain/entities/invoice_entity.dart';

// lib/features/invoice/data/datasources/invoice_remote_data_source.dart
import '../../../../core/databases/api/api_consumer.dart';

class InvoiceRemoteDataSource {
  final ApiConsumer api;
  InvoiceRemoteDataSource(this.api);

  Future<List<InvoiceEntity>> getInvoices(String xSchema) async {
    final response = await api.get(EndPoint.invoices);
    return (response as List).map((json) {
      return InvoiceEntity(
        id: json[ApiKey.id],
        weightCard: json[ApiKey.weightCard],
        material: json[ApiKey.material],
        quantity: json[ApiKey.quantity].toString(),
        datetime: DateTime.parse(json[ApiKey.datetime]),
        netWeight: json[ApiKey.netWeight].toString(),
      );
    }).toList();
  }

  Future<void> reportInvoice(String path, Map<String, dynamic> data) async {
    await api.post(path, data: data);
  }
}





// // lib/features/invoice/data/datasources/invoice_remote_data_source.dart

// import '../../../../core/databases/api/api_consumer.dart';
// import '../../../../core/databases/api/end_points.dart';
// import '../../domain/entities/invoice_entity.dart';

// class InvoiceRemoteDataSource {
//   final ApiConsumer api;
//   InvoiceRemoteDataSource(this.api);

//   Future<List<InvoiceEntity>> getInvoices() async {
//     final response = await api.get(EndPoint.invoices);
//     // نتوقع قائمة JSON
//     return (response as List).map((json) {
//       return InvoiceEntity(
//         id: json[ApiKey.id],
//         weightCard: json[ApiKey.weightCard],
//         material: json[ApiKey.material],
//         quantity: json[ApiKey.quantity],
//         datetime: DateTime.parse(json[ApiKey.datetime]),
//         netWeight: json[ApiKey.netWeight],
//       );
//     }).toList();
//   }
// }
