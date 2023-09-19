import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quagga/precentation/pages/auth_pages/verify_phone_page.dart';
import 'package:quagga/precentation/widgets/w_elevtaed_button.dart';
import 'package:quagga/precentation/widgets/w_google_phone_email.dart';
import 'package:quagga/precentation/widgets/w_textfield.dart';
import 'package:quagga/utils/colors.dart';
import 'package:country_picker/country_picker.dart';

class RegistrationPageWithPhoneNumber extends StatefulWidget {
  const RegistrationPageWithPhoneNumber({super.key});
  static const routeName = "/auth/register/phone";
  @override
  State<RegistrationPageWithPhoneNumber> createState() =>
      _RegistrationPageWithPhoneNumberState();
}

class _RegistrationPageWithPhoneNumberState
    extends State<RegistrationPageWithPhoneNumber> {
  TextEditingController controller = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Country selectedCountry = Country(
      phoneCode: "998",
      countryCode: "UZ",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "Uzbekistan",
      example: "Uzbekistan",
      displayName: "Uzbekistan",
      displayNameNoCountryCode: "UZ",
      e164Key: "");
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
                  height: 10,
                ),
                Text(
                  "Enter your phone number we will send verification code",
                  style: TextStyle(color: kWhite),
                ),
                const SizedBox(
                  height: 30,
                ),
                WTextField(
                    title: "Phone Number",
                    type: TextInputType.phone,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    controller: controller,
                    prefix: Container(
                      padding: const EdgeInsets.fromLTRB(10, 13, 0, 0),
                      child: InkWell(
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            countryListTheme: CountryListThemeData(
                                bottomSheetHeight:
                                    MediaQuery.of(context).size.height * 0.5),
                            onSelect: (value) {
                              setState(() {
                                selectedCountry = value;
                              });
                            },
                          );
                        },
                        child: Text(
                          "${selectedCountry.flagEmoji} + ${selectedCountry.phoneCode}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                WElevetedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber:
                                "+${selectedCountry.phoneCode}${controller.text}",
                            verificationCompleted:
                                (PhoneAuthCredential credential) async {
                              await FirebaseAuth.instance
                                  .signInWithCredential(credential);
                            },
                            verificationFailed: (FirebaseAuthException e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.message!)));
                            },
                            codeSent:
                                (String verificationId, int? resendToken) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerifyPhonePage(
                                        verificationId: verificationId),
                                  ));
                            },
                            timeout: const Duration(seconds: 60),
                            codeAutoRetrievalTimeout:
                                (String verificationId) {},
                          );
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message!)));
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                    title: "Continue"),
                const Spacer(),
                GoogleSignInAndPhoneNumberSignIn(
                  text: controller.text,
                  isEmail: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
