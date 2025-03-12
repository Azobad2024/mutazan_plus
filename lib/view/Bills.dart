import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/view/widgets/custom_navbar.dart';
import '../view/widgets/header_row_widget.dart';
import '../constants.dart';
import '../controler/bills_controller.dart'; // استيراد الـ Controller

class InvoicesScreen extends StatelessWidget {
  final String companyName;
  final String companyImag;

  const InvoicesScreen({
    super.key,
    required this.companyName,
    required this.companyImag,
  });

  @override
  Widget build(BuildContext context) {
    // تهيئة الـ Controller
    final InvoicesController controller = Get.put(InvoicesController());

    return GestureDetector(
      onTap: () {
        // إغلاق الكيبورد عند النقر خارج الحقل
        FocusScope.of(context).unfocus();
        if (controller.isSearching.value) {
          controller.closeSearch();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, // منع ظهور الناف بار فوق الكيبورد
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: Row(
            children: [
              Text(
                companyName,
                style: const TextStyle(color: Colors.white),
              ),
              const Spacer(),
              Obx(() {
                if (controller.isSearching.value) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: controller.searchController,
                      focusNode: controller.searchFocusNode, // FocusNode
                      autofocus: false, // لا تظهر الكيبورد تلقائيًا
                      decoration: InputDecoration(
                        hintText: 'searchHint'.tr,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                      onChanged: (query) {
                        controller.searchInvoices(query); // البحث عند تغيير النص
                      },
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      controller.isSearching.value = true;
                    },
                    child: Row(
                      children: [
                        Text('search'.tr, style: TextStyle(color: Colors.white)),
                        const SizedBox(width: 5),
                        const Icon(Icons.search, color: Colors.white),
                      ],
                    ),
                  );
                }
              }),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [
              // ✅ القسم العلوي الثابت
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("numberOfInvoices".tr,
                            style: TextStyle(fontSize: 16, color: Colors.black)),
                        Obx(() => Text("${controller.invoices.length}",
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold))),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("numberOfTrucks".tr,
                            style: TextStyle(fontSize: 16, color: Colors.black)),
                        Text("200", // يمكنك جعل هذا متغيرًا تفاعليًا أيضًا
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          companyImag,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ قائمة الفواتير
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: controller.invoices.length,
                      itemBuilder: (context, index) {
                        final invoice = controller.invoices[index];
                        return InvoiceCard(
                          invoiceNumber: invoice['invoiceNumber'],
                          date: invoice['date'],
                          quantity: invoice['quantity'],
                          material: invoice['material'],
                          netWeight: invoice['netWeight'],
                          isVerified: invoice['isVerified'],
                          onVerify: () => controller.verifyInvoice(index),
                        );
                      },
                    )),
              ),
              NavigationBarItems(
                selectedIndex: 5,
                showBarcode: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ تصميم الفاتورة المحسّن بالكامل
class InvoiceCard extends StatelessWidget {
  final String invoiceNumber;
  final String date;
  final String quantity;
  final String material;
  final String netWeight;
  final bool isVerified;
  final VoidCallback onVerify;

  const InvoiceCard({
    super.key,
    required this.invoiceNumber,
    required this.date,
    required this.quantity,
    required this.material,
    required this.netWeight,
    required this.isVerified,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isVerified) {
          _showVerificationDialog(context);
        }
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.menu_book,
                          color: Colors.blueGrey, size: 28),
                    ),
                    Expanded(
                      child: Container(height: 1, color: Colors.blueGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: InvoiceLabel(
                          title: "invoiceNumber".tr, value: invoiceNumber),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InvoiceLabel(title: "quantity".tr, value: quantity),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InvoiceLabel(
                          title: "date".tr, value: date, isDate: true),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child:
                          InvoiceLabel(title: "netWeight".tr, value: netWeight),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: InvoiceLabel(title: "material".tr, value: material),
                    ),
                  ],
                ),
                if (isVerified)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.verified, color: Colors.green, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          "verified".tr,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showVerificationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("confirmInvoice".tr, textAlign: TextAlign.center),
        content: Text(
          "confirmInvoiceMessage".tr,
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("incorrect".tr, style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              onVerify();
              Navigator.pop(context);
            },
            child: Text("correct".tr, style: TextStyle(color: Colors.green)),
          ),
        ],
      ),
    );
  }
}

// ✅ ويدجت لعرض البيانات داخل المستطيلات
class InvoiceLabel extends StatelessWidget {
  final String title;
  final String value;
  final bool isDate;

  const InvoiceLabel(
      {super.key,
      required this.title,
      required this.value,
      this.isDate = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDate ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:mutazan_plus/view/widgets/custom_navbar.dart';
// import '../view/widgets/header_row_widget.dart';

// import '../constants.dart';

// class InvoicesScreen extends StatefulWidget {
//   final String companyName;
//   final String companyImag;

//   const InvoicesScreen(
//       {super.key, required this.companyName, required this.companyImag});

//   @override
//   _InvoicesScreenState createState() => _InvoicesScreenState();
// }

// class _InvoicesScreenState extends State<InvoicesScreen> {
//   bool _isSearching = false;
//   final TextEditingController _searchController = TextEditingController();
//   int totalInvoices = 188;
//   int totalTrucks = 200;

//   void _closeSearch() {
//     setState(() {
//       _isSearching = false;
//       _searchController.clear();
//     });
//   }

//   final List<Map<String, dynamic>> invoices = [
//     {
//       'invoiceNumber': '35441',
//       'date': '2024/02/15',
//       'quantity': '1500',
//       'material': 'سكر',
//       'netWeight': '5000',
//       'isVerified': true,
//     },
//     {
//       'invoiceNumber': '35442',
//       'date': '2024/02/16',
//       'quantity': '2000',
//       'material': 'أرز',
//       'netWeight': '6000',
//       'isVerified': false,
//     },
//     {
//       'invoiceNumber': '35443',
//       'date': '2024/02/17',
//       'quantity': '1700',
//       'material': 'قمح',
//       'netWeight': '5500',
//       'isVerified': false,
//     },
//     {
//       'invoiceNumber': '35441',
//       'date': '2024/02/15',
//       'quantity': '1500',
//       'material': 'سكر',
//       'netWeight': '5000',
//       'isVerified': false,
//     },
//   ];

//   //تحديث حالة الفاتورة عند التحقق
//   void verifyInvoice(int index) {
//     setState(() {
//       invoices[index]['isVerified'] = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _closeSearch,
//       child: Scaffold(
//         backgroundColor: backgroundColor,
//         appBar: AppBar(
//           backgroundColor: backgroundColor,
//           elevation: 0,
//           title: Row(
//             children: [
//               // أيقونة العودة في الجانب الأيسر
//               // IconButton(
//               //   icon: Icon(Icons.arrow_back, color: Colors.white),
//               //   onPressed: () {
//               //     Navigator.pop(context); // الرجوع للخلف
//               //   },
//               // ),
//               Text(
//                 " ${widget.companyName}",
//                 style: const TextStyle(color: Colors.white),
//               ),
//               const Spacer(), // يضيف فراغ بين البحث وأيقونة العودة

//               // البحث في الجانب الأيمن
//               if (_isSearching)
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 300), // تأثير انسيابي
//                   width: MediaQuery.of(context).size.width *
//                       0.5, // 60% من عرض الشاشة
//                   height: 40,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: TextField(
//                     controller: _searchController,
//                     autofocus: true,
//                     decoration: const InputDecoration(
//                       hintText: 'أدخل نص البحث...',
//                       border: InputBorder.none,
//                       contentPadding: EdgeInsets.symmetric(horizontal: 10),
//                     ),
//                   ),
//                 )
//               else
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _isSearching = true;
//                     });
//                   },
//                   child: const Row(
//                     children: [
//                       Text('بحث', style: TextStyle(color: Colors.white)),
//                       SizedBox(width: 5),
//                       Icon(Icons.search, color: Colors.white),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//         body: Container(
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//           ),
//           child: Column(
//             children: [
//               // ✅ القسم العلوي الثابت
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius:
//                       const BorderRadius.vertical(top: Radius.circular(30)),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 5,
//                       offset: Offset(0, 2),
//                     )
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Text("عدد الفواتير",
//                             style:
//                                 TextStyle(fontSize: 16, color: Colors.black)),
//                         Text("${invoices.length}",
//                             style: const TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Text("عدد الشاحنات",
//                             style:
//                                 TextStyle(fontSize: 16, color: Colors.black)),
//                         Text("$totalTrucks",
//                             style: const TextStyle(
//                                 fontSize: 22, fontWeight: FontWeight.bold)),
//                       ],
//                     ),
//                     Container(
//                       width: 60, // جعل العرض والطول متساويين لإنشاء دائرة
//                       height: 60,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         shape: BoxShape.circle, // تحويل الحاوية إلى دائرة
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.black26,
//                             blurRadius: 5,
//                             offset: Offset(2, 2),
//                           )
//                         ],
//                       ),
//                       child: ClipOval(
//                         // قص المحتوى داخل الدائرة
//                         child: Image.asset(
//                           widget.companyImag,
//                           width: 60,
//                           height: 60,
//                           fit: BoxFit
//                               .cover, // لضمان تغطية الصورة بالكامل داخل الدائرة
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // ✅ قائمة الفواتير
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: invoices.length,
//                   itemBuilder: (context, index) {
//                     final invoice = invoices[index];
//                     return InvoiceCard(
//                       invoiceNumber: invoice['invoiceNumber'],
//                       date: invoice['date'],
//                       quantity: invoice['quantity'],
//                       material: invoice['material'],
//                       netWeight: invoice['netWeight'],
//                       isVerified: invoice['isVerified'],
//                       onVerify: () =>
//                           verifyInvoice(index), // ✅ تمرير دالة التحقق
//                     );
//                   },
//                 ),
//               ),
//               NavigationBarItems(
//                 selectedIndex: 5,
//                 showBarcode: true,
//               ),
//             ],
//           ),
//         ),
//         // bottomNavigationBar: NavigationBarItems(selectedIndex: 5),
//       ),
//     );
//   }
// }

// class InvoiceCard extends StatelessWidget {
//   final String invoiceNumber;
//   final String date;
//   final String quantity;
//   final String material;
//   final String netWeight;
//   final bool isVerified;
//   final VoidCallback onVerify; // ✅ تمرير دالة التحقق

//   const InvoiceCard({
//     super.key,
//     required this.invoiceNumber,
//     required this.date,
//     required this.quantity,
//     required this.material,
//     required this.netWeight,
//     required this.isVerified,
//     required this.onVerify,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         if (!isVerified) {
//           _showVerificationDialog(context);
//         }
//       },
//       child: Column(
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//             padding: const EdgeInsets.all(12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(20),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.1),
//                   blurRadius: 8,
//                   offset: const Offset(0, 4),
//                 ),
//               ],
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 16),
//                       child: Icon(Icons.menu_book,
//                           color: Colors.blueGrey, size: 28),
//                     ),
//                     Expanded(
//                       child: Container(height: 1, color: Colors.blueGrey),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: InvoiceLabel(
//                           title: "رقم الفاتورة", value: invoiceNumber),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: InvoiceLabel(title: "الكمية", value: quantity),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: InvoiceLabel(
//                           title: "التاريخ", value: date, isDate: true),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child:
//                           InvoiceLabel(title: "الوزن الصافي", value: netWeight),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: InvoiceLabel(title: "المادة", value: material),
//                     ),
//                   ],
//                 ),
//                 if (isVerified)
//                   const Padding(
//                     padding: EdgeInsets.only(top: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.verified, color: Colors.green, size: 28),
//                         SizedBox(width: 8), // تباعد بين الأيقونة والنص
//                         Text(
//                           "تم التحقق",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showVerificationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("هل الفاتورة صحيحة؟", textAlign: TextAlign.center),
//         content: const Text(
//           "عند تأكيد صحة الفاتورة سيتم وضع علامة التحقق عليها.",
//           textAlign: TextAlign.center,
//         ),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text("خاطئة", style: TextStyle(color: Colors.red)),
//           ),
//           TextButton(
//             onPressed: () {
//               onVerify();
//               Navigator.pop(context);
//             },
//             child: const Text("صحيحة", style: TextStyle(color: Colors.green)),
//           ),
//         ],
//       ),
//     );
//   }
// }
