import 'package:flutter/material.dart';

import '../../constants.dart';


class HeaderRowWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: containerColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HeaderCard(title: "الشركات"),
          Container(
            width: 1,
            height: 40,
            color: backgroundColor,
          ),
          HeaderCard(title: "  الحالة   "),
        ],
      ),
    );
  }
}

class HeaderCard extends StatelessWidget {
  final String title;

  const HeaderCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: container1Color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
