import 'package:flutter/material.dart';

import '../view/Company.dart';
import '../view/Home.dart';


final Map<String,WidgetBuilder> routers={

  Home.routeName:(context)=>Home(),
  Company.routeName:(context)=>Company(),
};