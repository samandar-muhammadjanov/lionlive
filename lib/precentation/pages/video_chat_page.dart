import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:quagga/functions/signaling.dart';
import 'package:quagga/utils/colors.dart';
import 'package:flutter_gif/flutter_gif.dart';

class VideoChat extends StatefulWidget {
  const VideoChat({super.key});

  @override
  State<VideoChat> createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  Signaling signaling = Signaling();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;

  @override
  void initState() {
    super.initState();
    initRenders();
    createRoom();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  void initRenders() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    });
    signaling.openUserMedia(_localRenderer, _remoteRenderer);
  }

  List<String> rooms = [];
  FlutterGifController? controller;
  void createRoom() async {
    roomId = await signaling.createRoom(_remoteRenderer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                    height: 300,
                    child: Stack(
                      children: [
                        RTCVideoView(
                          _localRenderer,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                          mirror: true,
                        ),
                        Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: kLightBlueColor,
                                borderRadius: BorderRadius.circular(3)),
                            child: Text(
                              "Samandar Mahamadjonov 18 y.o",
                              style: TextStyle(
                                color: kWhite,
                                fontWeight: FontWeight.w700,
                              ),
                            ))
                      ],
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                    height: 300,
                    child: RTCVideoView(
                      _remoteRenderer,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    )),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      final db = await FirebaseFirestore.instance
                          .collection("rooms")
                          .get();

                      for (var i = 0; i < db.docs.length; i++) {
                        setState(() {
                          rooms.addAll({db.docs[i].id});
                        });
                        Random random = Random();
                        int randomIndex = random.nextInt(rooms.length);
                        print(rooms[randomIndex]);
                      }
                    },
                    child: Icon(Icons.camera),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      signaling.hangUp(_localRenderer);
                    },
                    backgroundColor: Colors.red,
                    child: Icon(Icons.phone_disabled_rounded),
                  ),
                  FloatingActionButton(
                    onPressed: () {},
                    child: Icon(Icons.keyboard_double_arrow_right_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
