import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quagga/functions/showAd.dart';
import 'package:quagga/precentation/pages/test.dart';
import 'package:quagga/precentation/pages/video_chat_page.dart';
import 'package:quagga/utils/colors.dart';
import 'package:quagga/utils/extantion.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  bool isStarted = false;
  // IO.Socket? socket;

  void startChatting() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TestPage(),
        ));
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 2),
      () {
        showAd(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List sexuality = ["All", "Guys", "Girls"];

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Select Sexuality:",
            style: TextStyle(fontSize: 18, color: kGreyColor),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(sexuality.length, (index) {
                return InkWell(
                  onTap: () {},
                  child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(8),
                    color: kLightBlueColor,
                    child: Container(
                      decoration: BoxDecoration(
                          color: currentIndex == index
                              ? kLightBlueColor.withOpacity(0.2)
                              : Colors.transparent),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      child: Text(
                        sexuality[index],
                        style: TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Column(
            children: [
              SvgPicture.asset(
                "assets/svg/video.svg",
                width: MediaQuery.of(context).size.width,
              ),
              Text(
                "${0.formatWithSpaces()} Online Using Quagga now!",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "sfPro",
                    fontSize: 22,
                    color: kGreyColor,
                    fontWeight: FontWeight.w700),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: ElevatedButton.icon(
                  onPressed: () async {
                    startChatting();
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
                  icon: const Icon(
                    Icons.videocam_outlined,
                    size: 50,
                  ),
                  label: const Text(
                    "Start getting matches!",
                    style: TextStyle(
                        fontFamily: 'sfPro',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
