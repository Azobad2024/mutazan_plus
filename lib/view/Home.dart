import 'package:flutter/material.dart';
import 'package:mutazan_plus/constants.dart';
import 'package:mutazan_plus/view/widgets/footer_widget.dart';
import 'package:mutazan_plus/view/widgets/header_widget.dart';
import 'package:mutazan_plus/view/widgets/home_body.dart';
import 'package:mutazan_plus/view/widgets/StatsWidget.dart';
import 'package:mutazan_plus/view/widgets/container_radius.dart';

class Home extends StatelessWidget {
  static String routeName = "/Home";

  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // اللون الأساسي للخلفية
      appBar: AppBar(
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: false, // إخفاء سهم العودة
        title: HeaderWidget(), // إضافة HeaderWidget في العنوان
      ),
      body: const SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            // HeaderWidget(), // عنصر الرأس
            SizedBox(height: 10),
            StatsWidget(), // عنصر الإحصائيات
            // const SizedBox(height: 2,), // للحفاظ على توزيع المساحة
            FooterWidget(), // عنصر التذييل
            SizedBox(height: 2),
            // محتويات ContainerRadius
            Expanded(
              child: ContainerRadius(
                child: Homebody(),
              ),
            ),
          ],
        ),
      ),
      // الخلفية البيضاء للجزء السفلي
      // bottomNavigationBar: Stack(
      //   children: [
      //     Container(
      //       height: 60, // ارتفاع الجزء الأبيض
      //       color: Colors.white, // لون الخلفية السفلية
      //     ),
      //     NavigationBarItems(selectedIndex: 0),
      //   ],
      // ),
    );
  }
}
