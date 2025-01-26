import 'package:flutter/material.dart';

import 'CompanyListWidget.dart';
import 'HeaderRowWidget.dart';
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
              StatsRowWidget(), // الصف العلوي للإحصائيات
              const SizedBox(height: 20),
              HeaderRowWidget(), // صف العناوين (الشركات - الحالة)
              const SizedBox(height: 10),
              CompanyListWidget(), // قائمة الشركات
            ],
          ),
        ),
      ),
    );
  }
}
