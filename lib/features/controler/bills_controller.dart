// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// // import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// class InvoicesController extends GetxController {
//   var isSearching = false.obs;
//   var searchController = TextEditingController();
//   var invoices = <Map<String, dynamic>>[].obs;
//   var filteredInvoices = <Map<String, dynamic>>[].obs; // متغير جديد للفواتير المفلترة
//   final _allInvoices = <Map<String, dynamic>>[];
//   final FocusNode searchFocusNode = FocusNode();

//   @override
//   void onInit() {
//     super.onInit();
//     _allInvoices.addAll([
//       {
//         'invoiceNumber': '35441',
//         'date': '2024/02/15',
//         'quantity': '1500',
//         'material': 'سكر',
//         'netWeight': '5000',
//         'isVerified': true,
//       },
//       {
//         'invoiceNumber': '35442',
//         'date': '2024/02/16',
//         'quantity': '2000',
//         'material': 'أرز',
//         'netWeight': '6000',
//         'isVerified': false,
//       },
//       {
//         'invoiceNumber': '35443',
//         'date': '2024/02/17',
//         'quantity': '1700',
//         'material': 'قمح',
//         'netWeight': '5500',
//         'isVerified': false,
//       },
//     ]);
//     invoices.assignAll(_allInvoices);
//     filteredInvoices.assignAll(_allInvoices); // تعيين القائمة الكاملة للفواتير المفلترة
//   }

//   @override
//   void onClose() {
//     searchController.dispose();
//     searchFocusNode.dispose();
//     super.onClose();
//   }

//   // دالة لتحديث حالة الفاتورة
//   void verifyInvoice(int index) {
//     invoices[index]['isVerified'] = true;
//     invoices.refresh();
//     filterInvoices(); // تحديث الفواتير المفلترة بعد التحقق
//   }

//   // دالة لإغلاق البحث
//   void closeSearch() {
//     isSearching.value = false;
//     searchController.clear();
//     searchFocusNode.unfocus();
//     filterInvoices(); // إعادة تعيين الفواتير المفلترة بعد إغلاق البحث
//   }

//   // دالة للبحث في الفواتير
//   void searchInvoices(String query) {
//     if (query.isEmpty) {
//       filteredInvoices.assignAll(invoices); // إعادة تعيين القائمة الكاملة
//     } else {
//       filteredInvoices.assignAll(invoices.where((invoice) =>
//       invoice['invoiceNumber'].contains(query) ||
//           invoice['material'].contains(query)));
//     }
//   }

//   // دالة لفلترة الفواتير بناءً على الحالة (معلقة أو كل الفواتير)
//   void filterInvoices({bool showPending = false}) {
//     if (showPending) {
//       filteredInvoices.assignAll(invoices.where((invoice) => !invoice['isVerified']).toList());
//     } else {
//       filteredInvoices.assignAll(invoices);
//     }
//   }

//   // عدد الفواتير المعلقة
//   int get pendingInvoices {
//     return invoices.where((invoice) => !invoice['isVerified']).length;
//   }

//   // إجمالي الفواتير
//   int get totalInvoices {
//     return invoices.length;
//   }

//   // الحصول على الفواتير المعلقة
//   List<Map<String, dynamic>> getPendingInvoices() {
//     return invoices.where((invoice) => !invoice['isVerified']).toList();
//   }

//   // الحصول على جميع الفواتير
//   List<Map<String, dynamic>> getAllInvoices() {
//     return invoices;
//   }
// }