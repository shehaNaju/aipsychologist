
// import 'package:clinicpharma/signUpmain.dart';
// import 'package:clinicpharma/signup.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'add_diary.dart';
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
      home: const  Viewdiary(title: 'Login'),
    );
  }
}

class  Viewdiary extends StatefulWidget {
  const  Viewdiary({super.key, required this.title});

  final String title;

  @override
  State< Viewdiary> createState() => _ViewdiaryState();
}

class _ViewdiaryState extends State< Viewdiary> {


  _ViewdiaryState()
  {
    viewdata();
  }

  TextEditingController ipController = new TextEditingController();


  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> Diary_ = <String>[];



  void viewdata() async {

    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> Diary = <String>[];

    SharedPreferences sh = await SharedPreferences.getInstance();
    try {
      String urls = sh.getString('url').toString();
      String url = '$urls/userviewdiary/';

      String imgurl = sh.getString("imgurl").toString();
      String lid = sh.getString("lid").toString();
      var data = await http.post(Uri.parse(url), body: {

        'lid':lid

      });
      var jsondata = json.decode(data.body);

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        Diary.add(arr[i]['Diary'].toString());


      }

      setState(() {

        id_ = id;
        date_ = date;
        Diary_ = Diary;


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

          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            onPressed: () {

              Navigator.push(context, MaterialPageRoute(builder: (context) => AddDiary(title: 'Add Diary',),));

            },
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
                              date_[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),

                            SizedBox(height: 8),
                            // Add spacing between title and description
                            Text(
                              Diary_[index],
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
