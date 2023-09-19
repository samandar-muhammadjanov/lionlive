import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

typedef void StreamStateCallback(MediaStream stream);

class VideoHelper {
  StreamStateCallback? onAddRemoteStream;
  handleCaller(
    dynamic data,
    IO.Socket socket,
    RTCPeerConnection peerConnection,
    MediaStream? remoteStream,
    MediaStream? localStream,
  ) async {
    peerConnection.onIceCandidate = (RTCIceCandidate candidate) {
      socket.emit("send-direct", {
        "receiver": data["socketID"],
        "event": "send-ice",
        "body": candidate.toMap(),
      });
    };

    RTCSessionDescription offer = await peerConnection.createOffer();
    await peerConnection.setLocalDescription(offer);

    socket.emit("send-direct", {
      "receiver": data["socketID"],
      "event": "send-offer",
      "body": {
        "offer": offer.toMap(),
        "caller": socket.id,
      },
    });
  }

  void handleCallee(dynamic data) {}

  Future<void> handleSendOffer(
    dynamic data,
    IO.Socket socket,
    RTCPeerConnection peerConnection,
    MediaStream? remoteStream,
    MediaStream? localStream,
  ) async {
    final RTCSessionDescription offer =
        RTCSessionDescription(data['offer']["sdp"], data["offer"]["type"]);
    await peerConnection.setRemoteDescription(offer);

    RTCSessionDescription answer = await peerConnection.createAnswer();
    await peerConnection.setLocalDescription(answer);

    socket.emit("send-direct", {
      "receiver": data["caller"],
      "event": "send-answer",
      "body": answer.toMap(),
    });
  }

  Future<void> handleSendAnswer(
    dynamic data,
    RTCPeerConnection peerConnection,
    MediaStream? remoteStream,
    MediaStream? localStream,
  ) async {
    print("=======");

    print(data);
    print("=======");
    // final RTCSessionDescription answer =
    //     RTCSessionDescription(data["sdp"], "answer");
    if (peerConnection.getRemoteDescription() != null && data != null) {
      var answer = RTCSessionDescription(
        data['sdp'],
        "answer",
      );
      registerPeerConnectionListeners(peerConnection, remoteStream);
      print("Someone tried to connect");
      await peerConnection.setRemoteDescription(answer);
    }
    // await peerConnection.setRemoteDescription(answer);
  }

  Future<void> handleICE(dynamic data, RTCPeerConnection peerConnection) async {
    final RTCIceCandidate candidate = RTCIceCandidate(
      data['candidate'],
      data['sdpMid'],
      data['sdpMLineIndex'],
    );
    await peerConnection.addCandidate(candidate);
  }

  void registerPeerConnectionListeners(
    RTCPeerConnection peerConnection,
    MediaStream? remoteStream,
  ) {
    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE gathering state changed: $state');
    };

    peerConnection.onConnectionState = (RTCPeerConnectionState state) {
      print('Connection state change: $state');
    };

    peerConnection.onSignalingState = (RTCSignalingState state) {
      print('Signaling state change: $state');
    };

    peerConnection.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE connection state change: $state');
    };

    peerConnection.onAddStream = (MediaStream stream) {
      print("Add remote stream");
      onAddRemoteStream?.call(stream);
      remoteStream = stream;
    };
  }
}
