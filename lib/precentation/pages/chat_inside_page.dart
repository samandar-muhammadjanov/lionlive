// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quagga/precentation/widgets/message_bubble.dart';
import 'package:quagga/utils/colors.dart';

class ChatInsidePage extends StatefulWidget {
  ChatInsidePage({super.key});
  static const routeName = "/chat";

  @override
  State<ChatInsidePage> createState() => _ChatInsidePageState();
}

class _ChatInsidePageState extends State<ChatInsidePage> {
  final TextEditingController chatController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("chats")
                  .orderBy("createdAt", descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final item = docs[index];
                    return MessageBubble(
                        key: ValueKey(item.id),
                        isMe: item["senderId"] == user!.uid,
                        message: item["messageText"]);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: TextField(
                controller: chatController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kGreyColor,
                  hintText: "Send Message",
                  suffixIcon: IconButton(
                    onPressed: _sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    FocusScope.of(context).unfocus();
    if (chatController.text != null || chatController.text.trim().isNotEmpty) {
      FirebaseFirestore.instance.collection("chats").add(
        {
          "messageText": chatController.text,
          "createdAt": Timestamp.now(),
          "senderId": user!.uid
        },
      );
      chatController.clear();
    }
  }
}
