import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:quagga/functions/signaling.dart';
import 'package:quagga/utils/colors.dart';

class VideoChat extends StatefulWidget {
  const VideoChat({super.key});

  @override
  State<VideoChat> createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  Signaling signaling = Signaling();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      initRenders();
      createRoom();
    });
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
    });
    signaling.openUserMedia(_localRenderer, _remoteRenderer);
    setState(() {});
  }

  List<String> rooms = [];
  void createRoom() async {
    roomId = await signaling.createRoom(_remoteRenderer);
    print("=========");
    print(roomId);
    print("=========");

    setState(() {});
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
              TextField(
                controller: controller,
              ),
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
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(5),
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
              const SizedBox(
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
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      signaling.openUserMedia(_localRenderer, _remoteRenderer);
                    },
                    child: const Icon(Icons.camera),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      signaling.hangUp(_localRenderer);
                    },
                    backgroundColor: Colors.red,
                    child: const Icon(Icons.phone_disabled_rounded),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      signaling.joinRoom(
                          "GzYh07hJy1hkvoPy66XA", _remoteRenderer);
                      setState(() {});
                    },
                    child:
                        const Icon(Icons.keyboard_double_arrow_right_rounded),
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
