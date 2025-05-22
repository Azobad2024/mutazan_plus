import 'package:flutter/material.dart';

class ContainerRadius extends StatelessWidget {
  final Widget child; // متغير لاستقبال الـ child من الويدجت المستدعية

  const ContainerRadius({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    
    // نجلب من الثيم اللون المناسب لخلفية الحاوية
    final background = Theme.of(context).canvasColor;

    return Container(
      // padding: EdgeInsets.all(8),
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: background,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 3,
            blurRadius: 8,
            offset: Offset(2, 4),
            color: Colors.black38,
          ),
        ],
      ),
      child: child,
    );
  }
}
