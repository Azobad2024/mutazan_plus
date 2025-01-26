import 'package:flutter/material.dart';

class ContainerRadius extends StatelessWidget {
  final Widget child; // متغير لاستقبال الـ child من الويدجت المستدعية

  const ContainerRadius({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
      ),
      child: child,
    );
  }
}
