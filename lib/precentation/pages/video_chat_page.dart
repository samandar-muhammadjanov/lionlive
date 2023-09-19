import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:quagga/functions/video_helpers.dart';
import 'package:quagga/utils/colors.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class VideoChat extends StatefulWidget {
  const VideoChat({super.key});

  @override
  State<VideoChat> createState() => _VideoChatState();
}

class _VideoChatState extends State<VideoChat> {
  MediaStream? localStream;
  MediaStream? remoteStream;
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  RTCPeerConnection? peerConnection;
  IO.Socket? socket;
  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun.l.google.com:19302',
          'stun:stun1.l.google.com:19302'
        ]
      }
    ]
  };
  @override
  void initState() {
    initRenders();
    connect();
    _createPeerConnection();
    super.initState();
  }

  _getUserMedia() async {
    var stream = await navigator.mediaDevices
        .getUserMedia({'video': true, 'audio': true});

    _localRenderer.srcObject = stream;

    _remoteRenderer.srcObject = await createLocalMediaStream('key');
    // _localRenderer.mirror = true;

    return stream;
  }

  void connect() async {
    socket = IO.io("https://server-j5u3e3fkia-uc.a.run.app/", <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    socket!.onConnect((data) {
      print("Connect");
      socket!.emit("request-init", {
        "requestor": {
          "DOB": DateTime(2000, 1, 1).toIso8601String(),
          "gender": "guy",
          "regionName": "Tashkent",
          "name": "Samandar",
          "description": "hi"
        },
        "filters": {}
      });

      socket!.on(
        "caller",
        (data) => VideoHelper().handleCaller(
            data, socket!, peerConnection!, localStream, remoteStream),
      );

      socket!.on(
        "send-offer",
        (data) => VideoHelper().handleSendOffer(
            data, socket!, peerConnection!, localStream, remoteStream),
      );

      socket!.on(
          "send-answer",
          (data) => VideoHelper().handleSendAnswer(
              data, peerConnection!, localStream, _remoteRenderer.srcObject));

      socket!.on(
        "send-ice",
        (data) => VideoHelper().handleICE(data, peerConnection!),
      );
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
  }

  _createPeerConnection() async {
    peerConnection = await createPeerConnection(configuration);
    localStream = await _getUserMedia();
    // localStream!.getTracks().forEach((track) {
    //   peerConnection!.addTrack(track, localStream!);
    // });
    // peerConnection!.onTrack = (event) {
    //   MediaStream? newMediaStream;
    //   event.streams[0].getTracks().forEach((track) {
    //     newMediaStream!.addTrack(track);
    //     print("track");
    //     print(newMediaStream);
    //     print("track");

    //     // setState(() {
    //     //   localStream = newMediaStream;
    //     // });
    //   });
    // };
    // peerConnection!.addStream(localStream!);
    peerConnection!.onAddStream = (stream) {
      print('addStream: ' + stream.id);
      _remoteRenderer.srcObject = stream;
    };
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
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                    height: 300,
                    child: RTCVideoView(
                      _localRenderer,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      mirror: true,
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
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
