import 'package:flutter/material.dart';
import 'package:mutazan_plus/view/widgets/login_screen_body.dart';
import 'container_radius.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ContainerRadius(
      child: LoginScreenWidget(),
    );
  }
}