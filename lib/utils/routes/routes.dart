import 'package:openelifba/presentation/category/category.dart';
import 'package:openelifba/presentation/home/home.dart';
import 'package:openelifba/presentation/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String home = '/home';
  static const String category = '/category';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const SplashScreen(),
    home: (BuildContext context) => const HomeScreen(),
    category: (BuildContext context) => const CategoryScreen(),
  };
}
