import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Container(
        padding: EdgeInsets.all(16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 80,),
           const Align(
              alignment: Alignment.centerRight, // محاذاة النص لليمين
              child: Text(
                '           اسم المستخدم أو البريد الإلكتروني',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Icon(Icons.email_outlined, size: 30), // أيقونة بجانب الحقل
                const SizedBox(width: 4), // مسافة صغيرة بين الأيقونة والحقل
                Expanded( // لجعل الحقل يأخذ المساحة المتبقية
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
            const SizedBox(height: 30), // مسافة بين البريد وكلمة المرور

            // كلمة المرور
            const Align(
              alignment: Alignment.centerRight, // محاذاة النص لليمين
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
                child: Text('هل نسيت كلمة السر؟'),),
              ),

            const SizedBox(height: 16),
            CustomElevatedButton(
              text: 'تسجيل الدخول',
              onPressed: () {
                if (true)
                  //_formkey.currentState?.validate() ?? false){
                    {
                  // Navigator.push(
                  // context, MaterialPageRoute(builder: (context)=>Home()));
                  Navigator.pushNamed(context, Home.routeName);
                }
              },
            ),

            const SizedBox(height: 16),
            Center(
              child: TextButton.icon(
                onPressed: () {},
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
