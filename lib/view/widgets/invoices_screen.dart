import 'package:flutter/material.dart';

class InvoicesScreen extends StatelessWidget {
  final String companyName;

  const InvoicesScreen({super.key, required this.companyName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("فواتير $companyName"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Text(
          "هذه الفواتير الخاصة بـ $companyName",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
