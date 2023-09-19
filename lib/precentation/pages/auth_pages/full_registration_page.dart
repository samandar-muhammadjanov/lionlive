// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:quagga/precentation/pages/dashboard.dart';
import 'package:quagga/precentation/widgets/w_elevtaed_button.dart';
import 'package:quagga/precentation/widgets/w_textfield.dart';
import 'package:quagga/utils/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FullRegistrationPage extends StatefulWidget {
  const FullRegistrationPage({super.key});
  static const routeName = "/fullRegistration";

  @override
  State<FullRegistrationPage> createState() => _FullRegistrationPageState();
}

class _FullRegistrationPageState extends State<FullRegistrationPage> {
  File? image;
  final auth = FirebaseAuth.instance;
  ImagePicker? imagePicker;
  void pickImage() async {
    try {
      final pickedImage = await ImagePicker().pickImage(
          source: ImageSource.gallery, imageQuality: 50, maxWidth: 150);
      if (pickedImage != null) {
        image = File(pickedImage.path);
      }
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  bool isMale = true;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    bool isVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              isVisible
                  ? SizedBox()
                  : InkWell(
                      onTap: pickImage,
                      child: Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kGreyColor,
                          shape: BoxShape.circle,
                        ),
                        child: image != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  image!,
                                  fit: BoxFit.cover,
                                  width: 150,
                                  height: 150,
                                ),
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.photo_camera_outlined),
                                  Text("Select Image")
                                ],
                              ),
                      ),
                    ),
              const SizedBox(
                height: 30,
              ),
              WTextField(
                title: "Full Name",
                controller: fullNameController,
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select gender",
                    style: TextStyle(color: kGreyColor, fontFamily: "sfPro"),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isMale = true;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: isMale
                                      ? kLightBlueColor
                                      : kWhite.withOpacity(0.5),
                                  width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Male",
                              style: TextStyle(
                                  color: kWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isMale = false;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: !isMale
                                      ? Colors.red
                                      : kWhite.withOpacity(0.5),
                                  width: 2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "Female",
                              style: TextStyle(
                                  color: kWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              WTextField(
                title: "Birth Data",
                controller: birthDateController,
                suffix: IconButton(
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    primaryColor:
                                        kPrimaryColor, // Change the primary color
                                  ),
                                  child: child!,
                                );
                              },
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1970),
                              lastDate: DateTime.now())
                          .then((value) {
                        if (value == null) return;
                        setState(() {
                          birthDateController.text =
                              DateFormat("dd-MM-yyyy").format(value);
                        });
                      });
                    },
                    icon: const Icon(Icons.date_range_outlined)),
              ),
              const SizedBox(
                height: 10,
              ),
              WTextField(
                title: "Description",
                maxLines: 3,
                controller: descriptionController,
              ),
              const Spacer(),
              WElevetedButton(
                  onPressed: () async {
                    try {
                      final storage = FirebaseStorage.instance
                          .ref()
                          .child("user_images")
                          .child("${auth.currentUser!.uid}.jpg");

                      await storage.putFile(image!);
                      final imageUrl = await storage.getDownloadURL();
                      FirebaseFirestore.instance
                          .collection("Users")
                          .doc(auth.currentUser!.uid)
                          .set({
                        "fullName": fullNameController.text,
                        "gender": isMale ? "male" : "female",
                        "birthDate": birthDateController.text,
                        "description": descriptionController.text,
                        "image": imageUrl
                      });
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Dashboard(),
                          ),
                          (route) => false);
                    } on FirebaseException catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message!)));
                    }
                  },
                  title: "Continue")
            ],
          ),
        ),
      ),
    );
  }
}
