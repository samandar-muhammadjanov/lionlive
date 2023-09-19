import 'package:flutter/material.dart';
import 'package:quagga/precentation/pages/auth_pages/full_registration_page.dart';
import 'package:quagga/precentation/pages/auth_pages/login_page.dart';
import 'package:quagga/precentation/pages/auth_pages/registration_page.dart';
import 'package:quagga/precentation/pages/auth_pages/verify_phone_page.dart';
import 'package:quagga/precentation/pages/chat_inside_page.dart';
import 'package:quagga/precentation/pages/profile_settings_page.dart';

class AppRoute {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RegistrationPage.routeName:
        return MaterialPageRoute(
          builder: (context) => RegistrationPage(),
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case ChatInsidePage.routeName:
        return MaterialPageRoute(
          builder: (context) => ChatInsidePage(),
        );
      case VerifyPhonePage.routeName:
        return MaterialPageRoute(
          builder: (context) => const VerifyPhonePage(),
        );
      case FullRegistrationPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const FullRegistrationPage(),
        );
      case ProfileSettingsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const ProfileSettingsPage(),
        );
      default:
        break;
    }
    return null;
  }
}
