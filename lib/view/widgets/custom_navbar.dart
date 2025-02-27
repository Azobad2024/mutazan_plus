import 'package:flutter/material.dart';
import '../../constants.dart';

class NavigationBarItems extends StatefulWidget {
  final int selectedIndex;
  final bool showBarcode;

  NavigationBarItems({
    Key? key,
    required this.selectedIndex,
    this.showBarcode = false,
  }) : super(key: key);

  @override
  State<NavigationBarItems> createState() => _NavigationBarItemsState();
}

class _NavigationBarItemsState extends State<NavigationBarItems> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        SizedBox(
          height: 80,
          child: Container(
            decoration: const BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey,
              //     blurRadius: 15,
              //     spreadRadius: 5,
              //     offset: Offset(0, -4),
              //   ),
              // ],
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem('assets/icons/home-agreement.png', "  Home  ", 0),
                _buildNavItem('assets/icons/insurance-company.png', "Company", 1),
                _buildNavItem('assets/icons/setting.png', "Setting", 2),
                _buildNavItem('assets/icons/notification.png', "Notification", 3),
              ],
            ),
          ),
        ),

        // أيقونة الباركود مع الفاصل الأبيض
        if (widget.showBarcode)
          Positioned(
            top: -35, // رفع العنصر للأعلى ليخرج من حدود الناف بار
            child: Column(
              children: [
                // الفاصل الأبيض - دائرة كبيرة
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white, // لون الفاصل الأبيض
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Container(
                    width: 55,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white, // لون الخلفية
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blueGrey, width: 3),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.qr_code, size: 35, color: Colors.blueGrey),
                      onPressed: () {
                        // كود فتح الكاميرا أو صفحة الباركود
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildNavItem(String iconPath, String label, int index) {
    bool isSelected = widget.selectedIndex == index;
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.pushNamed(context, '/Home');
            break;
          case 1:
            Navigator.pushNamed(context, '/company');
            break;
          case 2:
            Navigator.pushNamed(context, '/settings');
            break;
          case 3:
            Navigator.pushNamed(context, '/notifications');
            break;
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 24,
            height: 24,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  String _getRoute(int index) {
    switch (index) {
      case 0:
        return '/Home';
      case 1:
        return '/Company';
      case 2:
        return '/settings';
      case 3:
        return '/notification';
      default:
        return '/Home';
    }
  }
}
