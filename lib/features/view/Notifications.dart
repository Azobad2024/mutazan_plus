import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/widgets/container_radius.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

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
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          AppStrings.notifications.tr,
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
    
      // bottomNavigationBar: BlocBuilder<NavCubit, int>(
      //   builder: (context, selectedIndex) {
      //     return Container(
      //       color:Theme.of(context).canvasColor,
      //       // padding: const EdgeInsets.symmetric(vertical: 8),
      //       child: NavigationBarItems(
      //         showBarcode: false,
      //       ),
      //     );
      //   },
      // ),
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