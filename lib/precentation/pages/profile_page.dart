import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:quagga/functions/show_advertising.dart';
import 'package:quagga/precentation/pages/auth_pages/login_page.dart';
import 'package:quagga/precentation/pages/profile_settings_page.dart';
import 'package:quagga/utils/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          ProfileHeader(),
          const SizedBox(
            height: 20,
          ),
          const ProfileBody(),
          const Spacer(),
        ],
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              Navigator.pushNamed(context, ProfileSettingsPage.routeName);
            },
            tileColor: kSecendPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            minLeadingWidth: 0,
            title: Text(
              "Profile Settings",
              style: TextStyle(
                color: kWhite,
                fontSize: 26,
              ),
            ),
            leading: Icon(
              Icons.account_circle_outlined,
              color: kWhite,
              size: 40,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              showAd(context);
            },
            tileColor: kSecendPrimaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            minLeadingWidth: 0,
            title: Text(
              "Get Vip",
              style: TextStyle(
                color: kWhite,
                fontSize: 26,
              ),
            ),
            leading: Icon(
              Icons.verified,
              color: kWhite,
              size: 40,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginPage.routeName, (route) => false);
            },
            tileColor: Colors.red.withOpacity(0.4),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            minLeadingWidth: 0,
            title: Text(
              "Log Out",
              style: TextStyle(
                color: Colors.red[400],
                fontSize: 26,
              ),
            ),
            leading: Icon(
              Icons.logout_rounded,
              color: Colors.red[400],
              size: 40,
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  ProfileHeader({
    super.key,
  });

  final user = FirebaseAuth.instance.currentUser!;
  final store = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;
  @override
  Widget build(BuildContext context) {
    // if (user.providerData[0].providerId == "google.com") {
    //   return Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Container(
    //         decoration: BoxDecoration(
    //             border: Border.all(color: kWhite, width: 2),
    //             shape: BoxShape.circle),
    //         child: CircleAvatar(
    //           radius: 70,
    //           backgroundImage: NetworkImage(user.photoURL!),
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 16,
    //       ),
    //       Text(
    //         user.displayName!,
    //         style: TextStyle(
    //           fontSize: 22,
    //           color: kGreyColor,
    //         ),
    //       ),
    //     ],
    //   );
    // }
    return FutureBuilder(
      future: store.collection("Users").doc(user.uid).get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          final image = snapshot.data!.get("image");
          final fullName = snapshot.data!.get("fullName");
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: kWhite, width: 2),
                    shape: BoxShape.circle),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(image),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                fullName,
                style: TextStyle(
                  fontSize: 22,
                  color: kGreyColor,
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(snapshot.error.toString())));
          return Text(snapshot.error.toString());
        }
        return CircularProgressIndicator();
      },
    );
  }
}
