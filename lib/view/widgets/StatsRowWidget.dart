import 'package:flutter/material.dart';

import '../../constants.dart';
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
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 12,
            offset: const Offset(6, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatCard1(
            assetIcon: 'assets/icons/shuttle-bus.png',
            value: "1500",
            color: Colors.red,
          ),
          Container(
            width: 1,
            height: 60,
            color: backgroundColor,
          ),
          StatCard1(
            assetIcon: 'assets/icons/shuttle-bus.png',
            value: "5000",
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}