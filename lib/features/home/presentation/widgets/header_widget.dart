import 'package:flutter/material.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import '../../../../view/profile_page.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset("assets/images/asd01.png", height: 100),
          GestureDetector(
            onTap: () {
              customNavigat(context, '/profile');
              // Navigator.pushNamed(context, ProfilePage1.routeName);
            },
            child: const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/myProfile.png'),
            ),
          ),
        ],
      ),
    );
  }
}
