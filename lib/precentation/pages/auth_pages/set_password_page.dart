// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quagga/precentation/pages/auth_pages/login_page.dart';
import 'package:quagga/utils/colors.dart';

class SetPasswordPage extends StatefulWidget {
  const SetPasswordPage({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  State<SetPasswordPage> createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final auth = FirebaseAuth.instance;
  UserCredential? userCredential;
  bool isPasswrodVisible = true;
  bool isConfirmPasswrodVisible = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      backgroundColor: kPrimaryColor,
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
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
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return "This field cannot be less then 8 character";
                  }
                  return null;
                },
                key: const ValueKey("password"),
                controller: passwordController,
                obscureText: isPasswrodVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kGreyColor,
                  hintText: "Password",
                  suffixIcon: IconButton(
                    onPressed: () =>
                        setState(() => isPasswrodVisible = !isPasswrodVisible),
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
                height: 20,
              ),
              TextFormField(
                obscureText: isConfirmPasswrodVisible,
                controller: confirmPasswordController,
                validator: (value) {
                  if (value!.isEmpty || value.length < 8) {
                    return "This field cannot be less then 8 character";
                  } else if (value != passwordController.text) {
                    return "Confirm Password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kGreyColor,
                  hintText: "Confirm Password",
                  suffixIcon: IconButton(
                    onPressed: () => setState(() =>
                        isConfirmPasswrodVisible = !isConfirmPasswrodVisible),
                    icon: Icon(isConfirmPasswrodVisible
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
                  final userData = widget.userData;
                  FocusScope.of(context).unfocus();
                  if (formKey.currentState!.validate()) {
                    try {
                      userCredential =
                          await auth.createUserWithEmailAndPassword(
                              email: userData['email'],
                              password: passwordController.text);
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(userCredential!.user!.uid)
                          .set({
                        "email": userData["email"],
                        "fullName": userData["fullName"],
                        "gender": userData["gender"],
                        "birthDate": userData["birthDate"]
                      });
                    } on FirebaseException catch (e) {
                      ScaffoldMessenger.of(context).showMaterialBanner(
                          MaterialBanner(content: Text(e.message!), actions: [
                        IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .hideCurrentMaterialBanner();
                            },
                            icon: const Icon(Icons.close))
                      ]));
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
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
