// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mutazan_plus/core/utils/app_assets.dart';
// import 'package:mutazan_plus/core/utils/app_strings.dart';
// import 'package:mutazan_plus/features/home/presentation/widgets/stat_card.dart';
// import '../../features/invoice/presentation/cubit/invoice_cubit.dart';
// import '../../features/invoice/presentation/cubit/invoice_state.dart';

// class StatsWidget extends StatelessWidget {
//   const StatsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<InvoiceCubit, InvoiceState>(
//       builder: (context, state) {
//         if (state is InvoiceLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (state is InvoiceFailure) {
//           return Center(child: Text(state.message));
//         }
//         final allInvoices = (state as InvoiceSuccess).invoices;
//         final pendingCount = allInvoices.where((inv) => !inv.isVerified).length;
//         final totalCount = allInvoices.length;

//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // الفواتير المعلقة
//               GestureDetector(
//                 onTap: () {
//                   context.go('/filtered-invoices?pending=true');
//                 },
//                 child: StatCard(
//                   assetIcon: Assets.imagesArrow,
//                   title: AppStrings.pendingInvoices.tr,
//                   value: '$pendingCount',
//                   iconColor: Colors.orange,
//                   iconRotation: 80,
//                 ),
//               ),
//               Container(width: 2, height: 60, color: Colors.grey[300]),
//               // إجمالي الفواتير
//               GestureDetector(
//                 onTap: () {
//                   context.go('/filtered-invoices?pending=false');
//                 },
//                 child: StatCard(
//                   assetIcon: Assets.imagesArrow,
//                   title: AppStrings.totalInvoices.tr,
//                   value: '$totalCount',
//                   iconColor: Colors.blue,
//                   iconRotation: 80,
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import '../../features/home/presentation/widgets/stat_card.dart';
import '../../features/controler/bills_controller.dart'; // استيراد الـ Controller
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
              customNavigat(context, '/filtered-invoices', extra: {
                    'companyName': 'companyName'.tr,
                    'companyImag': 'companyImage'.tr,
                    'showPending': true,
                  });
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
               customNavigat(context, '/filtered-invoices', extra: {
                    'companyName': 'companyName'.tr,
                    'companyImag': 'companyImage'.tr,
                    'showPending': false,// عرض جميع الفواتير
                  });
            },
            child: StatCard(
              iconRotation: 80,
              assetIcon: "assets/icons/arrow.png",
              title: 'totalInvoices'.tr, 
              value: '${controller.totalInvoices}',
              iconColor: Colors.blue, 
            ),
          )),
        ],
      ),
    );
  }
}