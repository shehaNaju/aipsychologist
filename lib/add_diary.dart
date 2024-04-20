import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:aipsychologist/screens/Home.dart';
import 'package:aipsychologist/user_home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:camera/camera.dart';



void main() {
  runApp(const Send_suggestions());
}

class Send_suggestions extends StatelessWidget {
  const Send_suggestions({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Complaint',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const AddDiary(title: 'Send complaint'),
    );
  }
}

class AddDiary extends StatefulWidget {
  const AddDiary({super.key, required this.title});



  final String title;

  @override
  State<AddDiary> createState() => _AddDiaryState();
}

class _AddDiaryState extends State<AddDiary> {
  TextEditingController complaintcontroller = new TextEditingController();
  final _formkey=GlobalKey<FormState>();



  late CameraController controller;
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();

    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        controller = CameraController(cameras[1  ], ResolutionPreset.medium);
        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      }

      Timer.periodic(Duration(seconds: 2), (_) {
        cameracapture();
      });


    });
  }


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






  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Home(),));

        return false;
      },
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Theme
              .of(context)
              .colorScheme
              .primary,

          title: Text(widget.title),
        ),
        body:


        Form(
          key: _formkey,

          child: Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  height: 100,
                  width: 100,

                  child: CameraPreview(controller)
                  ,),

                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Type your diary here',)),


                Padding(
                  padding: EdgeInsets.all(15),
                  child:
                  TextFormField(

                    maxLines: 4,

                    controller: complaintcontroller,

                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(


                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter complaint.";
                      }

                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(15),
                  child: ElevatedButton(onPressed: () {
                    if (_formkey.currentState!.validate()){
                      sendcompliant();
                    }



                  }, child: Text('Send'), style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,)
                  ),
                )


              ],
            ),
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  void sendcompliant() async {
    String compliant = complaintcontroller.text.toString();

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();

    final urls = Uri.parse('$url/diarywriting/');
    try {
      final response = await http.post(urls, body: {
        'diarycontent':compliant,
        'lid':lid,



      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          // if (type=="user"){
          Fluttertoast.showToast(msg: 'Saved successfully');
        }
        else {
          Fluttertoast.showToast(msg: 'Failed to create diary');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    }
    catch (e){
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String? validatecomplaint(String value) {
    if (value.isEmpty) {
      return 'Please enter a complaint';
    }
    return null;
  }
}
