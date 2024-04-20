import 'dart:convert';

import 'package:aipsychologist/screens/Home.dart';
import 'package:aipsychologist/user_home.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


void main() {
  runApp(const sent_feedback());
}

class sent_feedback extends StatelessWidget {
  const sent_feedback({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Review',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home:  sent_feedbackHome(title: 'Send Feedback'),
    );
  }
}

class sent_feedbackHome extends StatefulWidget {
  const sent_feedbackHome({super.key, required this.title});



  final String title;

  @override
  State<sent_feedbackHome> createState() => _sent_feedbackHomeState();
}

class _sent_feedbackHomeState extends State<sent_feedbackHome> {
  TextEditingController complaintcontroller = new TextEditingController();
  final _formkey=GlobalKey<FormState>();



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

          title: Text("Send Review",style: TextStyle(
            color: Colors.white
          ),),
        ),
        body: Form(
          key: _formkey,

          child: Center(

            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text('Type your review here',)),


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
                        return "Please enter review.";
                      }

                      return null;
                    },
                  ),
                ),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                // print(rating);
                ratings=rating.toString();
              },
            ),





                Padding(
                  padding: EdgeInsets.all(15),
                  child: ElevatedButton(onPressed: () {
                    if (_formkey.currentState!.validate()){
                      sendsuggestions();
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

  String ratings="0";

  void sendsuggestions() async {
    String feedback = complaintcontroller.text.toString();

    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    final urls = Uri.parse(url + "/sendreview/");
    try {
      final response = await http.post(urls, body: {
        'review': feedback,
        'lid': lid,
        'ratings': ratings,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(msg: 'Review Sent');


          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home(),));
        } else {
          Fluttertoast.showToast(msg: 'Failed to sent review');
        }
      }
      else {
        Fluttertoast.showToast(msg: 'Network Error or failure in senting review');
      }
    }
    catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  String? validatecomplaint(String value) {
    if (value.isEmpty) {
      return 'Please enter review';
    }
    return null;
  }
}
