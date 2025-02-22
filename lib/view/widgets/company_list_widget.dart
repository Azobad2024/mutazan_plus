import 'package:flutter/material.dart';
import '../../constants.dart';
import '../Bills.dart';

class CompanyListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(18, (index) {
        return CompanyRowWidget(
          name: "اسم الشركة $index",
          status: index % 2 == 0 ? Icons.check_circle : Icons.cancel,
          statusColor: index % 2 == 0 ? Colors.green : Colors.red,
          imagePath: 'assets/images/images.png',
        );
      }),
    );
  }
}

class CompanyRowWidget extends StatelessWidget {
  final String name;
  final IconData status;
  final Color statusColor;
  final String imagePath;

  const CompanyRowWidget({
    required this.name,
    required this.status,
    required this.statusColor,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // التنقل إلى صفحة الفواتير وتمرير اسم الشركة
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InvoicesScreen(companyName: name, companyImag: imagePath,),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imagePath,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
              const SizedBox(width: 12,),
              Icon(status, color: statusColor, size: 24),
            ],
          ),
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
//           imagePath: 'assets/images/images.png',
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
//   final String imagePath;
//
//   const CompanyRowWidget({
//     required this.name,
//     required this.status,
//     required this.statusColor,
//     required this.imagePath,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         decoration: BoxDecoration(
//           color: containerColor,
//           borderRadius: BorderRadius.circular(14),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.3), // لون الظل مع شفافية
//               spreadRadius: 2,
//               blurRadius: 8,
//               offset: const Offset(2, 4),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(12),
//               child: Image.asset(
//                 imagePath,
//                 width: 50,
//                 height: 50,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 12,),
//             Expanded(
//               child: Text(
//               name,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.right,
//             ),
//             ),
//             const SizedBox(width: 12,),
//             Icon(status, color: statusColor, size: 24),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
