import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('اللغة'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // إضافة وظيفة تغيير اللغة
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('المظهر'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // إضافة وظيفة تغيير المظهر
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('الإشعارات'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // إضافة وظيفة إعدادات الإشعارات
              },
            ),
          ),
        ],
      ),
    );
  }
}
