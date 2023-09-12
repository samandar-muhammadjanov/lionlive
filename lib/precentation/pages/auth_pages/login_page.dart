// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quagga/precentation/widgets/google_phone.dart';
import 'package:quagga/precentation/widgets/login_via_email.dart';
import 'package:quagga/precentation/widgets/register_widget.dart';
import 'package:quagga/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = "/auth";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isEmail = true;

  void changeToPhone(bool isEmail) {
    setState(() {
      this.isEmail = isEmail;
    });
  }

  bool isPasswrodVisible = true;
  final auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                LoginForm(
                  key: const ValueKey("loginviaemail"),
                  emailController: emailController,
                  isPasswrodVisible: isPasswrodVisible,
                  passwordController: passwordController,
                  isEmail: isEmail,
                ),
                ElevatedButton(
                  onPressed: loginViaEmail,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shadowColor: kPrimaryColor,
                    backgroundColor: kOrangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  child: const Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                GoogleSignInAndPhoneNumberSignIn(
                  text: emailController.text,
                ),
                const Spacer(),
                const RegisterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginViaEmail() async {
    FocusScope.of(context).unfocus();
    if (formKey.currentState!.validate()) {
      try {
        userCredential = await auth.signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
              content: const Text("No user found for that email."),
              actions: [
                IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    icon: const Icon(Icons.close))
              ]));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showMaterialBanner(
            MaterialBanner(
              content: const Text("Wrong password provided for that user."),
              actions: [
                IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
