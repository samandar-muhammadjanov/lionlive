// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:quagga/precentation/pages/chat_page.dart';
import 'package:quagga/precentation/pages/home_page.dart';
import 'package:quagga/precentation/pages/profile_page.dart';
import 'package:quagga/precentation/widgets/drawer.dart';
import 'package:quagga/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List pages = [const HomePage(), const ChatPage(), const ProfilePage()];
  @override
  Widget build(BuildContext cFontext) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: kPrimaryColor,
      body: pages[currentIndex],
      appBar: AppBar(
        elevation: 0.3,
        shadowColor: kGreyColor,
        backgroundColor: kPrimaryColor,
        foregroundColor: kWhite,
        centerTitle: true,
        title: Image.asset(
          "assets/svg/lion.png",
          width: 40,
        ),
        leading: IconButton(
            onPressed: () {
              if (scaffoldKey.currentState!.isDrawerOpen) {
                Navigator.pop(context);
              } else {
                scaffoldKey.currentState!.openDrawer();
              }
            },
            icon: SvgPicture.asset(
              "assets/svg/filter.svg",
              width: 30,
              color: kWhite,
            )),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/svg/crown.svg",
              color: kWhite,
              width: 60,
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          currentIndex: currentIndex,
          backgroundColor: kSecendPrimaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/home.svg",
                  width: 40,
                  color: currentIndex == 0 ? kOrangeColor : kGreyColor,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/Chat.svg",
                  width: 30,
                  color: currentIndex == 1 ? kOrangeColor : kGreyColor,
                ),
                label: "Chat"),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  "assets/svg/profile.svg",
                  width: 25,
                  color: currentIndex == 2 ? kOrangeColor : kGreyColor,
                ),
                label: "Profile"),
          ],
        ),
      ),
    );
  }
}
