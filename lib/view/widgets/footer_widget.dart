import 'package:flutter/material.dart';


class FooterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '30% من الفواتير تبدو جيدة.',
            style: TextStyle(
              fontSize: 20,
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