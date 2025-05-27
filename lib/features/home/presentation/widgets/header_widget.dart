// import 'package:flutter/material.dart';
// import 'package:responsive_framework/responsive_framework.dart';
// import 'package:mutazan_plus/core/functions/navigation.dart';

// class HeaderWidget extends StatelessWidget {
//   /// عدد الإشعارات غير المقروءة
//   final int notificationCount;

//   const HeaderWidget({
//     super.key,
//     this.notificationCount = 0,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     // paddings ريّسبونسيف
//     final horizontalPad = ResponsiveValue<double>(
//       context,
//       defaultValue: 16,
//       conditionalValues: const [
//         Condition.largerThan(name: MOBILE, value: 24),
//         Condition.largerThan(name: TABLET, value: 32),
//       ],
//     ).value!;

//     // حجم الأيقونة ريّسبونسيف
//     final iconSize = ResponsiveValue<double>(
//       context,
//       defaultValue: 28,
//       conditionalValues: const [
//         Condition.largerThan(name: TABLET, value: 32),
//       ],
//     ).value!;

//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // الشعار
//           Image.asset(
//             'assets/images/asd01.png',
//             height: ResponsiveValue<double>(
//               context,
//               defaultValue: 90,
//               conditionalValues: const [
//                 Condition.largerThan(name: TABLET, value: 80),
//               ],
//             ).value!,
//           ),

//           // أيقونة الإشعارات مع badge
//           GestureDetector(
//             onTap: () => customNavigat(context, '/notifications'),
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Icon(
//                   Icons.notifications_outlined,
//                   size: iconSize,
//                   color: theme.iconTheme.color,
//                 ),

//                 // الـ badge في أعلى اليمين
//                 if (notificationCount > 0)
//                   Positioned(
//                     right: -4,
//                     top: -4,
//                     child: Container(
//                       padding: EdgeInsets.all(
//                         ResponsiveValue<double>(
//                           context,
//                           defaultValue: 2,
//                           conditionalValues: const [
//                             Condition.largerThan(name: TABLET, value: 4),
//                           ],
//                         ).value!,
//                       ),
//                       decoration: BoxDecoration(
//                         color: theme.colorScheme.error,
//                         shape: BoxShape.circle,
//                       ),
//                       constraints: BoxConstraints(
//                         minWidth: ResponsiveValue<double>(
//                           context,
//                           defaultValue: 16,
//                           conditionalValues: const [
//                             Condition.largerThan(name: TABLET, value: 20),
//                           ],
//                         ).value!,
//                         minHeight: ResponsiveValue<double>(
//                           context,
//                           defaultValue: 16,
//                           conditionalValues: const [
//                             Condition.largerThan(name: TABLET, value: 20),
//                           ],
//                         ).value!,
//                       ),
//                       child: Center(
//                         child: Text(
//                           notificationCount > 99 ? '99+' : '$notificationCount',
//                           style: theme.textTheme.bodySmall!.copyWith(
//                             color: theme.colorScheme.onError,
//                             fontSize: ResponsiveValue<double>(
//                               context,
//                               defaultValue: 10,
//                               conditionalValues: const [
//                                 Condition.largerThan(name: TABLET, value: 12),
//                               ],
//                             ).value!,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';

class HeaderWidget extends StatelessWidget {
  /// عدد الإشعارات غير المقروءة
  final int notificationCount;

  const HeaderWidget({
    super.key,
    this.notificationCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // رابط الصورة من الكاش (مثلاً "/media/..." فقط)
    final profilePath = CacheHelper().getData(key: ApiKey.profilePic) as String?;
    // إذا وجدت، نبني الرابط الكامل
    final avatarUrl = (profilePath != null && profilePath.isNotEmpty)
        ? '${EndPoint.baseUrl}$profilePath'
        : null;

    // paddings ريّسبونسيف
    final horizontalPad = ResponsiveValue<double>(
      context,
      defaultValue: 16,
      conditionalValues: const [
        Condition.largerThan(name: MOBILE, value: 24),
        Condition.largerThan(name: TABLET, value: 32),
      ],
    ).value!;

    // حجم الأيقونة ريّسبونسيف
    final iconSize = ResponsiveValue<double>(
      context,
      defaultValue: 28,
      conditionalValues: const [
        Condition.largerThan(name: TABLET, value: 32),
      ],
    ).value!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPad, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // شعار التطبيق
          Image.asset(
            'assets/images/asd01.png',
            height: ResponsiveValue<double>(
              context,
              defaultValue: 90,
              conditionalValues: const [
                Condition.largerThan(name: TABLET, value: 80),
              ],
            ).value,
          ),

          Row(
            children: [
          
              // أيقونة الإشعارات مع badge
              GestureDetector(
                onTap: () => customNavigat(context, '/notifications'),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      Icons.notifications_outlined,
                      size: iconSize,
                      color: theme.iconTheme.color,
                    ),
                    if (notificationCount > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: EdgeInsets.all(
                            ResponsiveValue<double>(
                              context,
                              defaultValue: 2,
                              conditionalValues: const [
                                Condition.largerThan(name: TABLET, value: 4),
                              ],
                            ).value,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.error,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: ResponsiveValue<double>(
                              context,
                              defaultValue: 16,
                              conditionalValues: const [
                                Condition.largerThan(name: TABLET, value: 20),
                              ],
                            ).value,
                            minHeight: ResponsiveValue<double>(
                              context,
                              defaultValue: 16,
                              conditionalValues: const [
                                Condition.largerThan(name: TABLET, value: 20),
                              ],
                            ).value,
                          ),
                          child: Center(
                            child: Text(
                              notificationCount > 99 ? '99+' : '$notificationCount',
                              style: theme.textTheme.bodySmall!.copyWith(
                                color: theme.colorScheme.onError,
                                fontSize: ResponsiveValue<double>(
                                  context,
                                  defaultValue: 10,
                                  conditionalValues: const [
                                    Condition.largerThan(name: TABLET, value: 12),
                                  ],
                                ).value,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: horizontalPad * 0.8),

               // صورة المستخدم
              GestureDetector(
                onTap: () => customNavigat(context, '/profile'),
                child: CircleAvatar(
                  radius: iconSize * 0.8,
                  backgroundImage: avatarUrl != null
                      ? NetworkImage(avatarUrl)
                      : const AssetImage('assets/images/myProfile.png')
                          as ImageProvider,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
