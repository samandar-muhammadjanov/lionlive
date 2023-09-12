// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quagga/precentation/pages/dashboard.dart';
import 'package:quagga/provider/provider.dart';
import 'package:quagga/utils/colors.dart';

class GoogleSignInAndPhoneNumberSignIn extends StatefulWidget {
  const GoogleSignInAndPhoneNumberSignIn({
    super.key,
    required this.text,
  });

  final String text;
  @override
  State<GoogleSignInAndPhoneNumberSignIn> createState() =>
      _GoogleSignInAndPhoneNumberSignInState();
}

class _GoogleSignInAndPhoneNumberSignInState
    extends State<GoogleSignInAndPhoneNumberSignIn> {
  bool isEmail = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            OutlinedButton.icon(
              onPressed: () {
                try {
                  final provider =
                      Provider.of<AuthProvider>(context, listen: false);

                  provider.googleLogin();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Dashboard(),
                      ),
                      (route) => false);
                } catch (e) {}
              },
              style: OutlinedButton.styleFrom(
                primary: kOrangeColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: kLightBlueColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: SvgPicture.asset("assets/svg/google.svg"),
              label: const Text("Sign in with Google"),
            ),
          ],
        ),
      ],
    );
  }
}
