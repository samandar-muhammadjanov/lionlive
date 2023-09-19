// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:quagga/precentation/widgets/w_elevtaed_button.dart';
import 'package:quagga/precentation/widgets/w_register_widget.dart';
import 'package:quagga/precentation/widgets/w_textfield.dart';
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
                  height: 20,
                ),
                WTextField(
                  title: "Emial or Phone Number",
                  controller: emailController,
                ),
                const SizedBox(
                  height: 10,
                ),
                WTextField(
                  controller: passwordController,
                  title: "Password",
                  obscureText: isPasswrodVisible,
                  suffix: IconButton(
                    onPressed: () {
                      setState(() {
                        isPasswrodVisible = !isPasswrodVisible;
                      });
                    },
                    icon: Icon(
                      isPasswrodVisible
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                WElevetedButton(onPressed: loginViaEmail, title: "Log In"),
                const Spacer(),
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
