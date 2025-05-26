// lib/features/home/presentation/widgets/stats_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/stat_card.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_state.dart';

class StatsWidget extends StatelessWidget {
  const StatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final hp = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 16,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.MOBILE, value: 24),
        responsive.Condition.largerThan(name: responsive.TABLET, value: 32),
      ],
    ).value;
    final dividerHeight = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 60,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 80),
      ],
    ).value;

    return BlocBuilder<InvoiceCubit, InvoiceState>(
      builder: (context, state) {
        if (state is InvoiceLoading || state is InvoiceInitial) {
          // أثناء التحميل أو الحالة الابتدائية
          return const Center(child: CircularProgressIndicator());
        }
        if (state is InvoiceFailure) {
          return Center(child: Text(state.message));
        }
        if (state is InvoiceSuccess) {
          final invoices = state.invoices;
          final pendingCount = invoices.where((inv) => !inv.isVerified).length;
          final totalCount = invoices.length;

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: hp),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        customNavigat(context, '/filtered-invoices', extra: {
                      'title': AppStrings.pendingInvoices.tr,
                      'showPending': true,
                    }),
                    child: StatCard(
                      title: AppStrings.pendingInvoices.tr,
                      value: '$pendingCount',
                      assetIcon: 'assets/icons/arrow.png',
                      iconColor: Colors.green,
                      iconRotation: 80,
                    ),
                  ),
                ),
                SizedBox(width: hp * 0.5),
                Container(
                    width: 1.5,
                    height: dividerHeight,
                    color: AppColors.lightGrey),
                SizedBox(width: hp * 0.5),
                Expanded(
                  child: GestureDetector(
                    onTap: () =>
                        customNavigat(context, '/filtered-invoices', extra: {
                      'title': AppStrings.totalInvoices.tr,
                      'showPending': false,
                    }),
                    child: StatCard(
                      title: AppStrings.totalInvoices.tr,
                      value: '$totalCount',
                      assetIcon: 'assets/icons/arrow.png',
                      iconColor: Colors.blue,
                      iconRotation: 80,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        // حالة غير متوقعة
        return const SizedBox.shrink();
      },
    );
  }
}


// // lib/features/home/presentation/widgets/stats_widget.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:responsive_framework/responsive_framework.dart' as responsive;
// import 'package:mutazan_plus/core/functions/navigation.dart';
// import 'package:mutazan_plus/core/utils/app_colors.dart';
// import 'package:mutazan_plus/core/utils/app_strings.dart';
// import 'package:mutazan_plus/features/home/presentation/widgets/stat_card.dart';
// import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
// import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_state.dart';

// class StatsWidget extends StatelessWidget {
//   const StatsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // مسافة جانبية متجاوبة
//     final hp = responsive.ResponsiveValue<double>(
//       context,
//       defaultValue: 16,
//       conditionalValues: [
//         responsive.Condition.largerThan(name: responsive.MOBILE, value: 24),
//         responsive.Condition.largerThan(name: responsive.TABLET, value: 32),
//       ],
//     ).value!;

//     // ارتفاع الفاصل العمودي متجاوب
//     final dividerHeight = responsive.ResponsiveValue<double>(
//       context,
//       defaultValue: 60,
//       conditionalValues: [
//         responsive.Condition.largerThan(name: responsive.TABLET, value: 80),
//       ],
//     ).value!;

//     return BlocBuilder<InvoiceCubit, InvoiceState>(
//       builder: (context, state) {
//         if (state is InvoiceLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (state is InvoiceFailure) {
//           return Center(child: Text(state.message));
//         }
//         // عند النجاح
//         final invoices = (state as InvoiceSuccess).invoices;
//         final pendingCount = invoices.where((inv) => !inv.isVerified).length;
//         final totalCount = invoices.length;

//         return Padding(
//           padding: EdgeInsets.symmetric(horizontal: hp),
//           child: Row(
//             children: [
//               // بطاقة الفواتير المعلقة
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () => customNavigat(
//                     context,
//                     '/filtered-invoices',
//                     extra: {
//                       'title': AppStrings.pendingInvoices.tr,
//                       'showPending': true,
//                     },
//                   ),
//                   child: StatCard(
//                     title: AppStrings.pendingInvoices.tr,
//                     value: '$pendingCount',
//                     assetIcon: 'assets/icons/arrow.png',
//                     iconColor: Colors.green,
//                     iconRotation: 80,
//                   ),
//                 ),
//               ),

//               // مسافة وفاصل بسيط
//               SizedBox(width: hp * 0.5),
//               Container(
//                 width: 1.5,
//                 height: dividerHeight,
//                 color: AppColors.lightGrey,
//               ),
//               SizedBox(width: hp * 0.5),

//               // بطاقة إجمالي الفواتير
//               Expanded(
//                 child: GestureDetector(
//                   onTap: () => customNavigat(
//                     context,
//                     '/filtered-invoices',
//                     extra: {
//                       'title': AppStrings.totalInvoices.tr,
//                       'showPending': false,
//                     },
//                   ),
//                   child: StatCard(
//                     title: AppStrings.totalInvoices.tr,
//                     value: '$totalCount',
//                     assetIcon: 'assets/icons/arrow.png',
//                     iconColor: Colors.blue,
//                     iconRotation: 80,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }




// // // lib/features/home/presentation/widgets/stats_widget.dart

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:mutazan_plus/core/functions/navigation.dart';
// // import 'package:mutazan_plus/core/utils/app_colors.dart';
// // import '../../controler/bills_controller.dart';
// // import '../../home/presentation/widgets/stat_card.dart';

// // class StatsWidget extends StatelessWidget {
// //   const StatsWidget({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     final InvoicesController controller = Get.put(InvoicesController());
// //     final size = MediaQuery.of(context).size;
// //     final isLandscape =
// //         MediaQuery.of(context).orientation == Orientation.landscape;

// //     // حساب أحجام مرنة
// //     final horizontalPadding = size.width * 0.04;     // ~16px على 400px
// //     final cardWidth = (size.width - horizontalPadding * 2) / 2 - 8;
// //     final dividerHeight = isLandscape ? size.height * 0.12 : size.height * 0.08;
// //     final dividerWidth = 1.5;

// //     return Padding(
// //       padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
// //       child: Row(
// //         children: [
// //           // بطاقة الفواتير المعلقة
// //           Expanded(
// //             child: Obx(
// //               () => GestureDetector(
// //                 onTap: () => customNavigat(
// //                   context,
// //                   '/filtered-invoices',
// //                   extra: {
// //                     'companyName': 'companyName'.tr,
// //                     'companyImag': 'companyImage'.tr,
// //                     'showPending': true,
// //                   },
// //                 ),
// //                 child: SizedBox(
// //                   width: cardWidth,
// //                   child: StatCard(
// //                     assetIcon: "assets/icons/arrow.png",
// //                     title: 'pendingInvoices'.tr,
// //                     value: '${controller.pendingInvoices}',
// //                     iconColor: Colors.green,
// //                     iconRotation: 80,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),

// //           // الفاصل الرأسي
// //           Padding(
// //             padding: EdgeInsets.symmetric(horizontal: 6),
// //             child: Container(
// //               width: dividerWidth,
// //               height: dividerHeight,
// //               color: AppColors.lightGrey,
// //             ),
// //           ),

// //           // بطاقة إجمالي الفواتير
// //           Expanded(
// //             child: Obx(
// //               () => GestureDetector(
// //                 onTap: () => customNavigat(
// //                   context,
// //                   '/filtered-invoices',
// //                   extra: {
// //                     'companyName': 'companyName'.tr,
// //                     'companyImag': 'companyImage'.tr,
// //                     'showPending': false,
// //                   },
// //                 ),
// //                 child: SizedBox(
// //                   width: cardWidth,
// //                   child: StatCard(
// //                     assetIcon: "assets/icons/arrow.png",
// //                     title: 'totalInvoices'.tr,
// //                     value: '${controller.totalInvoices}',
// //                     iconColor: Colors.blue,
// //                     iconRotation: 80,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
