import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/asd01.png", height: 100,),
          // Positioned.fill(
          //   child: SvgPicture.asset(
          //     'assets/Svg/icon_app.svg', // مسار الشعار
          //     height: 30, ),
          // ),
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.person_outline,
              size: 28,
              // color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}