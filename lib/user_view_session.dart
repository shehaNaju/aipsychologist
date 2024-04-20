import 'dart:convert';

// import 'package:clinicpharma/viewmedicine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const ViewSession(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewSession extends StatefulWidget {
  const ViewSession({super.key, required this.title});


  final String title;

  @override
  State<ViewSession> createState() => _ViewSessionState();
}

class _ViewSessionState extends State<ViewSession> {

  _ViewSessionState() {
    view_notification();
  }


  String vedio_="";




  Future<void> view_notification() async {

      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('f').toString();

      setState(() {


        vedio_= urls;


      });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        appBar: AppBar(
          actions: [IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (context) => MyHomePage(title: ""),));
            },
          ),],
          backgroundColor: Color.fromARGB(255, 18, 82, 98),
          foregroundColor: Colors.white,


          title: Text(widget.title),
        ),
        body:



        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/'), fit: BoxFit.cover),
          ),
          child: VideoPlayerWidget(videoUrl: widget.title,)



        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  bool isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void toggleVideoPlayback() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        isVideoPlaying = false;
      } else {
        _controller.play();
        isVideoPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleVideoPlayback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          if (!isVideoPlaying)
            Icon(
              Icons.play_arrow,
              size: 64,
              color: Colors.white,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}