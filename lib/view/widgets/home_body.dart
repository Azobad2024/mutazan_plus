import 'package:flutter/material.dart';

import 'company_list_widget.dart';
import 'header_row_widget.dart';
import 'StatsRowWidget.dart';

class Homebody extends StatelessWidget {
  const Homebody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 15,),
              StatsRowWidget(), // الصف العلوي للإحصائيات
              const SizedBox(height: 20),
              HeaderRowWidget(), // صف العناوين (الشركات - الحالة)
              const SizedBox(height: 10),
              CompanyListWidget(), // قائمة الشركات
              CompanyListWidget(), // قائمة الشركات
              CompanyListWidget(), // قائمة الشركات
            ],
          ),
        ),
      ),
    );
  }
}
