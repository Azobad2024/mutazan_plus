import 'package:flutter/material.dart';
import '../../Util/BiometricAuthPresenter.dart';
import '../../Util/BiometricAuthService.dart';
import '../Home.dart';
import 'custom_elevated_button.dart';

// استيراد الأكواد الخاصة بالمصادقة البيومترية
import 'package:local_auth/local_auth.dart';
import '../../Util/BiometricAuthInterface.dart';


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

  // إنشاء كائن المصادقة البيومترية
  final BiometricAuthPresenter _biometricAuthPresenter =
  BiometricAuthPresenter(BiometricAuthService());

  // دالة تنفيذ المصادقة البيومترية
  Future<void> _authenticateWithBiometrics() async {
    bool isAuthenticated = await _biometricAuthPresenter.authenticate();
    if (isAuthenticated) {
      Navigator.pushNamed(context, Home.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("فشلت المصادقة البيومترية")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                '           اسم المستخدم أو البريد الإلكتروني',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Icon(Icons.email_outlined, size: 30),
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
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                "           كلمة المرور",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Icon(Icons.key, size: 30),
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
                            ? Icon(Icons.visibility_outlined)
                            : Icon(Icons.visibility_off_outlined),
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
                child: Text('هل نسيت كلمة السر؟'),
              ),
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              text: 'تسجيل الدخول',
              onPressed: () {
                if (_formkey.currentState?.validate() ?? false) {
                  Navigator.pushNamed(context, Home.routeName);
                }
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton.icon(
                onPressed: _authenticateWithBiometrics, // استدعاء المصادقة عند الضغط
                label: Text('استخدم بصمة الإصبع للوصول'),
                icon: Icon(Icons.fingerprint),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
