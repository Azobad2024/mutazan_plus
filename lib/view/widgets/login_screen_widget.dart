import 'package:flutter/material.dart';

import 'CustomElevatedButton.dart';
import 'CustomTextField.dart';

class LoginScreenWidget extends StatelessWidget {
  const LoginScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 90),
        CustomTextField(
          labelText: 'اسم المستخدم أو البريد الإلكتروني',
          prefixIcon: Icons.email,
        ),
        SizedBox(height: 40),
        CustomTextField(
          labelText: 'كلمة المرور',
          prefixIcon: Icons.lock,
          obscureText: true,
        ),

        SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: Text('هل نسيت كلمة السر؟'),
          ),
        ),
        SizedBox(height: 16),
        CustomElevatedButton(
          text: 'تسجيل الدخول',
          onPressed: () {},
        ),

        SizedBox(height: 16),
        Center(
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.fingerprint),
            label: Text('استخدم بصمة الإصبع للوصول'),
          ),
        ),
      ],
    );
  }
}
