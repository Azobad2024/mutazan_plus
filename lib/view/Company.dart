import 'package:flutter/material.dart';
import 'package:mutazan_plus/view/widgets/company_list_widget.dart';
import 'package:mutazan_plus/view/widgets/container_radius.dart';
import 'package:mutazan_plus/view/widgets/custom_navbar.dart';
import '../app_colors.dart';

class CompanyPage extends StatelessWidget {
  static String routeName = "/Company";

  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          "الشركات",
          style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ContainerRadius(
              child: Container(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: CompanyListWidget()), // قائمة الشركات
            ),
          ),
          NavigationBarItems(selectedIndex: 1),
        ],
      ),

      // body: Column(
      //   children: [
      //     const SizedBox(height: 50),
      //     Expanded(
      //       child: Container(
      //         child: Column(
      //           children: [
      //             Expanded(
      //               child: CompanyListWidget(), // تم إزالة SingleChildScrollView
      //             ),
      //             NavigationBarItems(selectedIndex: 1),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:mutazan_plus/view/widgets/company_list_widget.dart';
// import 'package:mutazan_plus/view/widgets/container_radius.dart';
// import 'package:mutazan_plus/view/widgets/custom_navbar.dart';
//
// import '../app_colors.dart';
//
// class Company extends StatelessWidget {
//   static String routeName = "/Company";
//
//   const Company({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor, // اللون الأساسي للخلفية
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         title: const Text(
//           "الشركات",
//           style: TextStyle(
//               color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
//         ),
//         automaticallyImplyLeading: false, // إخفاء سهم العودة
//       ),
//       body: Column(
//         children: [
//           const SizedBox(height: 50), // مسافة صغيرة من الأعلى
//           Expanded(
//             child: ContainerRadius(
//               child: Column(
//                 children: [
//                   // SizedBox(height: 20,),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Padding(
//                         padding: const EdgeInsets.all(22),
//                         child: CompanyListWidget(),
//                       ),
//                     ),
//                   ),
//                   NavigationBarItems(
//                       selectedIndex: 1), // شريط التنقل ثابت بالأسفل
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
