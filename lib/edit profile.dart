
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
  runApp(const Editprofile());
}

class Editprofile extends StatelessWidget {
  const Editprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EditprofilePage(title: 'Login'),
    );
  }
}

class EditprofilePage extends StatefulWidget {
  const EditprofilePage({super.key, required this.title});

  final String title;

  @override
  State<EditprofilePage> createState() => _EditprofilePageState();
}

class _EditprofilePageState extends State<EditprofilePage> {


  _EditprofilePageState()
  {
      senddata();
  }


  TextEditingController nameController= new TextEditingController();
  TextEditingController phonenumController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController dobController= new TextEditingController();
  TextEditingController placeController= new TextEditingController();
  TextEditingController stateController= new TextEditingController();
  TextEditingController postController= new TextEditingController();
  TextEditingController pinController= new TextEditingController();
  TextEditingController districtController= new TextEditingController();
  String gender="";
  String phot="";


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


            nameController.text=jsonDecode(response.body)['name'].toString();
            dobController.text=jsonDecode(response.body)['dob'].toString();
            gender=jsonDecode(response.body)['gender'].toString();
            placeController.text=jsonDecode(response.body)['place'].toString();
            postController.text=jsonDecode(response.body)['post'].toString();
            districtController.text=jsonDecode(response.body)['district'].toString();
            stateController.text=jsonDecode(response.body)['state'].toString();
            pinController.text=jsonDecode(response.body)['pin'].toString();
            emailController.text=jsonDecode(response.body)['email'].toString();
            phonenumController.text=jsonDecode(response.body)['phone'].toString();
            String photo=sh.getString('imgurl').toString()+jsonDecode(response.body)['photo'];


            setState(() {
              gender= gender;
              phot= photo;

            });

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




  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),


        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 300,),

          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Name")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: dobController,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("DoB")),
            ),
          ),
          RadioListTile(value: "Male", groupValue: gender, onChanged: (value) { setState(() {gender="Male";}); },title: Text("Male"),),
          RadioListTile(value: "Female", groupValue: gender, onChanged: (value) { setState(() {gender="Female";}); },title: Text("Female"),),
          RadioListTile(value: "Other", groupValue: gender, onChanged: (value) { setState(() {gender="Other";}); },title: Text("Other"),),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Email")),
            ),
          ),   Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller:phonenumController,
            decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Phone")),
          ),
        ),   Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller:placeController,
            decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Place")),
          ),
        ),   Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            controller:postController,
            decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Post")),
          ),
        ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller:pinController,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Pin")),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller:districtController,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("District")),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller:stateController,
              decoration: InputDecoration(border: OutlineInputBorder(),label: Text("state")),
            ),
          ),

          ElevatedButton(
            onPressed: () async {

              String name = nameController.text.toString();
              String phonenum=phonenumController.text.toString();
              String email=emailController.text.toString();
              String dob=dobController.text.toString();
              String place=placeController.text.toString();
              String state=stateController.text.toString();
              String post=postController.text.toString();
              String pin=pinController.text.toString();
              String district=districtController.text.toString();

              SharedPreferences sh = await SharedPreferences.getInstance();
              String url = sh.getString('url').toString();
              String lid = sh.getString('lid').toString();

              final urls = Uri.parse('$url/usereditprofile/');
              try {
                final response = await http.post(urls, body: {
                  'lid':lid,
                  'name':name,
                  'dob':dob,
                  'photo':"photo",
                  'place':place,
                  'post':post,
                  'pin':pin,
                  'district':district,
                  'state':state,
                  'email':email,
                  'gender':gender,
                  'phone':phonenum,





                });
                if (response.statusCode == 200) {
                  String status = jsonDecode(response.body)['status'];
                  if (status=='ok') {
                    // if (type=="user"){
                    Fluttertoast.showToast(msg: 'profile edited succesfully');
                  }
                  else {
                    Fluttertoast.showToast(msg: 'failed to send profile');
                  }
                }
                else {
                  Fluttertoast.showToast(msg: 'Network Error');
                }
              }
              catch (e){
                Fluttertoast.showToast(msg: e.toString());
              }





            },
            child: Text("Signup"),
          ),

            ],
          ),
        ),
      ),
    );
  }



}
