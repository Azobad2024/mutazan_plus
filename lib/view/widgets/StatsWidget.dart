import 'package:flutter/material.dart';

import 'StatCard.dart';



class StatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          StatCard(
            title: 'الفواتير المعلقة',
            value: '400',
          ),
          StatCard(
            title: 'إجمالي الفواتير',
            value: '5000',
          ),
        ],
      ),
    );
  }
}


