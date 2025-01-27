import 'package:flutter/material.dart';

import '../../constants.dart';
import 'CustomTextField.dart';
import 'stat_card_circle.dart';

class StatsRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // لون الظل مع شفافية
            spreadRadius: 4, // مقدار انتشار الظل
            blurRadius: 12, // مقدار التشويش للظل
            offset: const Offset(2, 4), // إزاحة الظل (أفقياً وعمودياً)
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatCard1(icon: Icons.directions_bus_outlined, value: "1500", color: Colors.red),

          Container(
            width: 1,
            height: 60,
            color: backgroundColor,
          ),

          StatCard1(icon: Icons.directions_bus_outlined, value: "5000", color: Colors.blue),
        ],
      ),
    );
  }
}