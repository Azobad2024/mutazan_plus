// lib/features/invoice/data/datasources/invoice_local_data_source.dart

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/invoice_model.dart';

class InvoiceLocalDataSource {
  static const _invoicesKey = 'saved_invoices';
  static const _verifiedKey = 'verified_invoices';

  Future<void> saveAllInvoices(List<InvoiceModel> invoices) async {
    final prefs = await SharedPreferences.getInstance();
    final enc = invoices.map((inv) => jsonEncode(inv.toJson())).toList();
    await prefs.setStringList(_invoicesKey, enc);
  }

  Future<List<InvoiceModel>> getAllInvoices() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_invoicesKey) ?? [];
    final verifiedIds = prefs.getStringList(_verifiedKey)
                          ?.map(int.parse)
                          .toSet() ?? {};

    return data.map((str) {
      final model = InvoiceModel.fromJson(jsonDecode(str));
      // هنا نضع isVerified
      if (verifiedIds.contains(model.id)) {
        model.isVerified = true;
      }
      return model;
    }).toList();
  }

  Future<void> markInvoiceVerified(int id) async {
    final prefs = await SharedPreferences.getInstance();
    // نأخذ القائمة القديمة أو فارغة
    final vList = prefs.getStringList(_verifiedKey) ?? [];
    if (!vList.contains(id.toString())) {
      vList.add(id.toString());
      await prefs.setStringList(_verifiedKey, vList);
    }
  }

  Future<void> clearInvoices() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_invoicesKey);
    await prefs.remove(_verifiedKey);  // ننظف القائمة كذلك
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
