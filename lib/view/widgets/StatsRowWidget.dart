import 'package:flutter/material.dart';

import '../../constants.dart';
import 'CustomTextField.dart';
import 'StatCard1.dart';

class StatsRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(12),
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