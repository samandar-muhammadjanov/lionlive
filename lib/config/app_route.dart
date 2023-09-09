import 'package:flutter/material.dart';
import 'package:quagga/precentation/pages/auth_pages/login_page.dart';
import 'package:quagga/precentation/pages/auth_pages/registration_page.dart';
import 'package:quagga/precentation/pages/chat_inside_page.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RegistrationPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const RegistrationPage(),
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case ChatInsidePage.routeName:
        return MaterialPageRoute(
          builder: (context) =>  ChatInsidePage(),
        );
      default:
        break;
    }
    return null;
  }
}
