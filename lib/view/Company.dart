import 'package:flutter/material.dart';
import 'package:mutazan_plus/view/widgets/company_list_widget.dart';
import 'package:mutazan_plus/view/widgets/container_radius.dart';
import 'package:mutazan_plus/view/widgets/custom_navbar.dart';

import '../constants.dart';

class Company extends StatelessWidget {
  static String routeName = "/Company";

  const Company({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // اللون الأساسي للخلفية
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("الشركات",style: TextStyle(color: Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
        automaticallyImplyLeading: false, // إخفاء سهم العودة
      ),
      body: Column(
        children: [
          const SizedBox(height: 50), // مسافة صغيرة من الأعلى
          Expanded(
            child: ContainerRadius(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(22),
                        child: CompanyListWidget(),
                      ),
                    ),
                  ),
                  NavigationBarItems(selectedIndex: 1), // شريط التنقل ثابت بالأسفل
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:mutazan_plus/view/widgets/company_list_widget.dart';
// import 'package:mutazan_plus/view/widgets/container_radius.dart';
// import 'package:mutazan_plus/view/widgets/custom_navbar.dart';
// import 'package:mutazan_plus/view/widgets/home_body.dart';
//
// import '../constants.dart';
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
//       body: Container(
//         child: Column(
//           children: [
//             SizedBox(height: 100,),
//             Expanded(
//               child: ContainerRadius(
//                 child: SingleChildScrollView(
//                   child: Container(
//                     padding: EdgeInsets.all(16),
//                     child: CompanyListWidget(),
//                   ), // المحتوى المتحرك داخل ContainerRadius
//                 ),
//               ),
//             ),
//             NavigationBarItems(selectedIndex: 1),
//           ],
//         ),
//       ),
//
//     );
//   }
// }
