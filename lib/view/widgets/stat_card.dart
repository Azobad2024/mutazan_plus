import 'package:flutter/material.dart';

import '../../constants.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String value;

  const StatCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // لون الظل مع شفافية
            spreadRadius: 2, // مقدار انتشار الظل
            blurRadius: 10, // مقدار التشويش للظل
            offset: const Offset(2, 4), // إزاحة الظل (أفقياً وعمودياً)
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  color: buttomColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 5),
              Icon(
                Icons.trending_down,
                size: 24,
                color: Colors.grey[700],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: buttomColor,
            ),
          ),
        ],
      ),
    );
  }
}
