import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/features/company/presentation/pages/companies_page.dart';
import 'package:mutazan_plus/core/widgets/container_radius.dart';
import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          automaticallyImplyLeading: false,
          centerTitle: true,  // لمحاذاة العنوان في المنتصف
          title: const Text(
            'الشركات',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w900,  // وزن أثقل من bold
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ContainerRadius(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  child: const CompaniesPage(),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BlocBuilder<NavCubit, int>(
          builder: (context, selectedIndex) {
            return Container(
              color: AppColors.White,
              child: NavigationBarItems(
                showBarcode: false,
              ),
            );
          },
        ),
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mutazan_plus/core/utils/app_colors.dart';
// import 'package:mutazan_plus/features/company/presentation/pages/companies_page.dart';
// import 'package:mutazan_plus/core/widgets/container_radius.dart';
// import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
// import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';

// class CompanyPage extends StatelessWidget {
//   // static String routeName = "/Company";

//   const CompanyPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => NavCubit(),
//       child: Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         appBar: AppBar(
//           backgroundColor: AppColors.backgroundColor,
//           title: const Text(
//             "الشركات",
//             style: TextStyle(
//                 color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
//           ),
//           automaticallyImplyLeading: false,
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               child: ContainerRadius(
//                 child: Container(
//                   padding:
//                       const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
//                   child: CompaniesPage(),
//                   // BlocProvider(
//                   //   create: (_) => getIt<CompanyCubit>()..fetchCompanies(),
//                   //   child: const CompaniesPage(),
//                   // ),
//                   //CompanyListWidget()
//                 ), // قائمة الشركات
//               ),
//             ),
//             // NavigationBarItems(selectedIndex: 1),
//           ],
//         ),
//         bottomNavigationBar: Container(
//           color: AppColors.White,
//           padding: const EdgeInsets.symmetric(vertical: 0),
//           child: const NavigationBarItems(showBarcode: false),
//         ),
//       ),
//     );
//   }
// }
