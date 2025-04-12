// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// class Invoice {
//   final String invoiceNumber;
//   final String date;
//   final String quantity;
//   final String material;
//   final String netWeight;
//   bool isVerified;
//
//   Invoice({
//     required this.invoiceNumber,
//     required this.date,
//     required this.quantity,
//     required this.material,
//     required this.netWeight,
//     this.isVerified = false,
//   });
// }
//
// class InvoicesController extends GetxController {
//   var isSearching = false.obs;
//   var searchController = TextEditingController();
//   final FocusNode searchFocusNode = FocusNode();
//
//   var invoices = <Invoice>[].obs;
//   var filteredInvoices = <Invoice>[].obs;
//   final List<Invoice> _allInvoices = [];
//
//   @override
//   void onInit() {
//     super.onInit();
//     _allInvoices.addAll([
//       Invoice(
//         invoiceNumber: '35441',
//         date: '2024/02/15',
//         quantity: '1500',
//         material: 'سكر',
//         netWeight: '5000',
//         isVerified: true,
//       ),
//       Invoice(
//         invoiceNumber: '35442',
//         date: '2024/02/16',
//         quantity: '2000',
//         material: 'أرز',
//         netWeight: '6000',
//         isVerified: false,
//       ),
//       Invoice(
//         invoiceNumber: '35443',
//         date: '2024/02/17',
//         quantity: '1700',
//         material: 'قمح',
//         netWeight: '5500',
//         isVerified: false,
//       ),
//     ]);
//     invoices.assignAll(_allInvoices);
//     filteredInvoices.assignAll(_allInvoices);
//   }
//
//   @override
//   void onClose() {
//     searchController.dispose();
//     searchFocusNode.dispose();
//     super.onClose();
//   }
//
//   void verifyInvoice(int index) {
//     invoices[index].isVerified = true;
//     invoices.refresh();
//     filterInvoices(); // إعادة التصفية بعد التحديث
//   }
//
//   void closeSearch() {
//     isSearching.value = false;
//     searchController.clear();
//     searchFocusNode.unfocus();
//     filterInvoices(); // إعادة التعيين
//   }
//
//   void searchInvoices(String query) {
//     if (query.isEmpty) {
//       filteredInvoices.assignAll(invoices);
//     } else {
//       final q = query.toLowerCase();
//       filteredInvoices.assignAll(
//         invoices.where((invoice) =>
//         invoice.invoiceNumber.toLowerCase().contains(q) ||
//             invoice.material.toLowerCase().contains(q)),
//       );
//     }
//   }
//
//   void filterInvoices({bool showPending = false}) {
//     if (showPending) {
//       filteredInvoices.assignAll(
//         invoices.where((invoice) => !invoice.isVerified).toList(),
//       );
//     } else {
//       filteredInvoices.assignAll(invoices);
//     }
//   }
//
//   int get pendingInvoices => invoices.where((i) => !i.isVerified).length;
//
//   int get totalInvoices => invoices.length;
//
//   List<Invoice> getPendingInvoices() =>
//       invoices.where((i) => !i.isVerified).toList();
//
//   List<Invoice> getAllInvoices() => invoices;
// }



import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class InvoicesController extends GetxController {
  var isSearching = false.obs;
  var searchController = TextEditingController();
  var invoices = <Map<String, dynamic>>[].obs;
  var filteredInvoices = <Map<String, dynamic>>[].obs; // متغير جديد للفواتير المفلترة
  final _allInvoices = <Map<String, dynamic>>[];
  final FocusNode searchFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    _allInvoices.addAll([
      {
        'invoiceNumber': '35441',
        'date': '2024/02/15',
        'quantity': '1500',
        'material': 'سكر',
        'netWeight': '5000',
        'isVerified': true,
      },
      {
        'invoiceNumber': '35442',
        'date': '2024/02/16',
        'quantity': '2000',
        'material': 'أرز',
        'netWeight': '6000',
        'isVerified': false,
      },
      {
        'invoiceNumber': '35443',
        'date': '2024/02/17',
        'quantity': '1700',
        'material': 'قمح',
        'netWeight': '5500',
        'isVerified': false,
      },
    ]);
    invoices.assignAll(_allInvoices);
    filteredInvoices.assignAll(_allInvoices); // تعيين القائمة الكاملة للفواتير المفلترة
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  // دالة لتحديث حالة الفاتورة
  void verifyInvoice(int index) {
    invoices[index]['isVerified'] = true;
    invoices.refresh();
    filterInvoices(); // تحديث الفواتير المفلترة بعد التحقق
  }

  // دالة لإغلاق البحث
  void closeSearch() {
    isSearching.value = false;
    searchController.clear();
    searchFocusNode.unfocus();
    filterInvoices(); // إعادة تعيين الفواتير المفلترة بعد إغلاق البحث
  }

  // دالة للبحث في الفواتير
  void searchInvoices(String query) {
    if (query.isEmpty) {
      filteredInvoices.assignAll(invoices); // إعادة تعيين القائمة الكاملة
    } else {
      filteredInvoices.assignAll(invoices.where((invoice) =>
      invoice['invoiceNumber'].contains(query) ||
          invoice['material'].contains(query)));
    }
  }

  // دالة لفلترة الفواتير بناءً على الحالة (معلقة أو كل الفواتير)
  void filterInvoices({bool showPending = false}) {
    if (showPending) {
      filteredInvoices.assignAll(invoices.where((invoice) => !invoice['isVerified']).toList());
    } else {
      filteredInvoices.assignAll(invoices);
    }
  }

  // عدد الفواتير المعلقة
  int get pendingInvoices {
    return invoices.where((invoice) => !invoice['isVerified']).length;
  }

  // إجمالي الفواتير
  int get totalInvoices {
    return invoices.length;
  }

  // الحصول على الفواتير المعلقة
  List<Map<String, dynamic>> getPendingInvoices() {
    return invoices.where((invoice) => !invoice['isVerified']).toList();
  }

  // الحصول على جميع الفواتير
  List<Map<String, dynamic>> getAllInvoices() {
    return invoices;
  }
}