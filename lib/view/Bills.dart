import 'package:flutter/material.dart';
import 'package:mutazan_plus/view/widgets/custom_navbar.dart';
import '../view/widgets/header_row_widget.dart';

import '../constants.dart';

class InvoicesScreen extends StatefulWidget {
  final String companyName;
  final String companyImag;

  const InvoicesScreen({required this.companyName, required this.companyImag});

  @override
  _InvoicesScreenState createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  bool _isSearching = false;
  TextEditingController _searchController = TextEditingController();
  int totalInvoices = 188;
  int totalTrucks = 200;

  void _closeSearch(){
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  final List<Map<String, dynamic>> invoices = [
    {
      'invoiceNumber': '35441',
      'date': '2024/02/15',
      'quantity': '1500',
      'material': 'سكر',
      'netWeight': '5000',
      'isVerified': false,
    },
    {
      'invoiceNumber': '35442',
      'date': '2024/02/16',
      'quantity': '2000',
      'material': 'أرز',
      'netWeight': '6000',
      'isVerified': false,
    },
    {
      'invoiceNumber': '35443',
      'date': '2024/02/17',
      'quantity': '1700',
      'material': 'قمح',
      'netWeight': '5500',
      'isVerified': false,
    },
    {
      'invoiceNumber': '35441',
      'date': '2024/02/15',
      'quantity': '1500',
      'material': 'سكر',
      'netWeight': '5000',
      'isVerified': false,
    },

  ];

  //تحديث حالة الفاتورة عند التحقق
  void verifyInvoice(int index) {
    setState(() {
      invoices[index]['isVerified'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeSearch,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: backgroundColor,
          elevation: 0,
          title: Row(
            children: [
              // أيقونة العودة في الجانب الأيسر
              // IconButton(
              //   icon: Icon(Icons.arrow_back, color: Colors.white),
              //   onPressed: () {
              //     Navigator.pop(context); // الرجوع للخلف
              //   },
              // ),
              Text(" ${widget.companyName}",style: TextStyle(color: Colors.white),),
              Spacer(), // يضيف فراغ بين البحث وأيقونة العودة

              // البحث في الجانب الأيمن
              if (_isSearching)
                AnimatedContainer(
                  duration: Duration(milliseconds: 300), // تأثير انسيابي
                  width: MediaQuery.of(context).size.width * 0.5, // 60% من عرض الشاشة
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'أدخل نص البحث...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                )
              else
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isSearching = true;
                    });
                  },
                  child: Row(
                    children: [
                      Text('بحث', style: TextStyle(color: Colors.white)),
                      SizedBox(width: 5),
                      Icon(Icons.search, color: Colors.white),
                    ],
                  ),
                ),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            children: [
              // ✅ القسم العلوي الثابت
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  boxShadow: [
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
                        Text("عدد الفواتير",
                            style: TextStyle(fontSize: 16, color: Colors.black)),
                        Text("$totalInvoices",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("عدد الشاحنات",
                            style: TextStyle(fontSize: 16, color: Colors.black)),
                        Text("$totalTrucks",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      width: 60, // جعل العرض والطول متساويين لإنشاء دائرة
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle, // تحويل الحاوية إلى دائرة
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            offset: Offset(2, 2),
                          )
                        ],
                      ),
                      child: ClipOval( // قص المحتوى داخل الدائرة
                        child: Image.asset(
                          widget.companyImag,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover, // لضمان تغطية الصورة بالكامل داخل الدائرة
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              // ✅ قائمة الفواتير
              Expanded(
                child: ListView.builder(
                  itemCount: invoices.length,
                  itemBuilder: (context, index) {
                    final invoice = invoices[index];
                    return InvoiceCard(
                      invoiceNumber: invoice['invoiceNumber'],
                      date: invoice['date'],
                      quantity: invoice['quantity'],
                      material: invoice['material'],
                      netWeight: invoice['netWeight'],
                      isVerified: invoice['isVerified'],
                      onVerify: () => verifyInvoice(index), // ✅ تمرير دالة التحقق
                    );
                  },
                ),
              ),
              NavigationBarItems(selectedIndex: 5),
            ],
          ),
        ),
        // bottomNavigationBar: NavigationBarItems(selectedIndex: 5),
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
  final VoidCallback onVerify; // ✅ تمرير دالة التحقق

  InvoiceCard({
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
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.menu_book, color: Colors.blueGrey, size: 28),
                    ),
                    Expanded(
                      child: Container(height: 1, color: Colors.blueGrey),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: InvoiceLabel(title: "رقم الفاتورة", value: invoiceNumber),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: InvoiceLabel(title: "الكمية", value: quantity),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: InvoiceLabel(title: "التاريخ", value: date, isDate: true),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: InvoiceLabel(title: "الوزن الصافي", value: netWeight),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: InvoiceLabel(title: "المادة", value: material),
                    ),
                  ],
                ),
                if (isVerified)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.verified, color: Colors.green, size: 28),
                        SizedBox(width: 8), // تباعد بين الأيقونة والنص
                        Text(
                          "تم التحقق",
                          style: TextStyle(
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
        title: Text("هل الفاتورة صحيحة؟", textAlign: TextAlign.center),
        content: Text(
          "عند تأكيد صحة الفاتورة سيتم وضع علامة التحقق عليها.",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("خاطئة", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              onVerify();
              Navigator.pop(context);
            },
            child: Text("صحيحة", style: TextStyle(color: Colors.green)),
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

  InvoiceLabel({required this.title, required this.value, this.isDate = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueGrey, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 12, color: Colors.black54)),
          SizedBox(height: 4),
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

