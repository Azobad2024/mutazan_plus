import 'package:flutter/material.dart';


class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '30% من الفواتير تبدو جيدة.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 8),
          Icon(
            Icons.check_box,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}