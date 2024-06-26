// import 'package:flutter/material.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'GeeksforGeeks',
//
//       // to hide debug banner
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: HomePage(),
//     );
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('GeeksforGeeks'),
//         ),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () => Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (ctx) => FutureDemoPage(),
//               ),
//             ),
//             child: Text('Demonstrate FutureBuilder'),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class FutureDemoPage extends StatelessWidget {
//   /// Function that will return a
//   /// "string" after some time
//   /// To demonstrate network call
//   /// delay of [2 seconds] is used
//   ///
//   /// This function will behave as an
//   /// asynchronous function
//   Future<String> getData() {
//
//
//     return Future.delayed(Duration(seconds: 2), () {
//       return "I am data";
//       // throw Exception("Custom Error");
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Future Demo Page'),
//         ),
//         body: FutureBuilder(
//           builder: (ctx, snapshot) {
//             // Checking if future is resolved or not
//             if (snapshot.connectionState == ConnectionState.done) {
//               // If we got an error
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text(
//                     '${snapshot.error} occurred',
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 );
//
//                 // if we got our data
//               } else if (snapshot.hasData) {
//                 // Extracting data from snapshot object
//                 final data = snapshot.data as String;
//                 return Center(
//                   child:
//                   Container(
//                       decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage('assets/'), fit: BoxFit.cover),
//                       ),
//                       child: VideoPlayerWidget(videoUrl: data,)
//
//
//
//                   )
//
//                   ,
//                 );
//               }
//             }
//
//             // Displaying LoadingSpinner to indicate waiting state
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           },
//
//           // Future that needs to be resolved
//           // inorder to display something on the Canvas
//           future: getData(),
//         ),
//       ),
//     );
//   }
// }
