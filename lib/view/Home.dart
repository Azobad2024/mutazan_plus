import 'package:flutter/material.dart';
import 'package:mutazan_plus/constants.dart';
import 'package:mutazan_plus/view/widgets/footer_widget.dart';
import 'package:mutazan_plus/view/widgets/header_widget.dart';
import 'package:mutazan_plus/view/widgets/home_body.dart';
import 'package:mutazan_plus/view/widgets/StatsWidget.dart';
import 'package:mutazan_plus/view/widgets/container_radius.dart';
import 'package:mutazan_plus/view/widgets/custom_navbar.dart';

class Home extends StatelessWidget {
  static String routeName = "/Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // اللون الأساسي للخلفية
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            HeaderWidget(), // عنصر الرأس
            const SizedBox(height: 20),
            StatsWidget(), // عنصر الإحصائيات
            const SizedBox(height: 4,), // للحفاظ على توزيع المساحة
            FooterWidget(), // عنصر التذييل
            const SizedBox(height: 20),
            // محتويات ContainerRadius
            Expanded(
              child: ContainerRadius(
                child: SingleChildScrollView(
                  child: Homebody(), // المحتوى المتحرك داخل ContainerRadius
                ),
              ),
            ),
          ],
        ),
      ),
      // الخلفية البيضاء للجزء السفلي
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 60, // ارتفاع الجزء الأبيض
            color: Colors.white, // لون الخلفية السفلية
          ),
          NavigationBarItems(selectedIndex: 0),
        ],
      ),
    );
  }
}
