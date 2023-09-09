import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  IO.Socket? socket;
  RTCPeerConnection? peerConnection;
  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      }
    ]
  };
  @override
  void initState() {
    connection();
    super.initState();
  }

  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text(text)),
    );
  }

  void connection() {
    socket = IO.io("http://192.168.1.103:2000", <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    socket!.onConnect((data) => print("Connected"));
    print(socket?.id ?? "");
    createOffer();
  }

  void createOffer() async {
    peerConnection = await createPeerConnection(configuration);
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);
    print('Created offer: ${offer.sdp}');
    socket?.emit("send-direct", {
      "recivier": "",
      "event": "send_offer",
      "body": {"offer": offer.sdp, "caller": socket!.id}
    });

    createAnswer(offer);
  }

  void createAnswer(RTCSessionDescription offer) async {
    await peerConnection?.setRemoteDescription(offer);
    RTCSessionDescription answer = await peerConnection!.createAnswer();
    await peerConnection?.setLocalDescription(answer);
    socket?.emit("send-direct",
        {"recivier": "", "event": "send_answer", "body": answer.sdp});
  }
}
