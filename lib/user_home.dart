//
// import 'package:carousel_slider/carousel_slider.dart';
//
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:hospital/Moderator_sent_complaint.dart';
// import 'package:hospital/user_adddress.dart';
// import 'package:hospital/moderator_changepassword.dart';
// import 'package:hospital/user_skintonedetection.dart';
// import 'package:hospital/view_doctors.dart';
// import 'dart:convert';
// import 'package:hospital/view_prof_new.dart';
//
// import 'dresscombinations.dart';
// import 'login.dart';
//
//
//
//
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Clean',
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const UserHomePage(title: 'Register'),
//     );
//   }
// }
//
// class UserHomePage extends StatefulWidget {
//   const UserHomePage({super.key, required this.title});
//
//
//   final String title;
//
//   @override
//   State<UserHomePage> createState() => _UserHomePageState();
// }
//
// class _UserHomePageState extends State<UserHomePage> {
//   String photo='';
//   String name='';
//   String type='';
//
//   String email='email';
//   String phone='phone';
//
//   String gender='gender';
//   String image='image';
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // ipunique();
//     senddata();
//     view_movies();
//   }
//
//   //stable ip address settings third
//   void ipunique() async{
//     SharedPreferences s=await SharedPreferences.getInstance();
//     photo=s.getString('photo').toString();
//     name=s.getString('name').toString();
//     type=s.getString('type').toString();
//
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return WillPopScope(
//
//       onWillPop: () async{
//         Navigator.push(context, MaterialPageRoute(builder: (context) =>UserHomePage (title: '',),));
//
//         return false;
//
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Color.fromARGB(255, 18, 82, 98),
//
//
//           title: Text(widget.title),
//         ),
//         body: Container(
//           // decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/img2.jpg'))),
//
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // You can change this to control the number of columns
//             ),
//             itemCount: photo_.length,
//             itemBuilder: (context, index) {
//               return Card(
//                 child: Column(
//                   children: <Widget>[
//                     Image.network(
//                       photo_[index],
//                       height: 100,
//                       width: 100,
//                       fit: BoxFit.cover,
//                     ),
//                     Text(dname_[index]),
//
//                     Text(catname_[index]),
//                     Text(description_[index]),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Color.fromARGB(255, 18, 82, 98),
//                 ),
//                 child:
//                 Column(children: [
//
//
//                   CircleAvatar(radius: 29,backgroundImage: NetworkImage(image)),
//                   Text(
//                     name,
//                     style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
//
//                   ),
//
//
//
//
//                 ])
//
//
//                 ,
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: const Text('Home'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   // Navigator.push(context, MaterialPageRoute(builder: (context) => HomeNew(),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.person_pin),
//                 title: const Text(' Profile  '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => userProfile_new1(title: '',),)
//                   );
//                 },
//               ),
//
//
//               ListTile(
//                 leading: Icon(Icons.theaters),
//                 title: const Text('Add Dress '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => User_Adddress(),));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.movie_sharp),
//                 title: const Text('My Dress '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Mydress(title: '',),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.movie),
//                 title: const Text('SkinTone Detection '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => User_Skntonedetection(),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.notifications),
//                 title: const Text('Dress Combinations'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => Dresscombinations(title: '',),));
//                 },
//               ),
//               // ListTile(
//               //   leading: Icon(Icons.shop),
//               //   title: const Text('View Booking'),
//               //   onTap: () {
//               //
//               //     // Navigator.push(context, MaterialPageRoute(builder: (context) => view_booking(title: '',),));
//               //   },
//               // ),
//
//
//
//
//               ListTile(
//                 leading: Icon(Icons.feed_outlined),
//                 title: const Text('Send Suggestions'),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => MyComplaintHome(title: "Sent Suggestion",),));
//                 },
//               ),
//
//
//
//               ListTile(
//                 leading: Icon(Icons.change_circle),
//                 title: const Text(' Change Password '),
//                 onTap: () {
//                   Navigator.pop(context);
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => MyUserChangePassword(),));
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.logout),
//                 title: const Text('LogOut'),
//                 onTap: () {
//
//                   Navigator.push(context, MaterialPageRoute(builder: (context) => LoginNewPage(),));
//                 },
//               ),
//
//
//
//
//
//
//
//
//             ],
//           ),
//         ),
//
//
//
//
//
//       ),
//     );
//   }
//
//
//
//
//
//
//
//
//   String premium_type='no';
//
//
//
//
//
//
//   List<String> id_=[];
//
//
//   List<String> dname_=[];
//   List<String> description_=[];
//   List<String> photo_=[];
//   List<String> catname_=[];
//
//
//   void view_movies() async {
//
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     if (sh.getString('type').toString()=='premium')
//     {
//       setState(() {
//         premium_type='yes';
//       });
//     }
//
//     List<String> id = <String>[];
//     List<String> dname = <String>[];
//     List<String> description = <String>[];
//     List<String> photo = <String>[];
//     List<String> catname = <String>[];
//
//      sh=await SharedPreferences.getInstance();
//     try {
//       String urls = sh.getString('url').toString();
//       String url = '$urls/user_view_dress_adminadded/';
//       String lid = sh.getString("lid").toString();
//       String imgurl = sh.getString("imgurl").toString();
//       var data = await http.post(Uri.parse(url), body: {
//         "lid": lid,
//       });
//       var jsondata = json.decode(data.body);
//
//       print(jsondata);
//
//
//       var arr = jsondata["data"];
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         dname.add(arr[i]['dname']);
//         description.add(arr[i]['description']);
//         catname.add(arr[i]['catname']);
//         photo.add(imgurl+arr[i]['photo']);
//
//
//       }
//
//
//       setState(() {
//         id_ = id;
//         dname_ = dname;
//         description_ = description;
//         catname_ = catname;
//         photo_ = photo;
//       });
//
//
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//   void senddata()async{
//
//
//
//     SharedPreferences sh=await SharedPreferences.getInstance();
//     String url=sh.getString('url').toString();
//     String lid=sh.getString('lid').toString();
//     final urls=Uri.parse(url+"/userviewprofile/");
//     try{
//       final response=await http.post(urls,body:{
//         'lid':lid,
//       });
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status=='ok') {
//           Fluttertoast.showToast(msg: 'Success');
//
//
//           print(response.body);
//
//
//           setState(() {
//             email=jsonDecode(response.body)['email'];
//             name=jsonDecode(response.body)['name'];
//             phone=jsonDecode(response.body)['phone'];
//
//             gender=jsonDecode(response.body)['gender'];
//             type="";
//             image=sh.getString('imgurl').toString()+jsonDecode(response.body)['photo'];
//
//
//
//           });
//
//         }else {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       }
//       else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     }
//     catch (e){
//       Fluttertoast.showToast(msg: e.toString());
//     }
//
//   }
//
//
//
// }
//
