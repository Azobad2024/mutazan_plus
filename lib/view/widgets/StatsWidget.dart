import 'package:flutter/material.dart';

import 'stat_card.dart';



class StatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // تمرير خصائص جديدة للتحكم في لون الأيقونة والاتجاه
          const StatCard(
            assetIcon: "assets/icons/arrow.png",
            title: 'الفواتير المعلقة',
            value: '400',
            iconColor: Colors.green, // تحديد اللون
            iconRotation: 80,
          ),
          Container(
            width: 2,
            height: 60,
            color: Colors.grey[300],
          ),
          const StatCard(
            iconRotation: 80,
            assetIcon: "assets/icons/arrow.png",
            title: 'إجمالي الفواتير',
            value: '5000',
            iconColor: Colors.blue, // تحديد اللون
          ),
        ],
      ),
    );
  }
}

