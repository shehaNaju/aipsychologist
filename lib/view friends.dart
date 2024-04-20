
// import 'package:clinicpharma/signUpmain.dart';
// import 'package:clinicpharma/signup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aipsychologist/Videocall.dart';

// import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'package:http/http.dart' as http;

// import 'package:shared_preferences/shared_preferences.dart';

// import 'home_drawer.dart';

void main() {
  runApp(const MyIp());
}

class MyIp extends StatelessWidget {
  const MyIp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const  Viewfriends(title: 'Login'),
    );
  }
}

class  Viewfriends extends StatefulWidget {
  const  Viewfriends({super.key, required this.title});

  final String title;

  @override
  State< Viewfriends> createState() => _MyviewzumbatrainerState();
}

class _MyviewzumbatrainerState extends State< Viewfriends> {


  _MyviewzumbatrainerState()
  {
    viewdata();
  }

  TextEditingController ipController = new TextEditingController();

  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> place_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> email_ = <String>[];


  void viewdata() async {

    List<String> id = <String>[];
    List<String> name= <String>[];
    List<String> photo = <String>[];
    List<String> place = <String>[];
    List<String> email = <String>[];

    SharedPreferences sh = await SharedPreferences.getInstance();
    try {
      String urls = sh.getString('url').toString();
      String url = '$urls/user_view_friends/';

      String imgurl = sh.getString("imgurl").toString();
      String lid = sh.getString("lid").toString();
      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        name.add(arr[i]['name'].toString());

        place.add(arr[i]['place'].toString());

        photo.add(imgurl+arr[i]['photo'].toString());

        email.add(arr[i]['email'].toString());

      }

      setState(() {

        id_ = id;
        name_ = name;
        photo_ = photo;
        place_ = place;
        email_ = email;

      });

    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }





}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text("My Friends",style: TextStyle(
              color: Colors.white
            ),),
          ),


          body:   ListView.builder(
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 200,
                child: Card(
                  elevation: 1,

                  // Adjust the elevation of the card shadow as needed
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.only(left: 10, top: 10),
                          height: 150,
                          // Adjust the height of the image container
                          child: Image.network(
                            photo_[index], // Replace with your image URL
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          // Adjust padding as needed
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                name_[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 8),
                              // Add spacing between title and description
                              Text(
                                place_[index],
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),
                              // Add spacing between title and description
                              // Add spacing between title and description

                              // Add spacing between title and description
                              Text(
                                email_[index],
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 8),

                              ElevatedButton(onPressed: () {


                                Navigator.push(context, MaterialPageRoute(builder: (context) => Vedocall()));




                              }, child: Text('Call'))
                              
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}
