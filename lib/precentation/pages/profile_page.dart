import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quagga/utils/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          ProfileHeader(),
          SizedBox(
            height: 20,
          ),
          ProfileBody(),
          Spacer(),
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
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: kWhite, width: 2),
              shape: BoxShape.circle),
          child: const CircleAvatar(
            radius: 70,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Chris Kay",
          style: TextStyle(
            fontSize: 22,
            color: kGreyColor,
          ),
        ),
      ],
    );
  }
}
