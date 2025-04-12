import 'package:flutter/material.dart';
import 'package:mutazan_plus/view/widgets/login_screen_body.dart';
import 'container_radius.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  ContainerRadius(
      child: LoginScreenWidget(),
    );
  }
}
