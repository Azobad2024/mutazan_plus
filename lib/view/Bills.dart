import 'package:flutter/material.dart';

class InvoicesScreen extends StatefulWidget {
  @override
  _InvoicesScreenState createState() => _InvoicesScreenState();
}

class _InvoicesScreenState extends State<InvoicesScreen> {
  int totalInvoices = 188;
  int totalTrucks = 200;

  final List<Map<String, dynamic>> invoices = [
    {
      'invoiceNumber': '35441',
      'date': '2024/02/15',
      'quantity': '1500',
      'material': 'سكر',
      'netWeight': '5000',
      'isVerified': true,
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
      'isVerified': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF5A7186),
      appBar: AppBar(
        backgroundColor: Color(0xFF5A7186),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.arrow_back, color: Colors.white),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'بحث',
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          children: [
            // ✅ القسم العلوي الثابت
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
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
                    width: 80,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 5,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                    child: Center(
                      child: Text("شعار",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
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
                  );
                },
              ),
            ),
          ],
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

  InvoiceCard({
    required this.invoiceNumber,
    required this.date,
    required this.quantity,
    required this.material,
    required this.netWeight,
    this.isVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ✅ الخط الفاصل مع أيقونة الكتاب
        Row(
          children: [
            Expanded(
              child: Divider(color: Colors.grey, thickness: 1.5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.menu_book, color: Colors.black54),
            ),
            Expanded(
              child: Divider(color: Colors.grey, thickness: 1.5),
            ),
          ],
        ),
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
              // ✅ المربع الأول: رقم الفاتورة، الكمية، والتاريخ
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("رقم الفاتورة",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(invoiceNumber),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("التاريخ",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(date),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الكمية",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(quantity),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),

              // ✅ المربع الثاني: المادة والوزن الصافي
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("المادة",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(material),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الوزن الصافي",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("$netWeight KG"),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),

              // ✅ أيقونة التحقق
              if (isVerified)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.verified, color: Colors.green, size: 24),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}