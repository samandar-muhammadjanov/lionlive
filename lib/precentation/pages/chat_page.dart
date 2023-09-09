import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quagga/precentation/pages/chat_inside_page.dart';
import 'package:quagga/utils/colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            style: TextStyle(color: kWhite, fontSize: 18),
            decoration: InputDecoration(
              filled: true,
              prefixIcon: Icon(
                Icons.search,
                color: kGreyColor,
              ),
              hintText: "Search",
              hintStyle: TextStyle(
                color: kGreyColor,
                fontSize: 18,
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: kWhite, width: 2),
                  borderRadius: BorderRadius.circular(16)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: kWhite, width: 2),
                  borderRadius: BorderRadius.circular(16)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Users").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final docs = snapshot.data!.docs;
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = docs[index];
                      return ListTile(
                        onTap: () => Navigator.pushNamed(
                            context, ChatInsidePage.routeName),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        tileColor: kLightBlueColor,
                        trailing: const CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.red,
                          child: Text(
                            "2",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                        title: Text(
                          item.id,
                          style: TextStyle(color: kWhite),
                        ),
                        subtitle: Text(
                          "Heyy whats up",
                          style: TextStyle(color: kGreyColor),
                        ),
                        leading: const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                    itemCount: docs.length);
              })
        ],
      ),
    );
  }
}
