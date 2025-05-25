// lib/features/invoice/data/datasources/invoice_local_data_source.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/invoice_model.dart';

class InvoiceLocalDataSource {
  static const _key = 'saved_invoices';

  Future<void> saveAllInvoices(List<InvoiceModel> invoices) async {
    final prefs = await SharedPreferences.getInstance();
    final enc = invoices.map((inv) => jsonEncode(inv.toJson())).toList();
    await prefs.setStringList(_key, enc);
  }

  Future<List<InvoiceModel>> getAllInvoices() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_key) ?? [];
    return data
        .map((str) => InvoiceModel.fromJson(jsonDecode(str)))
        .toList();
  }

  Future<void> clearInvoices() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}



// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../models/invoice_model.dart';

// class InvoiceLocalDataSource {
//   static const String _key = 'saved_invoices';

//   Future<void> saveAllInvoices(List<InvoiceModel> invoices) async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<String> encodedList = invoices
//         .map((invoice) => jsonEncode(invoice.toJson()))
//         .toList();
//     await prefs.setStringList(_key, encodedList);
//   }

//   Future<List<InvoiceModel>> getAllInvoices() async {
//     final prefs = await SharedPreferences.getInstance();
//     final List<String> data = prefs.getStringList(_key) ?? [];
//     return data
//         .map((invoiceStr) => InvoiceModel.fromJson(jsonDecode(invoiceStr)))
//         .toList();
//   }

//   Future<void> clearInvoices() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove(_key);
//   }
// }
