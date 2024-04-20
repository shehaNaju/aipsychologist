import 'dart:convert';
import 'dart:math';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ViewMyQuestion(title: "",),
    );
  }
}

class ViewMyQuestion extends StatefulWidget {
  const ViewMyQuestion({super.key, required this.title});


  final String title;

  @override
  State<ViewMyQuestion> createState() => _ViewMyQuestionState();

}

class _ViewMyQuestionState extends State<ViewMyQuestion> {



  ////

  late CameraController controller;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();

    getData();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        controller = CameraController(cameras[0], ResolutionPreset.medium);
        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }
    });
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }


  ///////





  String currentQuestion = "";
  int questionIndex = 1;



  TextEditingController ansctrl= new TextEditingController();


  int pindex=0;
  String pquestion="";
  String panswer="";


  _ViewMyQuestionState() {
getData();
  }
  int pindexa=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Page Design'),
      ),
      body:

      Padding(
        padding: const EdgeInsets.all(16.0),
        child:







        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 100,
              width: 100,

              child: CameraPreview(controller)
              ,)
           ,





            ElevatedButton(
              onPressed: () async {
                cameracapture();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }

  List id_ =[], questions_ = [], answers_ = [];

  void cameracapture()async {

    if (controller.value.isInitialized) {
      XFile file = await controller.takePicture();
      // Implement logic to send the file to the server
      // using multipart request (see step 4).

      File _selectedImage = File(file.path);
      String _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
      String photo = _encodedImage.toString();


      String image="";

      try {
        SharedPreferences sh = await SharedPreferences.getInstance();
        String urls = sh.getString('url').toString();
        String iurl = sh.getString('img_url').toString();
        String sid = sh.getString('sid').toString();
        String lid = sh.getString('lid').toString();
        String url = '$urls/emotion_recognition/';

        final response = await http.post(Uri.parse(url), body: {

          'sid':sid,
          'lid':lid,
          'image':photo,

        });
        if(response.statusCode == 200){
          print(response.body);
          String status = jsonDecode(response.body)['status'];
          if(status == 'ok') {}
        }
      }catch(e){
        Fluttertoast.showToast(msg: e.toString());
      }

    }


  }




  void getData()async {
    //no underscores here
    List id =[], Question = [], Answer = [];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String iurl = sh.getString('img_url').toString();
      String sid = sh.getString('sid').toString();
      String url = '$urls/user_view_question/';

      final response = await http.post(Uri.parse(url), body: {

        'sid':sid
      });
      if(response.statusCode == 200){
        print(response.body);
        String status = jsonDecode(response.body)['status'];
        if(status == 'ok'){
          var data = jsonDecode(response.body)['data'];

          print(data);

          for(int i=0; i<data.length; i++){

            id.add(data[i]['id']);
            Question.add(data[i]['Questions']);
            Answer.add(data[i]['Answer']);

          }


          if(id.length>pindex) {












            setState(() {
              pquestion=Question[pindex];
              panswer=Answer[pindex];

              pindex=pindex;


              id_ = id;
              questions_ = Question;
              answers_ = Answer;
            });
          }
        }else{
          Fluttertoast.showToast(msg: "Not found");
        }
      }
    }catch(e){
      Fluttertoast.showToast(msg: e.toString());
    }


  }


}
