import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controler/CompanyController.dart';

class CompanyListWidget extends StatelessWidget {
  final CompanyController companyController = Get.put(CompanyController());

  CompanyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (companyController.isLoading.value &&
            companyController.companies.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else if (companyController.companies.isEmpty) {
          return const Center(child: Text("لا توجد شركات متاحة"));
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: companyController.companies.length,
            itemBuilder: (context, index) {
              final company = companyController.companies[index];
              return CompanyRowWidget(
                name: company.companyName,
                status: Icons.check_circle, // إضافة حالة وهمية مؤقتًا
                statusColor: Colors.green,
                imagePath: company.logo,
              );
            },
          );
        }
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
    super.key,
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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
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
              child: imagePath.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: "http://192.168.83.162:8000$imagePath",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/images/images.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Image.asset(
                      'assets/images/images.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(width: 12),
            Icon(status, color: statusColor, size: 24),
          ],
        ),
      ),
    );
  }
}

// class CompanyListWidget extends StatelessWidget {
//   const CompanyListWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: List.generate(18, (index) {
//         return CompanyRowWidget(
//           name: "companyName".tr + " $index", // استخدام الترجمة
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
//     super.key,
//     required this.name,
//     required this.status,
//     required this.statusColor,
//     required this.imagePath,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         // التنقل إلى صفحة الفواتير وتمرير اسم الشركة
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => InvoicesScreen(
//               companyName: name,
//               companyImag: imagePath,
//             ),
//           ),
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           decoration: BoxDecoration(
//             color: containerColor,
//             borderRadius: BorderRadius.circular(14),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 spreadRadius: 2,
//                 blurRadius: 8,
//                 offset: const Offset(2, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.asset(
//                   imagePath,
//                   width: 50,
//                   height: 50,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(
//                 width: 12,
//               ),
//               Expanded(
//                 child: Text(
//                   name,
//                   style: const TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.right,
//                 ),
//               ),
//               const SizedBox(
//                 width: 12,
//               ),
//               Icon(status, color: statusColor, size: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
