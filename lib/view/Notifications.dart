import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/widgets/container_radius.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';
import 'package:mutazan_plus/core/widgets/custom_navbar.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'newInvoice'.tr,
      message: 'newInvoiceMessage'.tr,
      time: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
    ),
    NotificationItem(
      title: 'fileUpdated'.tr,
      message: 'fileUpdatedMessage'.tr,
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
  ];

  String _formatTime(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) {
      return 'minutesAgo'.trParams({'minutes': diff.inMinutes.toString()});
    } else if (diff.inHours < 24) {
      return 'hoursAgo'.trParams({'hours': diff.inHours.toString()});
    } else {
      return 'daysAgo'.trParams({'days': diff.inDays.toString()});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(), // أو HomeCubit حسب البلوك الذي تستخدمه
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          automaticallyImplyLeading: false,
          title: Text(
            'notifications'.tr,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_sweep, color: Colors.white),
              onPressed: () => setState(() => notifications.clear()),
            )
          ],
        ),

        // بدل body مباشرة، نلفّها داخل ContainerRadius
        body: SafeArea(
          child: ContainerRadius(
            child: notifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.notifications_off,
                            size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text('noNotifications'.tr,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey)),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    itemCount: notifications.length,
                    itemBuilder: (context, i) {
                      final n = notifications[i];
                      return Dismissible(
                        key: ValueKey(n.time.toIso8601String()),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) =>
                            setState(() => notifications.removeAt(i)),
                        child: Card(
                          elevation: n.isRead ? 1 : 4,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  n.isRead ? Colors.grey : Colors.blue,
                              child: const Icon(Icons.notifications,
                                  color: Colors.white),
                            ),
                            title: Text(
                              n.title,
                              style: TextStyle(
                                fontWeight: n.isRead
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(n.message),
                                const SizedBox(height: 4),
                                Text(_formatTime(n.time),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey)),
                              ],
                            ),
                            onTap: () => setState(() => n.isRead = true),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),

        bottomNavigationBar: BlocBuilder<NavCubit, int>(
          builder: (context, selectedIndex) {
            return Container(
              color: AppColors.White,
              // padding: const EdgeInsets.symmetric(vertical: 8),
              child: NavigationBarItems(
                showBarcode: false,
              ),
            );
          },
        ),
      ),
    );
  }
}

class NotificationItem {
  final String title, message;
  final DateTime time;
  bool isRead;
  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:mutazan_plus/core/utils/app_colors.dart';
// import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
// import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';

// class Notifications extends StatefulWidget {
//   // static const String routeName = '/notifications';

//   const Notifications({super.key});

//   @override
//   State<Notifications> createState() => _NotificationsState();
// }

// class _NotificationsState extends State<Notifications> {
//   final List<NotificationItem> notifications = [
//     NotificationItem(
//       title: 'newInvoice'.tr, // استخدام الترجمة
//       message: 'newInvoiceMessage'.tr, // استخدام الترجمة
//       time: DateTime.now().subtract(const Duration(hours: 1)),
//       isRead: false,
//     ),
//     NotificationItem(
//       title: 'fileUpdated'.tr, // استخدام الترجمة
//       message: 'fileUpdatedMessage'.tr, // استخدام الترجمة
//       time: DateTime.now().subtract(const Duration(hours: 2)),
//       isRead: true,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => NavCubit(),
//       child: Scaffold(
//         backgroundColor: AppColors.backgroundColor,
//         appBar: AppBar(
//           backgroundColor: AppColors.backgroundColor,
//           title: Text(
//             'notifications'.tr,
//             style: TextStyle(
//                 color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
//           ), // استخدام الترجمة
//           automaticallyImplyLeading: false,
//           centerTitle: true,
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.delete_sweep,color: Colors.white,),
//               onPressed: () {
//                 // حذف جميع الإشعارات
//                 setState(() {
//                   notifications.clear();
//                 });
//               },
//             ),
//           ],
//         ),
//         body: notifications.isEmpty
//             ? Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(
//                       Icons.notifications_off,
//                       size: 64,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(height: 16),
//                     Text(
//                       'noNotifications'.tr, // استخدام الترجمة
//                       style: const TextStyle(
//                         fontSize: 18,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             : ListView.builder(
//                 itemCount: notifications.length,
//                 itemBuilder: (context, index) {
//                   final notification = notifications[index];
//                   return Dismissible(
//                     key: Key(notification.time.toString()),
//                     background: Container(
//                       color: Colors.red,
//                       alignment: Alignment.centerLeft,
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: const Icon(
//                         Icons.delete,
//                         color: Colors.white,
//                       ),
//                     ),
//                     onDismissed: (direction) {
//                       setState(() {
//                         notifications.removeAt(index);
//                       });
//                     },
//                     child: Card(
//                       elevation: notification.isRead ? 1 : 3,
//                       margin: const EdgeInsets.symmetric(
//                         horizontal: 8,
//                         vertical: 4,
//                       ),
//                       child: ListTile(
//                         leading: CircleAvatar(
//                           backgroundColor:
//                               notification.isRead ? Colors.grey : Colors.blue,
//                           child: const Icon(
//                             Icons.notifications,
//                             color: Colors.white,
//                           ),
//                         ),
//                         title: Text(
//                           notification.title,
//                           style: TextStyle(
//                             fontWeight: notification.isRead
//                                 ? FontWeight.normal
//                                 : FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(notification.message),
//                             Text(
//                               _formatTime(notification.time),
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.grey,
//                               ),
//                             ),
//                           ],
//                         ),
//                         onTap: () {
//                           setState(() {
//                             notification.isRead = true;
//                           });
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//         bottomNavigationBar: Container(
//           color: AppColors.White,
//           padding: const EdgeInsets.symmetric(vertical: 0),
//           child: const NavigationBarItems(showBarcode: false),
//         ),
//       ),
//     );
//   }

//   String _formatTime(DateTime time) {
//     final difference = DateTime.now().difference(time);
//     if (difference.inMinutes < 60) {
//       return 'minutesAgo'.trParams({
//         'minutes': difference.inMinutes.toString()
//       }); // استخدام الترجمة مع المعاملات
//     } else if (difference.inHours < 24) {
//       return 'hoursAgo'.trParams({
//         'hours': difference.inHours.toString()
//       }); // استخدام الترجمة مع المعاملات
//     } else {
//       return 'daysAgo'.trParams({
//         'days': difference.inDays.toString()
//       }); // استخدام الترجمة مع المعاملات
//     }
//   }
// }

// class NotificationItem {
//   final String title;
//   final String message;
//   final DateTime time;
//   bool isRead;

//   NotificationItem({
//     required this.title,
//     required this.message,
//     required this.time,
//     this.isRead = false,
//   });
// }
