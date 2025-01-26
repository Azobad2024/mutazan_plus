import 'package:flutter/material.dart';

import '../../constants.dart'; // تأكد من أن الألوان والقيم مضبوطة في ملف constants

class CompanyListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(3, (index) {
        return CompanyRowWidget(
          name: "اسم الشركة",
          status: index % 2 == 0 ? Icons.check_circle : Icons.cancel,
          statusColor: index % 2 == 0 ? Colors.green : Colors.red,
          imagePath: 'assets/images/images.png', // مسار صورة الشركة
        );
      }),
    );
  }
}

class CompanyRowWidget extends StatelessWidget {
  final String name;
  final IconData status;
  final Color statusColor;
  final String imagePath; // إضافة مسار الصورة

  const CompanyRowWidget({
    required this.name,
    required this.status,
    required this.statusColor,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: containerColor, // لون الخلفية (من ملف constants)
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // حواف الصورة
              child: Image.asset(
                imagePath, // الصورة
                width: 50,
                height: 50,
                fit: BoxFit.cover, // ملء الصورة داخل الحاوية
              ),
            ),
            SizedBox(width: 12,),
            Expanded(
              child: Text(
              name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
            ),
            ),
            SizedBox(width: 12,),
            Icon(status, color: statusColor, size: 24),

          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
//
// import '../../constants.dart';
//
// class CompanyListWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: List.generate(3, (index) {
//         return CompanyRowWidget(
//           name: "اسم الشركة",
//           status: index % 2 == 0 ? Icons.check_circle : Icons.cancel,
//           statusColor: index % 2 == 0 ? Colors.green : Colors.red,
//         );
//       }),
//     );
//   }
// }
//
// class CompanyRowWidget extends StatelessWidget {
//   final String name;
//   final IconData status;
//   final Color statusColor;
//
//   const CompanyRowWidget({
//     required this.name,
//     required this.status,
//     required this.statusColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: containerColor,
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Icon(status, color: statusColor, size: 24),
//                 SizedBox(width: 12),
//                 Text(
//                   name,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             Container(
//               width: 40,
//               height: 40,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black, width: 1),
//                 borderRadius: BorderRadius.circular(12),
//                 color: container1Color,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }