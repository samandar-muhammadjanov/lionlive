// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quagga/precentation/pages/auth_pages/registration_page.dart';
import 'package:quagga/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const routeName = "/auth";
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                Text(
                  "Authintication",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: kWhite,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains("@")) {
                      return "Not valid email";
                    }
                    return null;
                  },
                  key: const ValueKey("email"),
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kGreyColor,
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "This field cannot be empty";
                    }
                    return null;
                  },
                  obscureText: isPasswrodVisible,
                  key: const ValueKey("password"),
                  controller: passwordController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kGreyColor,
                    hintText: "Password",
                    suffixIcon: IconButton(
                      onPressed: () => setState(
                          () => isPasswrodVisible = !isPasswrodVisible),
                      icon: Icon(isPasswrodVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      try {
                        userCredential = await auth.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        print(userCredential);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                              MaterialBanner(
                                  content: const Text(
                                      "No user found for that email."),
                                  actions: [
                                IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentMaterialBanner();
                                    },
                                    icon: const Icon(Icons.close))
                              ]));
                        } else if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              content: const Text(
                                  "Wrong password provided for that user."),
                              actions: [
                                IconButton(
                                    onPressed: () {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentMaterialBanner();
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
                    "Log In",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, RegistrationPage.routeName),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
