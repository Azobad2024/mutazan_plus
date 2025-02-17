import 'package:flutter/material.dart';
import 'package:mutazan_plus/view/widgets/company_list_widget.dart';
import 'package:mutazan_plus/view/widgets/container_radius.dart';
import 'package:mutazan_plus/view/widgets/custom_navbar.dart';
import 'package:mutazan_plus/view/widgets/home_body.dart';

import '../constants.dart';

class Company extends StatelessWidget {
  static String routeName = "/Company";

  const Company({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor, // اللون الأساسي للخلفية
      body: Container(

      child: Column(
          children: [
            SizedBox(height: 100,),
            Expanded(
              child: ContainerRadius(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: CompanyListWidget(),
                  ), // المحتوى المتحرك داخل ContainerRadius
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 60, // ارتفاع الجزء الأبيض
            color: Colors.white, // لون الخلفية السفلية
          ),
          NavigationBarItems(selectedIndex: 1),
        ],
      ),

    );
  }
}
