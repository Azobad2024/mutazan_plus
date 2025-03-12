import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/view/widgets/custom_navbar.dart';
import '../../constants.dart';
import '../../controler/bills_controller.dart';
import '../Bills.dart';

class FilteredInvoicesScreen extends StatelessWidget {
  final String companyName;
  final String companyImag;
  final bool showPending; // معلمة لتحديد ما إذا كان سيتم عرض الفواتير المعلقة

  const FilteredInvoicesScreen({
    super.key,
    required this.companyName,
    required this.companyImag,
    required this.showPending,
  });

  @override
  Widget build(BuildContext context) {
    // تهيئة الـ Controller
    final InvoicesController controller = Get.put(InvoicesController());

    // فلترة البيانات بناءً على المعلمة
    final filteredInvoices = showPending
        ? controller.invoices.where((invoice) => !invoice['isVerified']).toList()
        : controller.invoices;

    return GestureDetector(
      onTap: () {
        // إغلاق الكيبورد عند النقر خارج الحقل
        FocusScope.of(context).unfocus();
        if (controller.isSearching.value) {
          controller.closeSearch();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // منع ظهور الناف بار فوق الكيبورد
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: Row(
            children: [
              Text(
                showPending ? "pendingInvoices".tr : "totalInvoices".tr, // العنوان بناءً على المعلمة
                style: const TextStyle(color: Colors.white),
              ),
              const Spacer(),
              Obx(() {
                if (controller.isSearching.value) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: controller.searchController,
                      focusNode: controller.searchFocusNode, // FocusNode
                      autofocus: false, // لا تظهر الكيبورد تلقائيًا
                      decoration: InputDecoration(
                        hintText: 'searchHint'.tr,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      onChanged: (query) {
                        controller.searchInvoices(query); // البحث عند تغيير النص
                      },
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      controller.isSearching.value = true;
                    },
                    child: Row(
                      children: [
                        Text('search'.tr, style: const TextStyle(color: Colors.white)),
                        const SizedBox(width: 5),
                        const Icon(Icons.search, color: Colors.white),
                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [
              // ✅ القسم العلوي الثابت (تمت إزالة عدد الشاحنات والأيقونة)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // توسيط المحتوى
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("numberOfInvoices".tr,
                            style: const TextStyle(fontSize: 16, color: Colors.black)),
                        Obx(() => Text("${controller.filteredInvoices.length}",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ],
                ),
              ),

              // ✅ قائمة الفواتير
              Expanded(
                child: Obx(() => ListView.builder(
                  itemCount: controller.filteredInvoices.length,
                  itemBuilder: (context, index) {
                    final invoice = controller.filteredInvoices[index];
                    return InvoiceCard(
                      invoiceNumber: invoice['invoiceNumber'],
                      date: invoice['date'],
                      quantity: invoice['quantity'],
                      material: invoice['material'],
                      netWeight: invoice['netWeight'],
                      isVerified: invoice['isVerified'],
                      onVerify: () => controller.verifyInvoice(index),
                    );
                  },
                )),
              ),
              const NavigationBarItems(
                selectedIndex: 5,
                showBarcode: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}