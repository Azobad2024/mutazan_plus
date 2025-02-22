// import 'package:flutter/material.dart';
//
// import 'company_list_widget.dart';
// import 'header_row_widget.dart';
// import 'StatsRowWidget.dart';
//
// class Homebody extends StatelessWidget {
//   const Homebody({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const SizedBox(height: 8,),
//               StatsRowWidget(), // الصف العلوي للإحصائيات
//               const SizedBox(height: 10),
//               HeaderRowWidget(), // صف العناوين (الشركات - الحالة)
//               const SizedBox(height: 10),
//               CompanyListWidget(), // قائمة الشركات
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//

import 'package:flutter/material.dart';
import 'company_list_widget.dart';
import 'custom_navbar.dart';
import 'header_row_widget.dart';
import 'StatsRowWidget.dart';

class Homebody extends StatelessWidget {
  const Homebody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max, // يضمن استخدام كل المساحة المتاحة
      children: [
        Expanded( // يملأ المساحة المتبقية دون ترك فراغ غير ضروري
          child: Container(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 8),
                StatsRowWidget(), // الصف العلوي للإحصائيات
                const SizedBox(height: 10),
                HeaderRowWidget(), // صف العناوين (الشركات - الحالة)
                const SizedBox(height: 6),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 4.0,left: 4.0),
                      child: CompanyListWidget(), // قائمة الشركات القابلة للتمرير
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        NavigationBarItems(selectedIndex: 0),
      ],
    );
  }
}
