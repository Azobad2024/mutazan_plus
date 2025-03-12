import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatefulWidget {
  static const String routeName = '/notifications';

  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'newInvoice'.tr, // استخدام الترجمة
      message: 'newInvoiceMessage'.tr, // استخدام الترجمة
      time: DateTime.now().subtract(const Duration(hours: 1)),
      isRead: false,
    ),
    NotificationItem(
      title: 'fileUpdated'.tr, // استخدام الترجمة
      message: 'fileUpdatedMessage'.tr, // استخدام الترجمة
      time: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('notifications'.tr), // استخدام الترجمة
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              // حذف جميع الإشعارات
              setState(() {
                notifications.clear();
              });
            },
          ),
        ],
      ),
      body: notifications.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.notifications_off,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'noNotifications'.tr, // استخدام الترجمة
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Dismissible(
            key: Key(notification.time.toString()),
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                notifications.removeAt(index);
              });
            },
            child: Card(
              elevation: notification.isRead ? 1 : 3,
              margin: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                  notification.isRead ? Colors.grey : Colors.blue,
                  child: const Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  notification.title,
                  style: TextStyle(
                    fontWeight: notification.isRead
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(notification.message),
                    Text(
                      _formatTime(notification.time),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  setState(() {
                    notification.isRead = true;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inMinutes < 60) {
      return 'minutesAgo'.trParams({'minutes': difference.inMinutes.toString()}); // استخدام الترجمة مع المعاملات
    } else if (difference.inHours < 24) {
      return 'hoursAgo'.trParams({'hours': difference.inHours.toString()}); // استخدام الترجمة مع المعاملات
    } else {
      return 'daysAgo'.trParams({'days': difference.inDays.toString()}); // استخدام الترجمة مع المعاملات
    }
  }
}

class NotificationItem {
  final String title;
  final String message;
  final DateTime time;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });
}