import 'package:flutter/services.dart';
import 'package:aipsychologist/screens/Home.dart';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import 'edit profile.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home:  (title: 'Sent Complaint'),
    );
  }
}


class userProfile_new1 extends StatefulWidget {
  const userProfile_new1({super.key, required this.title});


  final String title;

  @override
  State<userProfile_new1> createState() => _userProfile_new1State();
}
class _userProfile_new1State extends State<userProfile_new1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    senddata();
  }

  String name='name';
  String dob='name';
  String gender='name';
  String place='name';
  String post='name';
  String district='name';
  String state='name';
  String pin='name';
  String email='name';
  String phone='name';
  String photo='name';
  String qualification='name';

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Home(),));
        return false;

      },
      child: Scaffold(
        backgroundColor: Colors.grey.shade300,
        // appBar: AppBar(
        //   backgroundColor: Color.fromARGB(255, 18, 82, 98),
        //
        //   title: Text("Change Password",
        //       style: TextStyle(
        //           color: Color.fromARGB(255, 255, 255, 255)
        //       )),
        // ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                height: 280,
                width: double.infinity,
                child: Image.network(
                  photo,
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(16.0, 240.0, 16.0, 16.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          margin: EdgeInsets.only(top: 16.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(left: 110.0),
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            ' $name',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6,
                                          ),
                                          // Text(
                                          //   '$email',
                                          //   style: Theme.of(context)
                                          //       .textTheme
                                          //       .bodyText1,
                                          // ),
                                          SizedBox(
                                            height: 40,
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      CircleAvatar(
                                        backgroundColor: Colors.blueAccent,
                                        child: IconButton(
                                            onPressed: () {
                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => EditprofilePage(title: 'Edit Profile',),));     },
                                            icon: Icon(
                                              Icons.edit_outlined,
                                              color: Colors.white,
                                              size: 18,
                                            )),
                                      )
                                    ],
                                  )),
                              SizedBox(height: 10.0),
                              Row(
                                children: [

                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              image:  DecorationImage(
                                  image: NetworkImage(
                                      photo),
                                  fit: BoxFit.cover)),
                          margin: EdgeInsets.only(left: 20.0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Column(
                        children:  [
                          ListTile(
                            title: Text("Profile Information"),
                          ),
                          Divider(),
                          // ListTile(
                          //   title: Text("Date of Birth"),
                          //   subtitle: Text("12 September 2001"),
                          //   leading: Icon(Icons.calendar_view_day),
                          // ),
                          // ListTile(
                          //   title: Text('Qualifiactaion'),
                          //   subtitle: Text("Bachelor Degree"),
                          //   leading: Icon(Icons.school_outlined),
                          // ),


                          ListTile(
                            title: Text("Gender"),
                            subtitle: Text('$gender'),
                            leading: Icon(Icons.male_sharp),
                          ),
                          ListTile(
                            title: Text("Dob"),
                            subtitle: Text('$dob'),
                            leading: Icon(Icons.male_sharp),
                          ),
                          ListTile(
                            title: Text('Email'),
                            subtitle: Text(email),
                            leading: Icon(Icons.mail_outline),
                          ),
                          ListTile(
                            title: Text("Phone"),
                            subtitle: Text(phone),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text("Place"),
                            subtitle: Text(place),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text("Post"),
                            subtitle: Text(post),
                            leading: Icon(Icons.phone),
                          ),

                          ListTile(
                            title: Text("District"),
                            subtitle: Text(district),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text("State"),
                            subtitle: Text(state),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                            title: Text("Pincode"),
                            subtitle: Text(pin),
                            leading: Icon(Icons.phone),
                          ),
                          ListTile(
                                title: Text("Qualification"),
                                subtitle: Text(qualification),
                                leading: Icon(Icons.phone),
                              ),



                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                top: 60,
                left: 20,
                child: MaterialButton(
                  minWidth: 0.2,
                  elevation: 0.2,
                  color: Colors.white,
                  child: const Icon(Icons.arrow_back_ios_outlined,
                      color: Colors.indigo),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context) =>Home (),));



                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void senddata()async{



    SharedPreferences sh=await SharedPreferences.getInstance();
    String url=sh.getString('url').toString();
    String lid=sh.getString('lid').toString();
    final urls=Uri.parse(url+"/userviewprofile/");
    try{
      final response=await http.post(urls,body:{
        'lid':lid,
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status=='ok') {
          Fluttertoast.showToast(msg: 'Success');

          setState(() {


            name=jsonDecode(response.body)['name'].toString();
            dob=jsonDecode(response.body)['dob'].toString();
            gender=jsonDecode(response.body)['gender'].toString();
            place=jsonDecode(response.body)['place'].toString();
            post=jsonDecode(response.body)['post'].toString();
            district=jsonDecode(response.body)['district'].toString();
            state=jsonDecode(response.body)['state'].toString();
            pin=jsonDecode(response.body)['pin'].toString();
            email=jsonDecode(response.body)['email'].toString();
            phone=jsonDecode(response.body)['phone'].toString();
            qualification=jsonDecode(response.body)['idproof'].toString();

            photo=sh.getString('imgurl').toString()+jsonDecode(response.body)['photo'];

          });

        }else {
          Fluttertoast.showToast(msg: 'Not Found');
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

}