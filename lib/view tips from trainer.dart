
// import 'package:clinicpharma/signUpmain.dart';
// import 'package:clinicpharma/signup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      home: const  Mytipsfromtrainer(title: 'Login'),
    );
  }
}

class  Mytipsfromtrainer extends StatefulWidget {
  const  Mytipsfromtrainer({super.key, required this.title});

  final String title;

  @override
  State< Mytipsfromtrainer> createState() => _MytipsfromtrainerState();
}

class _MytipsfromtrainerState extends State< Mytipsfromtrainer> {

  _MytipsfromtrainerState()
  {
    viewdata();
  }
  TextEditingController ipController = new TextEditingController();

  List<String> id_ = <String>[];
  List<String> Tiptitle_ = <String>[];
  List<String> Date_ = <String>[];
  List<String> Tips_ = <String>[];


  void viewdata() async {

    List<String> id = <String>[];
    List<String> Tiptitle = <String>[];
    List<String> Date = <String>[];
    List<String> Tips = <String>[];

    SharedPreferences sh = await SharedPreferences.getInstance();
    try {
      String urls = sh.getString('url').toString();
      String url = '$urls/user_view_tips/';

      String imgurl = sh.getString("imgurl").toString();
      String lid = sh.getString("lid").toString();
      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        Tiptitle.add(arr[i]['Tiptitle'].toString());
        Date.add(arr[i]['Date'].toString());
        Tips.add(arr[i]['Tips'].toString());

      }

      setState(() {

        id_ = id;
        Tiptitle_ = Tiptitle;
        Date_ = Date;
        Tips_ = Tips;

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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),


        body:    ListView.builder(
          itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 290,
              child: Card(
                elevation: 1,

                // Adjust the elevation of the card shadow as needed
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        // Adjust padding as needed
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Date_[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 8),
                            // Add spacing between title and description
                            Text(
                              Tiptitle_[index],
                              style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            // Add spacing between title and description
                            Text(
                              Tips_[index],
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            // Add spacing between title and description

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
