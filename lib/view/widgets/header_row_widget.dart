import 'package:flutter/material.dart';

import '../../constants.dart';

class HeaderRowWidget extends StatelessWidget {
  const HeaderRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: containerColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // لون الظل مع شفافية
            spreadRadius: 4,
            blurRadius: 12,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const HeaderCard(title: "الشركات"),
          Container(
            width: 1,
            height: 40,
            color: backgroundColor,
          ),
          const HeaderCard(title: "  الحالة   "),
        ],
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  final String title;

  const HeaderCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: container1Color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
