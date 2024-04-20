

// import 'dart:html';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:image_picker/image_picker.dart ';

// import 'package:permission_handler/permission_handler.dart';
import 'login.dart';


void main() {
  runApp(const MyMySignup());
}

class MyMySignup extends StatelessWidget {
  const MyMySignup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MySignup',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyMySignupPage(title: 'MySignup'),
    );
  }
}

class MyMySignupPage extends StatefulWidget {
  const MyMySignupPage({super.key, required this.title});

  final String title;

  @override
  State<MyMySignupPage> createState() => _MyMySignupPageState();
}

class _MyMySignupPageState extends State<MyMySignupPage> {

  String gender = "Male";
  File? uploadimage;
  File? uploadimage1;
  TextEditingController nameController= new TextEditingController();
  TextEditingController phonenumController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController dobController= new TextEditingController();
  TextEditingController placeController= new TextEditingController();
  TextEditingController stateController= new TextEditingController();
  TextEditingController postController= new TextEditingController();
  TextEditingController pinController= new TextEditingController();
  TextEditingController districtController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  TextEditingController ConfirmpasswordController= new TextEditingController();






  // Future<void> chooseImage() async {
  //   // final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   //set source: ImageSource.camera to get image from camera
  //   setState(() {
  //     // uploadimage = File(choosedimage!.path);
  //   });
  // }




  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async{ return true; },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title,style: TextStyle(
            color: Colors.white
          ),),
        ),
        body: SingleChildScrollView(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(children: [SizedBox(width: 30,),

                if (_selectedImage != null) ...{
                InkWell(
                  child:
                  Image.file(_selectedImage!, height: 150,),
                  radius: 150,
                  onTap: _checkPermissionAndChooseImage,
                  // borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              } else ...{
                // Image(image: NetworkImage(),height: 150, width: 70,fit: BoxFit.cover,),
                InkWell(
                  onTap: _checkPermissionAndChooseImage,
                  child:Column(
                    children: [
                      Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 150,width: 150,),
                      Text('Select Image',style: TextStyle(color: Colors.cyan))
                    ],
                  ),
                ),
              },





               ],),
              // if (_selectedImage != null) ...{
              //   InkWell(
              //     child:
              //     Image.file(_selectedImage!, height: 400,),
              //     radius: 399,
              //     onTap: _checkPermissionAndChooseImage,
              //     // borderRadius: BorderRadius.all(Radius.circular(200)),
              //   ),
              // } else ...{
              //   // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
              //   InkWell(
              //     onTap: _checkPermissionAndChooseImage,
              //     child:Column(
              //       children: [
              //         Image(image: NetworkImage('https://cdn.pixabay.com/photo/2017/11/10/05/24/select-2935439_1280.png'),height: 200,width: 200,),
              //         Text('Select Image',style: TextStyle(color: Colors.cyan))
              //       ],
              //     ),
              //   ),
              // },
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
              ),  Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller:passwordController,
                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Password")),
                ),
              ),     Padding(
                padding: const EdgeInsets.all(8),
                child: TextField(
                  controller: ConfirmpasswordController,

                  decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Confirm Password")),
                ),
              ),

              ElevatedButton(
                onPressed: () {

                  _send_data() ;

                },
                child: Text("Signup"),
              ),TextButton(
                onPressed: () {},
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void showsnackbar(String msg)
  {
    SnackBar snackdemo = SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green,
      elevation: 10,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(5),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackdemo);
  }

  void _send_data() async{

    String name=nameController.text;
    String dob=dobController.text;
    String email=emailController.text;
    String phonenum=phonenumController.text;
    String place=placeController.text;
    String post=postController.text;
    String pin=pinController.text;
    String distri=districtController.text;
    String state=stateController.text;
    String pass=passwordController.text;
    String conf=ConfirmpasswordController.text;

    if(name.length==0)
      {
        showsnackbar("Missing Name");

      }
    else if(dob.length==0)
    {
      showsnackbar("Missing Dob");

    }
    else if(email.length==0)
    {
      showsnackbar("Missing Email");

    }
    else if(phonenum.length==0)
    {
      showsnackbar("Missing Phone");

    }
    else if(place.length==0)
    {
      showsnackbar("Missing place");

    }
      else if(post.length==0)
    {
      showsnackbar("Missing post");

    } else if(pin.length==0)
    {
      showsnackbar("Missing Pincode");

    }else if(distri.length==0)
    {
      showsnackbar("Missing District");

    }else if(state.length==0)
    {
      showsnackbar("Missing State");

    }else if(pass.length==0)
    {
      showsnackbar("Missing Password");

    }else if(conf.length==0)
    {
      showsnackbar("Missing Confirm Password");

    }


    else {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();

      final urls = Uri.parse('$url/usersignup/');
      try {
        final response = await http.post(urls, body: {
          "photo": photo,

          "name": name,
          "dob": dob,
          "email": email,
          "phone": phonenum,
          "place": place,
          "post": post,
          "pin": pin,
          "district": distri,
          "password": pass,
          "confirmpassword": conf,
          "gender": gender,
          "state": state,
        });
        if (response.statusCode == 200) {
          String status = jsonDecode(response.body)['status'];
          if (status == 'ok') {
            // Fluttertoast.showToast(msg: '$urls');
            Fluttertoast.showToast(msg: 'Registration Successfull');
            Navigator.push(context, MaterialPageRoute(
              builder: (context) => LoginNewPage(),));
          } else {
            Fluttertoast.showToast(msg: 'Not Found');
          }
        }
        else {
          Fluttertoast.showToast(msg: 'Network Error');
        }
      }
      catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
  File? _selectedImage;
  File? _selectedImage1;
  String? _encodedImage;
  String? _encodedImage1;
  Future<void> _chooseAndUploadImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
        _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
        photo = _encodedImage.toString();
      });
    }
  }


  Future<void> _checkPermissionAndChooseImage() async {

    final PermissionStatus status = await Permission.mediaLibrary.request();
    if (status.isGranted) {
      _chooseAndUploadImage();
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Permission Denied'),
          content: const Text(
            'Please go to app settings and grant permission to choose an image.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }


  String photo = '';


}
