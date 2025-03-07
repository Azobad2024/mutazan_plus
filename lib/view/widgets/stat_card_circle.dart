import 'package:flutter/material.dart';

class StatCard1 extends StatelessWidget {
  final String assetIcon;
  final String value;
  final Color color;

  const StatCard1({
    super.key,
    required this.assetIcon,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 2,
                blurRadius: 16,
                offset: const Offset(2, 8),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: CircularProgressIndicator(
                  value: 0.7,
                  color: color,
                  strokeWidth: 4,
                ),
              ),
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.grey[200],
                child: Image.asset(
                  assetIcon,
                  width: 55,
                  height: 55,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
