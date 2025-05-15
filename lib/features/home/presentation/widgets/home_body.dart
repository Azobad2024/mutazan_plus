// lib/features/home/presentation/widgets/home_body.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/features/company/presentation/cubit/company_cubit.dart';
import 'package:mutazan_plus/features/company/presentation/pages/companies_page.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Expanded(
          child: BlocProvider<CompanyCubit>(
            create: (_) => getIt<CompanyCubit>()..fetchCompanies(),
            child: const CompaniesPage(),
          ),
        ),
        // شريط التنقل ثابت أسفل الصندوق
        
      ],
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:mutazan_plus/core/services/services_locator.dart';
// import 'package:mutazan_plus/features/company/presentation/cubit/company_cubit.dart';
// import 'package:mutazan_plus/features/company/presentation/pages/companies_page.dart';
// import '../../../controler/home_controller.dart';
// // import 'company_list_widget.dart';
// import '../../../../core/widgets/custom_navbar.dart';
// import 'header_row_widget.dart';
// import 'StatsRowWidget.dart';

// class Homebody extends StatelessWidget {
//   const Homebody({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final HomeController controller = Get.put(HomeController());

//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
//             child: Column(
//               children: [
//                 const SizedBox(height: 8),
//                 StatsRowWidget(),
//                 const SizedBox(height: 10),
//                 HeaderRowWidget(),
//                 const SizedBox(height: 6),
//                 Expanded(
//                   child: BlocProvider<CompanyCubit>(
//                     create: (_) => getIt<CompanyCubit>()..fetchCompanies(),
//                     child: const CompaniesPage(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Obx(() =>
//             NavigationBarItems(selectedIndex: controller.selectedIndex.value)),
//       ],
//     );
//   }
// }
