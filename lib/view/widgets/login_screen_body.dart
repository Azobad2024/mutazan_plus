import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Util/BiometricAuthPresenter.dart';
import '../../Util/BiometricAuthService.dart';
import '../Home.dart';
import 'custom_elevated_button.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({super.key});

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  bool _obscurePassword = true;

  final BiometricAuthPresenter _biometricAuthPresenter =
  BiometricAuthPresenter(BiometricAuthService());

  Future<void> _authenticateWithBiometrics() async {
    bool isAuthenticated = await _biometricAuthPresenter.authenticate();
    if (isAuthenticated) {
      Navigator.pushNamed(context, Home.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('biometricAuthFailed'.tr)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'usernameOrEmail'.tr,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.email_outlined, size: 30),
                const SizedBox(width: 4),
                Expanded(
                  child: TextFormField(
                    controller: _controllerUsername,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "example@example.com",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an email address.";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'password'.tr,
                style:
                const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.key, size: 30),
                const SizedBox(width: 4),
                Expanded(
                  child: TextFormField(
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: "********",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                        icon: _obscurePassword
                            ? const Icon(Icons.visibility_off_outlined)
                            : const Icon(Icons.visibility_outlined),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: Text('forgotPassword'.tr),
              ),
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              text: 'login'.tr,
              onPressed: () {
                if (true) {
                  Navigator.pushNamed(context, Home.routeName);
                }
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton.icon(
                onPressed: _authenticateWithBiometrics,
                label: Text('useFingerprint'.tr),
                icon: const Icon(Icons.fingerprint),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import '../../Util/BiometricAuthPresenter.dart';
// import '../../Util/BiometricAuthService.dart';
// import '../../controler/login_controller.dart';
// import '../../model/user_model.dart';
// import '../Home.dart';
// import 'custom_elevated_button.dart';
//
// class LoginScreenWidget extends StatefulWidget {
//   LoginScreenWidget({super.key});
//
//   @override
//   _LoginScreenWidgetState createState() => _LoginScreenWidgetState();
// }
//
// class _LoginScreenWidgetState extends State<LoginScreenWidget> {
//   final GlobalKey<FormState> _formkey = GlobalKey();
//   final TextEditingController _controllerUsername = TextEditingController();
//   final TextEditingController _controllerPassword = TextEditingController();
//   bool _obscurePassword = true;
//
//   final LoginController _loginController = Get.put(LoginController());
//   final BiometricAuthPresenter _biometricAuthPresenter =
//   BiometricAuthPresenter(BiometricAuthService());
//
//   @override
//   void initState() {
//     super.initState();
//     _checkLoggedInUser();
//   }
//
//   Future<void> _checkLoggedInUser() async {
//     final userBox = Hive.box<User>('userBox');
//     final user = userBox.get('currentUser');
//
//     if (user != null) {
//       Get.offAllNamed(Home.routeName);
//     }
//   }
//
//   Future<void> _authenticateWithBiometrics() async {
//     bool isAuthenticated = await _biometricAuthPresenter.authenticate();
//     if (isAuthenticated) {
//       Get.offAllNamed(Home.routeName);
//     } else {
//       Get.snackbar('Error', 'biometricAuthFailed'.tr);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formkey,
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const SizedBox(height: 80),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Text(
//                 'usernameOrEmail'.tr,
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Row(
//               children: [
//                 const Icon(Icons.email_outlined, size: 30),
//                 const SizedBox(width: 4),
//                 Expanded(
//                   child: TextFormField(
//                     controller: _controllerUsername,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       hintText: "example@example.com",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     validator: (String? value) {
//                       if (value == null || value.isEmpty) {
//                         return "Please enter an email address.";
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 30),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Text(
//                 'password'.tr,
//                 style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//               ),
//             ),
//             Row(
//               children: [
//                 const Icon(Icons.key, size: 30),
//                 const SizedBox(width: 4),
//                 Expanded(
//                   child: TextFormField(
//                     controller: _controllerPassword,
//                     obscureText: _obscurePassword,
//                     decoration: InputDecoration(
//                       hintText: "********",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           setState(() {
//                             _obscurePassword = !_obscurePassword; // تغيير الحالة
//                           });
//                         },
//                         icon: _obscurePassword
//                             ? const Icon(Icons.visibility_outlined)
//                             : const Icon(Icons.visibility_off_outlined),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             Align(
//               alignment: Alignment.center,
//               child: TextButton(
//                 onPressed: () {},
//                 child: Text('forgotPassword'.tr),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Obx(() => CustomElevatedButton(
//               text: 'login'.tr,
//               onPressed: _loginController.isLoading.value
//                   ? null // تعطيل الزر إذا كان التحميل قيد التقدم
//                   : () {
//                 if (_formkey.currentState!.validate()) {
//                   _loginController.login(
//                     _controllerUsername.text,
//                     _controllerPassword.text,
//                   );
//                 }
//               },
//             )),
//             const SizedBox(height: 16),
//             Obx(() {
//               if (_loginController.errorMessage.isNotEmpty) {
//                 return Text(
//                   _loginController.errorMessage.value,
//                   style: const TextStyle(color: Colors.red),
//                   textAlign: TextAlign.center,
//                 );
//               }
//               return const SizedBox.shrink();
//             }),
//             Center(
//               child: TextButton.icon(
//                 onPressed: _authenticateWithBiometrics,
//                 label: Text('useFingerprint'.tr),
//                 icon: const Icon(Icons.fingerprint),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
