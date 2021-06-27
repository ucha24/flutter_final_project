import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/login.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(
        builder: (_) => const Login(),
      );
    } else if (settings.name == Home.routeName) {
      String userId = settings.arguments as String;

      return MaterialPageRoute(
        builder: (_) => Home(
          userId: userId,
        ),
      );
    } else {
      return null;
    }
  }
}
