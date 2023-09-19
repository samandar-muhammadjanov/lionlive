// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quagga/precentation/pages/auth_pages/full_registration_page.dart';
import 'package:quagga/precentation/widgets/w_google_phone_email.dart';
import 'package:quagga/precentation/widgets/w_textfield.dart';
import 'package:quagga/utils/colors.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  static const routeName = "/auth/register";

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  UserCredential? userCredential;
  final auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isVisiblePassword = false;
  bool isVisibleConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Registration",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: kWhite,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                WTextField(
                  validator: (value) {
                    if (value!.isEmpty ||
                        !value.contains("@") ||
                        !value.contains(".")) {
                      return "Not Valid Emial";
                    }
                    return null;
                  },
                  controller: emailController,
                  title: "Email",
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 10,
                ),
                WTextField(
                    controller: passwordController,
                    title: "Password",
                    obscureText: isVisiblePassword,
                    validator: (value) {
                      if (value!.isEmpty && value.length < 8) {
                        return "Password cannot be less then 8 character";
                      }
                      return null;
                    },
                    suffix: IconButton(
                      onPressed: () => setState(
                          () => isVisiblePassword = !isVisiblePassword),
                      icon: Icon(isVisiblePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    )),
                const SizedBox(
                  height: 10,
                ),
                WTextField(
                    title: "Confirm Password",
                    validator: (value) {
                      if (value!.isEmpty && value.length < 8) {
                        return "Password cannot be less then 8 character";
                      } else if (value != passwordController.text) {
                        return "Confirm paswrod please";
                      }
                      return null;
                    },
                    obscureText: isVisibleConfirmPassword,
                    suffix: IconButton(
                      onPressed: () => setState(() =>
                          isVisibleConfirmPassword = !isVisibleConfirmPassword),
                      icon: Icon(isVisibleConfirmPassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    )),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        userCredential = await auth
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          if (value.user != null) {
                            Navigator.pushReplacementNamed(
                                context, FullRegistrationPage.routeName);
                          }
                          return null;
                        });
                      } on FirebaseAuthException catch (e) {
                        print(e.message);
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
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
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GoogleSignInAndPhoneNumberSignIn(
                  text: emailController.text,
                  isEmail: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
