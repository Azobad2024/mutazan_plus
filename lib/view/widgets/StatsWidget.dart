// lib/features/home/presentation/widgets/stats_widget.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import '../../features/controler/bills_controller.dart';
import '../../features/home/presentation/widgets/stat_card.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final InvoicesController controller = Get.put(InvoicesController());
    final size = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    // حساب أحجام مرنة
    final horizontalPadding = size.width * 0.04;     // ~16px على 400px
    final cardWidth = (size.width - horizontalPadding * 2) / 2 - 8;
    final dividerHeight = isLandscape ? size.height * 0.12 : size.height * 0.08;
    final dividerWidth = 1.5;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        children: [
          // بطاقة الفواتير المعلقة
          Expanded(
            child: Obx(
              () => GestureDetector(
                onTap: () => customNavigat(
                  context,
                  '/filtered-invoices',
                  extra: {
                    'companyName': 'companyName'.tr,
                    'companyImag': 'companyImage'.tr,
                    'showPending': true,
                  },
                ),
                child: SizedBox(
                  width: cardWidth,
                  child: StatCard(
                    assetIcon: "assets/icons/arrow.png",
                    title: 'pendingInvoices'.tr,
                    value: '${controller.pendingInvoices}',
                    iconColor: Colors.green,
                    iconRotation: 80,
                  ),
                ),
              ),
            ),
          ),

          // الفاصل الرأسي
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 6),
            child: Container(
              width: dividerWidth,
              height: dividerHeight,
              color: AppColors.lightGrey,
            ),
          ),

          // بطاقة إجمالي الفواتير
          Expanded(
            child: Obx(
              () => GestureDetector(
                onTap: () => customNavigat(
                  context,
                  '/filtered-invoices',
                  extra: {
                    'companyName': 'companyName'.tr,
                    'companyImag': 'companyImage'.tr,
                    'showPending': false,
                  },
                ),
                child: SizedBox(
                  width: cardWidth,
                  child: StatCard(
                    assetIcon: "assets/icons/arrow.png",
                    title: 'totalInvoices'.tr,
                    value: '${controller.totalInvoices}',
                    iconColor: Colors.blue,
                    iconRotation: 80,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
