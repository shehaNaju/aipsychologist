import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const appId = "86b3da6d6f8d4e34a0c82cccd871f0b3";
const token = "007eJxTYPgVf/1XW3qBwf9PFje4E7pKlIpuZm3i5pXVSY6Wyt90/KkCg4VZknFKolmKWZpFikmqsUmiQbKFUXJycoqFuWGaQZLxwrrdqQ2BjAzxGgUMjFAI4rMwJCYlpzAwAACAOR+t";
const channel = "abcd";

void main() => runApp(const MaterialApp(home: Vedocall()));

class Vedocall extends StatefulWidget {
  const Vedocall({Key? key}) : super(key: key);

  @override
  State<Vedocall> createState() => _VedocallState();
}

class _VedocallState extends State<Vedocall> {
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    //create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint(
              '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

    await _engine.joinChannel(
      token: token,
      channelId: channel,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  // Create UI with local view and remote view
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          Center(
            child: _remoteVideo(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: _engine,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}



// import 'package:flutter/material.dart';
// import 'package:agora_rtc_engine/agora_rtc_engine.dart';
//
// const APP_ID = "0aa4761e4d4446769a39ec294790420d";
//
// void main() {
//   runApp(Vedocall());
// }
//
// class Vedocall extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: VideoCallScreen(),
//     );
//   }
// }
//
// class VideoCallScreen extends StatefulWidget {
//   @override
//   _VideoCallScreenState createState() => _VideoCallScreenState();
// }
//
// class _VideoCallScreenState extends State<VideoCallScreen> {
//   final _channelController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize Agora SDK
//     AgoraRtcEngine.create(APP_ID);
//     AgoraRtcEngine.enableVideo();
//   }
//
//   @override
//   void dispose() {
//     // Leave the channel and dispose of the Agora SDK when not in use
//     AgoraRtcEngine.leaveChannel();
//     AgoraRtcEngine.destroy();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Agora Video Call'),
//       ),
//       body: Center(
//         child: Column(
//           children: <Widget>[
//             TextField(
//               controller: _channelController,
//               decoration: InputDecoration(labelText: 'abcd'),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 _joinChannel();
//               },
//               child: Text('Join Channel'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _joinChannel() {
//     AgoraRtcEngine.joinChannel(null, _channelController.text, null, 0);
//   }
// }