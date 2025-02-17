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
        topLeft: Radius.circular(40),
        topRight: Radius.circular(40),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: backgroundColor, // لون الناف بار
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
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
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('assets/icons/home-agreement.png', "Home", 0),
            _buildNavItem('assets/icons/insurance-company.png', "Company", 1),
            _buildNavItem('assets/icons/setting.png', "Setting", 2),
            _buildNavItem('assets/icons/notification.png', "Notification", 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
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
            Navigator.pushNamed(context, '/notification');
            break;
          case 3:
            Navigator.pushNamed(context, '/settings');
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            height: 27,
            width: 27,
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
