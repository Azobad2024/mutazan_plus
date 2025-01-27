import 'package:flutter/material.dart';

class StatCard1 extends StatelessWidget {
  final IconData icon;
  final String value;
  final Color color;

  const StatCard1({required this.icon, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3), // لون الظل مع شفافية
                    spreadRadius: 2, // مقدار انتشار الظل
                    blurRadius: 4, // مقدار التشويش للظل
                    offset: Offset(2, 4), // إزاحة الظل (أفقياً وعمودياً)
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
                child: CircularProgressIndicator(
                  value: 0.7, // النسبة المؤوية (تعديل القيمة حسب الحاجة)
                  color: color,
                  strokeWidth: 4,
                ),
              ),
            ),
            Icon(icon, size: 35, color: Colors.black),
          ],
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
