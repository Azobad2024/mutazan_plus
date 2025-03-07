import 'package:flutter/material.dart';
import '../profile_page.dart';

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
              Navigator.pushNamed(context, ProfilePage1.routeName);
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


// import 'package:flutter/material.dart';
// import '../profile_page.dart';
//
// class HeaderWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Image.asset("assets/images/asd01.png", height: 100),
//           GestureDetector(
//             onTap: () {
//               Navigator.pushNamed(context, ProfilePage1.routeName);
//             },
//             child: const CircleAvatar(
//               radius: 24,
//               backgroundColor: Colors.white,
//               child: Icon(
//                 Icons.person_outline,
//                 size: 28,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
