import 'package:flutter/material.dart';
import 'package:mutazan_plus/view/widgets/login_screen.dart';

import '../constants.dart';

class LoginScreenWithWelcome extends StatefulWidget {
  static String routeName = "/Login";

  const LoginScreenWithWelcome({super.key});

  @override
  _LoginScreenWithWelcomeState createState() => _LoginScreenWithWelcomeState();
}

class _LoginScreenWithWelcomeState extends State<LoginScreenWithWelcome> {
  bool _showLoginScreen = false;

  @override
  void initState() {
    super.initState();

    // تأخير الحركة لمدة 2 ثانية
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _showLoginScreen = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // النص "مرحباً بكم"
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            top: _showLoginScreen
                ? 80
                : MediaQuery.of(context).size.height / 2 - 40,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                'مرحباً بكم',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // نافذة تسجيل الدخول
          if (_showLoginScreen)
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut,
              bottom: 0,
              left: 0,
              right: 0,
              child: LoginScreen(),
            ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:mutazan_plus/view/widgets/login_screen.dart';
//
// import '../constants.dart';
//
// class LoginScreenWithWelcome extends StatefulWidget {
//   static String routeName = "/Login";
//
//   const LoginScreenWithWelcome({super.key});
//
//   @override
//   _LoginScreenWithWelcomeState createState() => _LoginScreenWithWelcomeState();
// }
//
// class _LoginScreenWithWelcomeState extends State<LoginScreenWithWelcome> {
//   bool _showLoginScreen = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // تأخير الحركة لمدة 2 ثانية
//     Future.delayed(const Duration(seconds: 2), () {
//       setState(() {
//         _showLoginScreen = true;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       // backgroundColor: Colors.blueGrey.shade600,
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           // النص "مرحباً بكم"
//           AnimatedPositioned(
//             duration: const Duration(seconds: 1),
//             curve: Curves.easeInOut,
//             top: _showLoginScreen
//                 ? 80
//                 : MediaQuery.of(context).size.height / 2 - 40,
//             left: 0,
//             right: 0,
//             child: const Center(
//               child: Text(
//                 'مرحباً بكم',
//                 style: TextStyle(
//                   fontSize: 36,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           // نافذة تسجيل الدخول
//           if (_showLoginScreen)
//             AnimatedPositioned(
//               duration: const Duration(seconds: 1),
//               curve: Curves.easeInOut,
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: LoginScreen(),
//             ),
//         ],
//       ),
//     );
//   }
// }
