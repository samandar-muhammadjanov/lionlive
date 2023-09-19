import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:quagga/precentation/pages/auth_pages/full_registration_page.dart';
import 'package:quagga/precentation/widgets/w_elevtaed_button.dart';
import 'package:quagga/utils/colors.dart';

class VerifyPhonePage extends StatefulWidget {
  const VerifyPhonePage({super.key, this.verificationId});
  static const routeName = "/auth/verify";
  final String? verificationId;

  @override
  State<VerifyPhonePage> createState() => _VerifyPhonePageState();
}

class _VerifyPhonePageState extends State<VerifyPhonePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                "Verification",
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: kWhite,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Enter verification code from sms",
                style: TextStyle(color: kWhite),
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                controller: controller,
                onSubmitted: (value) async {
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(
                      PhoneAuthProvider.credential(
                        verificationId: widget.verificationId!,
                        smsCode: controller.text,
                      ),
                    )
                        .then((value) {
                      print(value);
                    });
                  } on FirebaseException catch (e) {
                    print(e);
                  }
                },
                defaultPinTheme: PinTheme(
                  width: 70,
                  height: 50,
                  decoration: BoxDecoration(
                    color: kGreyColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Spacer(),
              WElevetedButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(
                        PhoneAuthProvider.credential(
                          verificationId: widget.verificationId!,
                          smsCode: controller.text,
                        ),
                      )
                          .then((value) {
                        if (value.user != null) {
                          Navigator.pushReplacementNamed(
                              context, FullRegistrationPage.routeName);
                        }
                      });
                    } on FirebaseException catch (e) {
                      print(e);
                    }
                  },
                  title: "Verify"),
            ],
          ),
        ),
      ),
    );
  }
}
