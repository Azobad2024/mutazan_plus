import 'package:flutter/material.dart';
import 'package:mutazan_plus/view/widgets/login_screen_widget.dart';
import 'container_radius.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ContainerRadius(
      child: LoginScreenWidget(),
    );
  }
}




// import 'package:flutter/material.dart';
//
//
// class LoginScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ContainerRadius();
//   }
// }
//
// class ContainerRadius extends StatelessWidget {
//   const ContainerRadius({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       height: MediaQuery.of(context).size.height * 0.8,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(60),
//           topRight: Radius.circular(60),
//         ),
//       ),
//       child: LoginScreenWidget(),
//     );
//   }
// }
//
// class LoginScreenWidget extends StatelessWidget {
//   const LoginScreenWidget({
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         SizedBox(height: 90),
//         // Text("اسم المستخدم أو البريد الإلكتروني"),
//         TextField(
//           decoration: InputDecoration(
//             labelText: 'اسم المستخدم أو البريد الإلكتروني',
//             prefixIcon: Icon(Icons.email),
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 40),
//         // Text('كلمة المرور'),
//         TextField(
//           obscureText: true,
//           decoration: InputDecoration(
//             labelText: 'كلمة المرور',
//             prefixIcon: Icon(Icons.key),
//             border: OutlineInputBorder(),
//           ),
//         ),
//         SizedBox(height: 8),
//         Align(
//           alignment: Alignment.centerLeft,
//           child: TextButton(
//             onPressed: () {},
//             child: Text('هل نسيت كلمة السر؟'),
//           ),
//         ),
//         SizedBox(height: 16),
//         ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.indigo,
//             padding: EdgeInsets.symmetric(vertical: 16),
//           ),
//           child: Text('تسجيل الدخول',style: TextStyle(color: Colors.white),),
//         ),
//         SizedBox(height: 16),
//         Center(
//           child: TextButton.icon(
//             onPressed: () {},
//             icon: Icon(Icons.fingerprint),
//             label: Text('استخدم بصمة الإصبع للوصول'),
//           ),
//         ),
//       ],
//     );
//   }
// }
