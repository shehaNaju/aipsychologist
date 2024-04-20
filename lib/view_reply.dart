import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aipsychologist/screens/Home.dart';
import 'package:aipsychologist/sent_complaint.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:aipsychologist/user_home.dart';
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
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const View_reply(title: 'View Reply'),
    );
  }
}

class View_reply extends StatefulWidget {
  const View_reply({super.key, required this.title});


  final String title;

  @override
  State<View_reply> createState() => _View_replyState();
}

class _View_replyState extends State<View_reply> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewdata();
  }

String premium_type='no';






  List<String> id_  =<String>[];
  List<String> complaint_=<String>[];
  List<String> status_ = <String>[];
  List<String> datet_= <String>[];
  List<String> reply_ =<String>[];











  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context) =>Home (),));

        return false;

      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.teal,

          title: Text("View Complaint"),
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,

          onPressed: () {

          Navigator.push(context, MaterialPageRoute(builder: (context) => MyComplaintHome(title: 'New Complaint',),));


        },),
        body: ListView.builder(
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(8),
              height: 280,
              child:
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 8,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(datet_[index]),
                          Text(status_[index]),
                        ],
                      ),

                      SizedBox(height: 8,),

                      Text(
                        "Complaint",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8,),

                      Text(
                        complaint_[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),

                      SizedBox(height: 8),
                      Text(
                        "Reply:",
                        style: TextStyle(fontSize: 16),
                      ), SizedBox(height: 8),
                      Text(
                        reply_[index],
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )

            );
          },
        )


        
        
     
      ),
    );
  }



  void viewdata() async {


    List<String> id  =<String>[];
    List<String> complaint=<String>[];
    List<String> status = <String>[];
    List<String> datet= <String>[];
    List<String> reply =<String>[];




   





    SharedPreferences sh=await SharedPreferences.getInstance();


    try {
      String urls = sh.getString('url').toString();
      String url = '$urls/userviewreplay/';

      String imgurl = sh.getString("imgurl").toString();
      String lid = sh.getString("lid").toString();
      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        datet.add(arr[i]['date'].toString());
        reply.add(arr[i]['replay'].toString());
        complaint.add(arr[i]['complaint'].toString());
        status.add(arr[i]['status'].toString());

      }

      setState(() {

        id_ = id;
        datet_ = datet;
        reply_ = reply;
        complaint_ = complaint;
        status_ = status;

      });

    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }



  }



}















