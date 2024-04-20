import 'dart:async';
import 'dart:convert';

import 'package:aipsychologist/Chathj.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:aipsychologist/Chat.dart';
import 'package:aipsychologist/sent_feedback.dart';
import 'package:aipsychologist/view%20friendrequest.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:aipsychologist/screens/SeeAll.dart';
import 'package:aipsychologist/res/lists.dart';
import 'package:aipsychologist/widgets/text_widget.dart' ;
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:http/http.dart' as http;


import '../add_diary.dart';
import '../login.dart';
import '../sent_complaint.dart';

import '../sent_review.dart';
import '../user_changepassword.dart';

import '../view mentors.dart';
import '../view tips from trainer.dart';
import '../view users.dart';
import '../view friends.dart';

import '../view_diary.dart';
import '../view_motivationalvedios.dart';
import '../view_my_mentors.dart';
import '../view_prof_new.dart';
import '../view_reply.dart';
import '../vpaly.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var opacity = 0.0;
  bool position=false;

  String user_name_="";
  String user_photo_="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view_patients();
    Future.delayed(Duration.zero, () {
      animator();



    });
  }
  animator() {
    if (opacity == 1) {
      opacity = 0;
      position=false;
    } else {
      opacity = 1;
      position=true;
    }
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 30, left: 0, right:0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                top: position ? 1 : 100,
                right: 20,
                left: 20,
                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 400),
                  opacity: opacity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [

                              CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(user_photo_),
                              ),

                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextWidget("Welcome", 17, Colors.black.withOpacity(.7),
                                      FontWeight.bold),
                                  TextWidget(user_name_, 25, Colors.black, FontWeight.bold),
                                ],
                              )

                            ],
                          )



                        ],
                      ),

                      // IconButton(
                      //   icon: Icon(Icons.message),
                      //   onPressed: () {
                      //
                      //     Navigator.push(context, MaterialPageRoute(builder: (context) => Chatbotss(),));
                      //
                      //   },
                      //   // Optionally, you can specify the icon's size and color
                      //   iconSize: 40,
                      //   color: Colors.blue,
                      // ),
                      IconButton(
                        icon: Icon(Icons.logout),
                        onPressed: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginNewPage(),));

                        },
                        // Optionally, you can specify the icon's size and color
                        iconSize: 40,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ),
              ),
              // AnimatedPositioned(
              //   top: position ? 80 : 140,
              //   left: 20,
              //   right: 20,
              //   duration: const Duration(milliseconds: 400),
              //   child: AnimatedOpacity(
              //     duration: const Duration(milliseconds: 400),
              //     opacity: opacity,
              //     child: Container(
              //       height: 50,
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(15),
              //       ),
              //       child:
              //         Row(
              //           children: [
              //             TextButton(onPressed: () {
              //
              //             }, child: Text("Accepted"))
              //           ],
              //         )
              //
              //
              //     ),
              //   ),
              // ),
              AnimatedPositioned(
                  top: position ? 80 : 220,
                  right: 20,
                  left: 20,
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.blue.shade700,
                                  Colors.blue.shade900,
                                  Colors.blue.shade900,
                                ])),
                        child: Stack(
                          children: [
                            Positioned(
                                top: 25,
                                left: 20,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 30,
                                      child: Center(
                                        child: Image(
                                          fit: BoxFit.fill,
                                          image:
                                              AssetImage('assets/images/p1.png'),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextWidget(
                                          "AI Psychologist",
                                          15,
                                          Colors.white,
                                          FontWeight.normal,
                                          letterSpace: 1,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              "AI Based Solution",
                                              15,
                                              Colors.white,
                                              FontWeight.normal,
                                              letterSpace: 1,
                                            ),
                                            TextWidget(
                                              "",
                                              15,
                                              Colors.white,
                                              FontWeight.bold,
                                              letterSpace: 2,
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                )),
                            Positioned(
                                top: 100,
                                left: 20,
                                child: Container(
                                  height: 1,
                                  width: 300,
                                  color: Colors.white.withOpacity(.5),
                                )),
                            Positioned(
                                top: 115,
                                left: 20,
                                right: 1,
                                child: Container(
                                  width: double.infinity,
                                  child: Row(
                                    children: [
                                      TextWidget("A product by Ihrd vazhakkad", 15,
                                          Colors.white, FontWeight.bold,
                                          letterSpace: 1),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Expanded(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.blue,
                                              ),
                                            ),
                                            Positioned(
                                              left: 20,
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.red,
                                              ),
                                            ),
                                            Positioned(
                                              left: 40,
                                              child: CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                            const Positioned(
                                top: 10,
                                right: 10,
                                child: Icon(
                                  Icons.close_outlined,
                                  color: Colors.white,
                                  size: 15,
                                ))
                          ],
                        ),
                      ),
                    ),
                  )),
              categoryRow(),
              AnimatedPositioned(
                  top: position?360:500,
                  left: 20,
                  right: 20, duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: opacity,
                    child: Container(
                child:

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget("Others", 25, Colors.black.withOpacity(.8), FontWeight.bold,letterSpace: 0,),
                      InkWell(
                        onTap: () async
                          {
                            animator();
                            setState(() {
                            });
                            // Timer(Duration(seconds: 1),() {
                            //   Navigator.push(context, MaterialPageRoute(builder: (context) => SeeAll(),));
                            //   animator();
                            // },);
                            await Future.delayed(const Duration(milliseconds: 500));
                            await Navigator.push(context, MaterialPageRoute(builder:  (context) {
                              return SeeAll();
                            },));

                            setState(() {
                              animator();
                            });
                          },
                          child: Text("")),
                          // TextWidget("See all", 15, Colors.blue.shade600.withOpacity(.8), FontWeight.bold,letterSpace: 0,)),
                    ],
                ),
              ),
                  )),
              doctorList(),
              Align(
                alignment: Alignment.bottomCenter,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,

                    child: CurvedNavigationBar(
                      onTap: (value) {
                        if(value==0)
                        {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Viewdiary(title: 'Diary',),));
                        }
                        if(value==1)
                        {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Mytipsfromtrainer(title: 'View tips',),));
                        }
                        if(value==2)
                        {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => sent_feedbackHome(title: 'Write review',),));
                            // Navigator.push(context, MaterialPageRoute(builder: (context) => User_Adddress(),));
                        }
                        if(value==3)
                        {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyUserChangePassword(),));
                        }
                      },

                        backgroundColor: Colors.white,
                        items: const [
                          Icon(Icons.add_circle,color: Colors.blue,size: 30,),
                          Icon(Icons.feedback,color: Colors.black,size: 30,),
                          Icon(Icons.add_box_rounded,color: Colors.black,size: 30,),

                          Icon(Icons.settings,color: Colors.black,size: 30,),
                        ]),
                  ))

            ],
          ),
        ),
      ),
    );
  }



  void view_patients() async {

    SharedPreferences sh = await SharedPreferences.getInstance();



    sh=await SharedPreferences.getInstance();
    try {
      String urls = sh.getString('url').toString();
      String url = '$urls/userviewprofile/';
      String lid = sh.getString("lid").toString();
      String imgurl = sh.getString("imgurl").toString();
      var data = await http.post(Uri.parse(url), body: {
        "lid": lid,
      });
      var jsondata = json.decode(data.body);

      print(jsondata);
      var uname = jsondata["name"];

      var uphoto = imgurl+jsondata["photo"];





      setState(() {


        user_name_= uname;
        user_photo_= uphoto;
      });





    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }


  AnimatedPositioned doctorList()  {


    return AnimatedPositioned(
        top: position?390:550,
        left: 20,
        right: 20,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 300),
            child: SizedBox(
              height: 270,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child:
                Column(
                  children: a(),
                ),

              ),
            ),
          ),
        )
    );
  }
  Widget doctorCard(String name,String gender,AssetImage image){
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        height: 120,
        width: double.infinity,
        child: Row(
          children: [
            const SizedBox(width: 10,),
            CircleAvatar(
              radius: 30,
              backgroundImage: image,
              // backgroundColor: Colors.blue,
            ),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(name, 20, Colors.black,FontWeight.bold,letterSpace: 0,),
                const SizedBox(height: 5,),

                TextButton(onPressed: () {

                  if(name=="My Mentor")
                  {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Viewphycologist_mine(title: 'Requests',)));
                  }
                  else if(name=="Videos")
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => View_motivational_vedios(title: 'Videos',)));
                  }


                }, child: Text('Click here')),


                const SizedBox(height: 5,),
                // const Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Icon(Icons.star,color: Colors.orangeAccent,),
                //     Icon(Icons.star,color: Colors.orangeAccent,),
                //     Icon(Icons.star,color: Colors.orangeAccent,),
                //     Icon(Icons.star,color: Colors.orangeAccent,),
                //     Icon(Icons.star,color: Colors.orangeAccent,),
                //   ],
                // ),
              ],
            ),

          ],
        ),
      ),
    );
  }
  Widget categoryRow(){
    return AnimatedPositioned(
        top: position? 240 : 420,
        left: 25,
        right: 25,
        duration: const Duration(milliseconds: 400),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: opacity,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                category("assets/images/profile.png", "Profile",5),
                category1("assets/images/colortone.png", "Psychologist",10),

                category3("assets/images/mydres.png", "Videos",12),

                category2("assets/images/wedding.png", "Complaints",10),

              ],
            ),
          ),
        ));
  }
  Widget category(String asset,String txt,double padding){
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => userProfile_new1(title: '',),));
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              padding:  EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image:
                  AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }
  Widget category1(String asset,String txt,double padding){
    return Column(
      children: [
        InkWell(
          onTap: () {

            Navigator.push(context, MaterialPageRoute(builder: (context) => Viewphycologist(title: 'Mentors',),));

          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              padding:  EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image:
                  AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }
  Widget category2(String asset,String txt,double padding){
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) => View_reply(title: 'Complaints',),));
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              padding:  EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image:
                  AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }
  Widget category3(String asset,String txt,double padding){
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            // Navigator.push(context, MaterialPageRoute(builder: (context) => View_booking(title: 'Booking',),));



            Navigator.push(context, MaterialPageRoute(builder: (context) => View_motivational_vedios(title: 'Videos',),));



          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              padding:  EdgeInsets.all(padding),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image(
                  image:
                  AssetImage(asset),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        TextWidget(
          txt,
          16,
          Colors.black,
          FontWeight.bold,
          letterSpace: 1,
        ),
      ],
    );
  }


  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> place_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> email_ = <String>[];
  List<String> reqid_ = <String>[];


  void viewrequests() async {

    List<String> id = <String>[];
    List<String> name= <String>[];
    List<String> photo = <String>[];
    List<String> place = <String>[];
    List<String> email = <String>[];
    List<String> reqid = <String>[];

    SharedPreferences sh = await SharedPreferences.getInstance();
    try {
      String urls = sh.getString('url').toString();
      String url = '$urls/user_view_friend_request/';

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
        reqid.add(arr[i]['reqid'].toString());

      }

      setState(() {

        id_ = id;
        name_ = name;
        photo_ = photo;
        place_ = place;
        email_ = email;
        reqid_ = reqid;

      });

    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }





  }



  a() {




   List<Widget> s= [



      // doctorCard("Requests", "",AssetImage("assets/images/profile.png")),
      doctorCard("My Mentor", "",AssetImage("assets/images/profile.png")),
      doctorCard("Videos", "",AssetImage("assets/images/profile.png")),


      // doctorCard(names[2], spacilality[2], images[2]),
      // doctorCard(names[2], spacilality[2], images[2]),
      // doctorCard(names[2], spacilality[2], images[2]),
      // doctorCard(names[2], spacilality[2], images[2]),
    ];


   return s;


  }


}
