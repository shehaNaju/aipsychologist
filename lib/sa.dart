import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http_parser/http_parser.dart';

import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;
  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatelessWidget {
  final CameraDescription camera;

  const MyApp({Key? key, required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera Byte Array',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraScreen(camera: camera),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final CameraDescription camera;

  const CameraScreen({Key? key, required this.camera}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void startTimer() {
    Timer(Duration(seconds: 5), () {
      captureImage();
    });
  }

  void captureImage() async {
    try {
      await _initializeControllerFuture;

      XFile? imageFile = await _controller.takePicture();

      if (imageFile != null) {
        // Retrieve the captured image as a byte array
        Uint8List bytes = await getImageBytes(imageFile);


        ///////////////sending as multpart
        final url = Uri.parse('YOUR_ENDPOINT_URL_HERE'); // Replace with your API endpoint

        var request = http.MultipartRequest('POST', url);
        request.files.add(
          http.MultipartFile.fromBytes(
            'file',
            bytes,
            filename: 'file.jpg', // Set your desired filename
            contentType: MediaType('application', 'octet-stream'), // Set the content type
          ),
        );

        try {
          final streamedResponse = await request.send();
          final response = await http.Response.fromStream(streamedResponse);

          if (response.statusCode == 200) {
            print('Multipart request successful');
            // Handle success response here
          } else {
            print('Multipart request failed with status ${response.statusCode}');
            // Handle error response here
          }
        } catch (e) {
          print('Error sending multipart request: $e');
          // Handle exceptions here
        }



        //////////////end sending as multipart

        // Use the bytes as needed (e.g., send them over a network, process them, etc.)
        print('Captured image as byte array: $bytes');
      }
    } catch (e) {
      print('Error capturing image: $e');
    }
  }

  Future<Uint8List> getImageBytes(XFile imageFile) async {
    final filePath = imageFile.path;
    final bytes = File(filePath).readAsBytesSync();
    return bytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Byte Array'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startTimer();
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
