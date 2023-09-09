import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quagga/precentation/pages/auth_pages/login_page.dart';
import 'package:quagga/precentation/pages/auth_pages/set_password_page.dart';
import 'package:quagga/precentation/widgets/selectGender.dart';
import 'package:quagga/utils/colors.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  static const routeName = "/auth/register";
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  
  TextEditingController emailController = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController birthDate = TextEditingController();
  TextEditingController description = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isMale = true;
  void changeGender(bool isMale) {
    setState(() {
      this.isMale = isMale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Form(
        key: formKey,
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
                16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 16),
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
                TextFormField(
                  key: const ValueKey("email"),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains("@")) {
                      return "Not Valid Email";
                    }
                    return null;
                  },
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
                      return "Not Valid Email";
                    }
                    return null;
                  },
                  key: const ValueKey("fullName"),
                  controller: fullName,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kGreyColor,
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SelectGender(
                  selectGender: changeGender,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Not Valid Email";
                    }
                    return null;
                  },
                  key: const ValueKey("birthDate"),
                  controller: birthDate,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kGreyColor,
                    hintText: "Birth Date",
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
                  key: const ValueKey("description"),
                  controller: description,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Not Valid Email";
                    }
                    return null;
                  },
                  maxLines: 5,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: kGreyColor,
                    hintText: "Description",
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
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SetPasswordPage(userData: {
                              "email": emailController.text.trim(),
                              "fullName": fullName.text,
                              "gender": isMale ? "male" : "female",
                              "birthDate": birthDate.text,
                              "description": description.text
                            }),
                          ));
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
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, LoginPage.routeName),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Have a account?",
                          style: TextStyle(fontSize: 18, color: kWhite),
                        ),
                        Text(
                          "Log in",
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
