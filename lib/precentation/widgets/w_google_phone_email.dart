// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quagga/precentation/pages/auth_pages/register_with_phonenumber_page.dart';
import 'package:quagga/precentation/pages/auth_pages/registration_page.dart';
import 'package:quagga/provider/provider.dart';
import 'package:quagga/utils/colors.dart';

class GoogleSignInAndPhoneNumberSignIn extends StatefulWidget {
  const GoogleSignInAndPhoneNumberSignIn({
    super.key,
    required this.text,
    required this.isEmail,
  });

  final String text;
  final bool isEmail;
  @override
  State<GoogleSignInAndPhoneNumberSignIn> createState() =>
      _GoogleSignInAndPhoneNumberSignInState();
}

class _GoogleSignInAndPhoneNumberSignInState
    extends State<GoogleSignInAndPhoneNumberSignIn> {
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

                  provider.googleLogin(context);
                } catch (e) {}
              },
              style: OutlinedButton.styleFrom(
                primary: kWhite,
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
            const SizedBox(
              height: 20,
            ),
            OutlinedButton.icon(
              onPressed: () {
                if (widget.isEmail) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationPage(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const RegistrationPageWithPhoneNumber(),
                    ),
                  );
                }
              },
              style: OutlinedButton.styleFrom(
                primary: kWhite,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: kLightBlueColor),
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
                minimumSize: const Size(double.infinity, 50),
              ),
              icon: SvgPicture.asset(
                widget.isEmail
                    ? "assets/svg/email.svg"
                    : "assets/svg/phone.svg",
                color: kWhite,
              ),
              label: Text(widget.isEmail
                  ? "Sign in with Email"
                  : "Sign in with Phone Number"),
            ),
          ],
        ),
      ],
    );
  }
}
