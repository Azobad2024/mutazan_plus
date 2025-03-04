import 'package:flutter/material.dart';

import '../view/Company.dart';
import '../view/Home.dart';
import '../view/Login.dart';
import '../view/profile_page.dart';
import '../view/Settings.dart';
import '../view/Notifications.dart';

final Map<String,WidgetBuilder> routers={
  Home.routeName:(context)=>Home(),
  LoginScreenWithWelcome.routeName:(context)=>LoginScreenWithWelcome(),
  Company.routeName:(context)=>Company(),
  ProfilePage1.routeName:(context)=>ProfilePage1(),
  '/settings':(context)=>const Settings(),
  Notifications.routeName:(context)=>const Notifications(),
};