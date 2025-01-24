import 'package:flutter/material.dart';
import 'package:mutazan_plus/view/widgets/FooterWidget.dart';
import 'package:mutazan_plus/view/widgets/HeaderWidget.dart';
import 'package:mutazan_plus/view/widgets/HomeBody.dart';
import 'package:mutazan_plus/view/widgets/StatsWidget.dart';
import 'package:mutazan_plus/view/widgets/container_radius.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF718FA2), // اللون الأساسي للخلفية
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              HeaderWidget(),
              const SizedBox(height: 20),
              StatsWidget(),
              // Spacer(),
              FooterWidget(),
              const SizedBox(height: 20),
              const ContainerRadius(
                child: Homebody(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

