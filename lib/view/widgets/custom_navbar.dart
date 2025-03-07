import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';

class NavigationBarItems extends StatefulWidget {
  final int selectedIndex;
  final bool showBarcode;

  const NavigationBarItems({
    super.key,
    required this.selectedIndex,
    this.showBarcode = false,
  });

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
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem('assets/icons/home-agreement.png', "home".tr, 0),
                _buildNavItem('assets/icons/insurance-company.png', "company".tr, 1),
                _buildNavItem('assets/icons/setting.png', "settings".tr, 2),
                _buildNavItem('assets/icons/notification.png', "notifications".tr, 3),
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
                    boxShadow: const [
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
                      icon: const Icon(Icons.qr_code,
                          size: 35, color: Colors.blueGrey),
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
        Get.toNamed(_getRoute(index)); // استخدام GetX للتنقل
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
          const SizedBox(height: 4), // مسافة بين الأيقونة والنص
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
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
        return '/notifications';
      default:
        return '/Home';
    }
  }
}