import 'package:flutter/material.dart';
import 'package:quagga/precentation/pages/auth_pages/registration_page.dart';
import 'package:quagga/utils/colors.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, RegistrationPage.routeName),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Don't have a account?",
              style: TextStyle(fontSize: 18, color: kWhite),
            ),
            Text(
              "Register right now",
              style: TextStyle(fontSize: 18, color: kOrangeColor),
            ),
          ],
        ),
      ),
    );
  }
}
