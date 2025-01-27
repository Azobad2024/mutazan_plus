import 'package:flutter/material.dart';

import '../../constants.dart';

class NavigationBarItems extends StatefulWidget {
  NavigationBarItems({super.key, required this.selectedIndex});
  int selectedIndex;

  @override
  State<NavigationBarItems> createState() => _NavigationBarItemsState();
}

class _NavigationBarItemsState extends State<NavigationBarItems> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: backgroundColor, // لون الناف بار
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey, // اللون الأبيض للظل
              blurRadius: 15, // زيادة تشويش الظل ليبدو أوسع
              spreadRadius: 5, // زيادة انتشار الظل ليغطي مساحة أكبر
              offset: Offset(0, -4), // الظل نحو الأعلى
            ),
          ],
        ),

        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.business_rounded, "Company", 1),
            _buildNavItem(Icons.person_outline, "Person", 2),
            _buildNavItem(Icons.settings, "Setting", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.selectedIndex = index;
        });

        // التنقل بين الصفحات باستخدام Navigator
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/Home');
            break;
          case 1:
            Navigator.pushNamed(context, '/Company');
            break;
          case 2:
            Navigator.pushNamed(context, '/profile');
            break;
          case 3:
            Navigator.pushNamed(context, '/settings');
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: widget.selectedIndex == index ? Colors.white : Colors.white54,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: widget.selectedIndex == index ? Colors.white : Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
