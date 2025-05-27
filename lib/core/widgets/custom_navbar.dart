




import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';

class NavigationBarItems extends StatelessWidget {
  final bool showBarcode;

  const NavigationBarItems({
    super.key,
    this.showBarcode = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, int>(
      builder: (context, selectedIndex) {
        return Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // الخلفية المنحنية
            SizedBox(
              height: 80,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(context, 'assets/icons/home-agreement.png',
                        AppStrings.home.tr, 0, selectedIndex),
                    _buildNavItem(context, 'assets/icons/insurance-company.png',
                        AppStrings.companies.tr, 1, selectedIndex),
                    _buildNavItem(context, 'assets/icons/setting.png',
                        AppStrings.settings.tr, 2, selectedIndex),
                    _buildNavItem(context, 'assets/icons/photo.png',
                        AppStrings.profile.tr, 3, selectedIndex),
                  ],
                ),
              ),
            ),

            // أيقونة الباركود المنبثقة
            if (showBarcode)
              Positioned(
                top: -35,
                child: _buildBarcodeButton(context),
              ),
          ],
        );
      },
    );
  }

  Widget _buildNavItem(BuildContext context, String iconPath, String label,
      int idx, int selectedIndex) {
    final theme = Theme.of(context);
    final primary = AppColors.info;
    final unselected = AppColors.grey;

    final isSelected = idx == selectedIndex;

    return InkWell(
      onTap: () {
        context.read<NavCubit>().changeTab(idx);
        final route = _getRoute(idx);
        customNavigat(context, route);
      },
      splashColor: primary.withOpacity(0.3),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? primary.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // أيقونة قابلة للتكبير
            TweenAnimationBuilder<double>(
              tween: Tween(begin: isSelected ? 1.0 : 0.8, end: isSelected ? 1.0 : 0.8),
              duration: const Duration(milliseconds: 250),
              builder: (context, scale, child) => Transform.scale(
                scale: scale,
                child: child,
              ),
              child: Image.asset(
                iconPath,
                width: 28,
                height: 28,
                color: isSelected ? primary : unselected,
              ),
            ),

            const SizedBox(height: 4),

            // نص متغير
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: theme.textTheme.labelSmall!.copyWith(
                color: isSelected ? primary : unselected,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBarcodeButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // تعامل مع الباركود
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 2),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.deepGrey, width: 2),
          ),
          child: Icon(Icons.qr_code, size: 32, color: AppColors.deepGrey),
        ),
      ),
    );
  }

  String _getRoute(int index) {
    switch (index) {
      case 0:
        return '/homeView';
      case 1:
        return '/companies';
      case 2:
        return '/settings';
      case 3:
        return '/profile';
      default:
        return '/homeView';
    }
  }
}






















// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mutazan_plus/core/functions/navigation.dart';
// import 'package:mutazan_plus/core/utils/app_colors.dart';

// class NavigationBarItems extends StatefulWidget {
//   final int selectedIndex;
//   final bool showBarcode;

//   const NavigationBarItems({
//     super.key,
//     required this.selectedIndex,
//     this.showBarcode = false,
//   });

//   @override
//   State<NavigationBarItems> createState() => _NavigationBarItemsState();
// }

// class _NavigationBarItemsState extends State<NavigationBarItems> {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       alignment: Alignment.topCenter,
//       children: [
//         SizedBox(
//           height: 80,
//           child: Container(
//             decoration: BoxDecoration(
//               color: AppColors.backgroundColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(40),
//                 topRight: Radius.circular(40),
//               ),
//             ),
//             padding: const EdgeInsets.symmetric(vertical: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 _buildNavItem('assets/icons/home-agreement.png', "home".tr, 0),
//                 _buildNavItem('assets/icons/insurance-company.png', "company".tr, 1),
//                 _buildNavItem('assets/icons/setting.png', "settings".tr, 2),
//                 _buildNavItem('assets/icons/notification.png', "notifications".tr, 3),
//               ],
//             ),
//           ),
//         ),

//         // أيقونة الباركود مع الفاصل الأبيض
//         if (widget.showBarcode)
//           Positioned(
//             top: -35, // رفع العنصر للأعلى ليخرج من حدود الناف بار
//             child: Column(
//               children: [
//                 // الفاصل الأبيض - دائرة كبيرة
//                 Container(
//                   width: 60,
//                   height: 60,
//                   decoration: BoxDecoration(
//                     color: Colors.white, // لون الفاصل الأبيض
//                     shape: BoxShape.rectangle,
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 8,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   alignment: Alignment.center,
//                   child: Container(
//                     width: 55,
//                     height: 55,
//                     decoration: BoxDecoration(
//                       color: Colors.white, // لون الخلفية
//                       borderRadius: BorderRadius.circular(15),
//                       border: Border.all(color: Colors.blueGrey, width: 3),
//                     ),
//                     child: IconButton(
//                       icon: const Icon(Icons.qr_code,
//                           size: 35, color: Colors.blueGrey),
//                       onPressed: () {
//                         // كود فتح الكاميرا أو صفحة الباركود
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }

//   Widget _buildNavItem(String iconPath, String label, int index) {
//     bool isSelected = widget.selectedIndex == index;
//     return InkWell(
//       onTap: () {
//         customNavigat(context, _getRoute(index)); // استخدام GoRouter
//       },
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Image.asset(
//             iconPath,
//             width: 24,
//             height: 24,
//             color: isSelected ? Colors.blue : Colors.grey,
//           ),
//           const SizedBox(height: 4), // مسافة بين الأيقونة والنص
//           Text(
//             label,
//             style: TextStyle(
//               color: isSelected ? Colors.blue : Colors.grey,
//               fontSize: 12,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // String _getRoute(int index) {
//   //   switch (index) {
//   //     case 0:
//   //       return '/Home';
//   //     case 1:
//   //       return '/Company';
//   //     case 2:
//   //       return '/settings';
//   //     case 3:
//   //       return '/notifications';
//   //     default:
//   //       return '/Home';
//   //   }
//   // }
//   String _getRoute(int index) {
//     switch (index) {
//       case 0:
//         return '/homeView'; // متوافق مع router.dart
//       case 1:
//         return '/companies';
//       case 2:
//         return '/settings';
//       case 3:
//         return '/notifications';
//       default:
//         return '/homeView';
//     }
//   }
// }
