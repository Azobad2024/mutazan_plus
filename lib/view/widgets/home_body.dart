import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controler/home_controller.dart';
import 'company_list_widget.dart';
import 'custom_navbar.dart';
import 'header_row_widget.dart';
import 'StatsRowWidget.dart';

class Homebody extends StatelessWidget {
  const Homebody({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                StatsRowWidget(),
                const SizedBox(height: 10),
                HeaderRowWidget(),
                const SizedBox(height: 6),
                Expanded(
                  child: CompanyListWidget(),
                ),
              ],
            ),
          ),
        ),
        Obx(() => NavigationBarItems(selectedIndex: controller.selectedIndex.value)),
      ],
    );
  }
}


// import 'package:flutter/material.dart';
// import 'company_list_widget.dart';
// import 'custom_navbar.dart';
// import 'header_row_widget.dart';
// import 'StatsRowWidget.dart';
//
// class Homebody extends StatelessWidget {
//   const Homebody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.max, // يضمن استخدام كل المساحة المتاحة
//       children: [
//         Expanded(
//           child: Container(
//             padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
//             child: Column(
//               children: [
//                 const SizedBox(height: 8),
//                 StatsRowWidget(), // الصف العلوي للإحصائيات
//                 const SizedBox(height: 10),
//                 HeaderRowWidget(), // صف العناوين (الشركات - الحالة)
//                 const SizedBox(height: 6),
//                 Expanded(
//                   child: CompanyListWidget(), // قائمة الشركات القابلة للتمرير
//                 ),
//               ],
//             ),
//           ),
//         ),
//         NavigationBarItems(selectedIndex: 0),
//       ],
//     );
//   }
// }