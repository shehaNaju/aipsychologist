import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aipsychologist/screens/Home.dart';
import 'package:aipsychologist/sent_complaint.dart';
import 'package:aipsychologist/user_view_session.dart';

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
      home: const View_motivational_vedios(title: 'View Reply'),
    );
  }
}

class View_motivational_vedios extends StatefulWidget {
  const View_motivational_vedios({super.key, required this.title});


  final String title;

  @override
  State<View_motivational_vedios> createState() => _View_motivational_vediosState();
}

class _View_motivational_vediosState extends State<View_motivational_vedios> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewdata();
  }

String premium_type='no';






  List<String> id_  =<String>[];
  List<String> Vediotitle_=<String>[];
  List<String> Date_ = <String>[];
  List<String> Filename_= <String>[];












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

          title: Text("View Videos"),
        ),


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
                          Text(Date_[index]),

                        ],
                      ),

                      SizedBox(height: 8,),

                      Text(
                        "Title",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8,),

                      Text(
                        Vediotitle_[index],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),



                      ElevatedButton(onPressed: () async {

                        SharedPreferences sh=await SharedPreferences.getInstance();

                        //stable ip address settings first

                        String s=sh.getString('imgurl').toString() + Filename_[index];
                        sh.setString("f", s);

                        Navigator.push(context, MaterialPageRoute(builder: (context) => ViewSession(title: s,)));




                      }, child: Text('Play'))

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
    List<String> Vediotitle=<String>[];
    List<String> Date = <String>[];
    List<String> Filename= <String>[];

    SharedPreferences sh=await SharedPreferences.getInstance();


    try {
      String urls = sh.getString('url').toString();
      String url = '$urls/user_view_vedios/';

      String imgurl = sh.getString("imgurl").toString();
      String lid = sh.getString("lid").toString();
      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);

      var arr = jsondata["data"];
      List<String> id  =<String>[];
      List<String> Vediotitle=<String>[];
      List<String> Date = <String>[];
      List<String> Filename= <String>[];
      for (int i = 0; i < arr.length; i++) {




        id.add(arr[i]['id'].toString());
        Vediotitle.add(arr[i]['Vediotitle'].toString());
        Date.add(arr[i]['Date'].toString());
        Filename.add(arr[i]['Filename'].toString());
      }

      setState(() {
        id_ = id;
        Vediotitle_ = Vediotitle;
        Date_ = Date;
        Filename_ = Filename;
      });

    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }



  }



}















