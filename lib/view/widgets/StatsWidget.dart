import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'stat_card.dart';
import '../../controler/bills_controller.dart'; // استيراد الـ Controller
import 'filtered_invoices_screen.dart'; // استيراد الصفحة الجديدة

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // تهيئة الـ Controller
    final InvoicesController controller = Get.put(InvoicesController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // عرض عدد الفواتير المعلقة
          Obx(() => GestureDetector(
            onTap: () {
              // الانتقال إلى صفحة الفواتير المعلقة
              Get.to(
                    () => FilteredInvoicesScreen(
                  companyName: "companyName".tr, // استخدام الترجمة
                  companyImag: "companyImage".tr, // استخدام الترجمة
                  showPending: true, // عرض الفواتير المعلقة
                ),
              );
            },
            child: StatCard(
              assetIcon: "assets/icons/arrow.png",
              title: 'pendingInvoices'.tr, // استخدام الترجمة
              value: '${controller.pendingInvoices}',
              iconColor: Colors.green, // تحديد اللون
              iconRotation: 80,
            ),
          )),
          Container(
            width: 2,
            height: 60,
            color: Colors.grey[300],
          ),
          // عرض إجمالي الفواتير
          Obx(() => GestureDetector(
            onTap: () {
              // الانتقال إلى صفحة إجمالي الفواتير
              Get.to(
                    () => FilteredInvoicesScreen(
                  companyName: "companyName".tr, // استخدام الترجمة
                  companyImag: "companyImage".tr, // استخدام الترجمة
                  showPending: false, // عرض جميع الفواتير
                ),
              );
            },
            child: StatCard(
              iconRotation: 80,
              assetIcon: "assets/icons/arrow.png",
              title: 'totalInvoices'.tr, // استخدام الترجمة
              value: '${controller.totalInvoices}',
              iconColor: Colors.blue, // تحديد اللون
            ),
          )),
        ],
      ),
    );
  }
}