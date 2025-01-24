import 'package:flutter/material.dart';
import 'package:mutazan_plus/view/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreenWithWelcome(),
    );
  }
}
