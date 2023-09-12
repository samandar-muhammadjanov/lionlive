import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quagga/precentation/widgets/google_phone.dart';
import 'package:quagga/utils/colors.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  static const routeName = "/auth/register";
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  key: const ValueKey("controller"),
                  validator: (value) {
                    if (isNumeric(value!.split("+").join())) {
                      if (value.isEmpty) {
                        return "Not Valid Phone Number";
                      }
                    } else {
                      if (value.isEmpty || !value.contains("@")) {
                        return "Not Valid Email";
                      }
                    }
                    return null;
                  },
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kGreyColor,
                    labelText: "Email or phone number",
                    labelStyle: TextStyle(color: kOrangeColor),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: kOrangeColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: kOrangeColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (isNumeric(
                        controller.text.split("+").join(),
                      )) {
                        try {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: controller.text,
                            verificationCompleted:
                                (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {},
                            codeSent:
                                (String verificationId, int? resendToken) {},
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showMaterialBanner(
                            MaterialBanner(
                              content: Text(e.message!),
                              actions: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.close),
                                )
                              ],
                            ),
                          );
                        } catch (e) {
                          print(e);
                        }
                      } else {
                        print("set password");
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
                const Spacer(),
                GoogleSignInAndPhoneNumberSignIn(text: controller.text),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isNumeric(String text) {
    final numericRegex = RegExp(r'^[0-9]');
    return numericRegex.hasMatch(text);
  }
}
