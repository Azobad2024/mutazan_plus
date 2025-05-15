import 'package:flutter/material.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';

import 'stat_card_circle.dart';

class StatsRowWidget extends StatelessWidget {
  const StatsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
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
          const StatCard1(
            assetIcon: 'assets/icons/shuttle-bus.png',
            value: "1500",
            color: Colors.red,
          ),
          Container(
            width: 1,
            height: 60,
            color: AppColors.backgroundColor,
          ),
          const StatCard1(
            assetIcon: 'assets/icons/shuttle-bus.png',
            value: "5000",
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
