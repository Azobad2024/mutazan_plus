import 'package:get/get.dart'; // استيراد GetX
import '../view/Company.dart';
import '../view/Home.dart';
import '../view/Login.dart';
import '../view/profile_page.dart';
import '../view/Settings.dart';
import '../view/Notifications.dart';

final List<GetPage> routers = [
  GetPage(
    name: Home.routeName, // اسم الصفحة
    page: () => Home(), // الصفحة
  ),
  GetPage(
    name: LoginScreenWithWelcome.routeName,
    page: () => LoginScreenWithWelcome(),
  ),
  GetPage(
    name: Company.routeName,
    page: () => const Company(),
  ),
  GetPage(
    name: ProfilePage1.routeName,
    page: () => const ProfilePage1(),
  ),
  GetPage(
    name: '/settings',
    page: () => const Settings(),
  ),
  GetPage(
    name: Notifications.routeName,
    page: () => const Notifications(),
  ),
];