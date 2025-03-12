import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  static Future<void> requestPermissions() async {
    // طلب إذن الكاميرا
    if (!await Permission.camera.isGranted) {
      await Permission.camera.request();
    }

    // طلب إذن التخزين
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }

    // طلب إذن إدارة التخزين لأندرويد 11+
    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  }
}
