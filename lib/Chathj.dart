import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Chatbotss(),
    );
  }
}

class Chatbotss extends StatefulWidget {
  @override
  _ChatbotssState createState() => _ChatbotssState();
}

class _ChatbotssState extends State<Chatbotss> {
  TextEditingController _controller = TextEditingController();
  List<String> messages = [];

  Future<void> sendMessage(String message) async {
    // Replace 'YOUR_OPENAI_API_KEY' with your actual API key
    String apiKey = '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';
    String endpoint = 'https://api.openai.com/v1/chat/completions';

    Map<String, dynamic> data = {
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'system', 'content': 'You are a helpful assistant.'},
        {'role': 'user', 'content': message},
      ],
    };

    var response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      String reply = responseData['choices'][0]['message']['content'];
      setState(() {
        messages.add(message);
        messages.add(reply);
      });
    } else {
      print('Failed to send message. Error: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OpenAI Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    String message = _controller.text;
                    if (message.isNotEmpty) {
                      sendMessage(message);
                      _controller.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}







// import 'dart:async';
// import 'dart:convert';
//
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(const MyChatApp());
// }
//
// class MyChatApp extends StatelessWidget {
//   const MyChatApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyChatPage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyChatPage extends StatefulWidget {
//   const MyChatPage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyChatPage> createState() => _MyChatPageState();
// }
//
// class ChatMessage {
//   String messageContent;
//   String messageType;
//
//   ChatMessage({required this.messageContent, required this.messageType});
// }
//
// class _MyChatPageState extends State<MyChatPage> {
//   int _counter = 0;
//   String name = "";
//
//   _MyChatPageState() {
//     Timer.periodic(Duration(seconds: 2), (_) {
//       // view_message();
//     });
//   }
//
//   List<ChatMessage> messages = [];
//
//
//   TextEditingController te_message = TextEditingController();
//
//   List<String> from_id_ = <String>[];
//   List<String> to_id_ = <String>[];
//   List<String> message_ = <String>[];
//   List<String> date_ = <String>[];
//   // List<String> time_ = <String>[];
//
//   Future<void> view_message() async {
//     final pref = await SharedPreferences.getInstance();
//     name = pref.getString("agrname").toString();
//
//     List<String> from_id = <String>[];
//     List<String> to_id = <String>[];
//     List<String> message = <String>[];
//     List<String> date = <String>[];
//     // List<String> time = <String>[];
//
//     try {
//       final pref = await SharedPreferences.getInstance();
//       String urls = pref.getString('url').toString();
//       String url = '$urls/user_viewchat/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         'from_id': pref.getString("lid").toString(),
//         'to_id': pref.getString("tolid").toString()
//       });
//       var jsondata = json.decode(data.body);
//       String status = jsondata['status'];
//
//       var arr = jsondata["data"];
//       print(arr);
//
//
//       messages.clear();
//
//
//       for (int i = 0; i < arr.length; i++) {
//         from_id.add(arr[i]['from'].toString());
//         to_id.add(arr[i]['to'].toString());
//         message.add(arr[i]['msg']);
//         date.add(arr[i]['date'].toString());
//         // time.add(arr[i]['date'].toString());
//
//         if (pref.getString("lid").toString() == arr[i]['from'].toString()) {
//           messages.add(ChatMessage(
//               messageContent: arr[i]['msg'], messageType: "sender"));
//         } else {
//           messages.add(ChatMessage(
//               messageContent: arr[i]['msg'], messageType: "receiver"));
//         }
//       }
//
//       // messages.add(ChatMessage(messageContent: "....", messageType: "sender"));
//
//       setState(() {
//
//                 messages = messages;
//       });
//
//       print(status);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         leadingWidth: 0.0,
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.grey.shade300,
//               radius: 20.0,
//               child: IconButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 splashRadius: 1.0,
//                 icon: Icon(
//                   Icons.arrow_back_ios_new,
//                   color: Colors.green,
//                   size: 24.0,
//                 ),
//               ),
//             ),
//             Text(
//               name,
//               style: GoogleFonts.poppins(
//                 color: Colors.green,
//                 fontSize: 22.0,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             SizedBox(
//               width: 40.0,
//             ),
//           ],
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           ListView.builder(
//             itemCount: messages.length,
//             shrinkWrap: true,
//             padding: EdgeInsets.only(top: 10, bottom: 50),
//             physics: ScrollPhysics(),
//             itemBuilder: (context, index) {
//               return Container(
//                 padding:
//                     EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
//                 child: Align(
//                   alignment: (messages[index].messageType == "receiver"
//                       ? Alignment.topLeft
//                       : Alignment.topRight),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: (messages[index].messageType == "receiver"
//                           ? Colors.grey.shade200
//                           : Colors.blue[200]),
//                     ),
//                     padding: EdgeInsets.all(16),
//                     child: Text(
//                       messages[index].messageContent,
//                       style: TextStyle(fontSize: 15),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Container(
//               padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
//               height: 60,
//               width: double.infinity,
//               color: Colors.white,
//               child: Row(
//                 children: <Widget>[
//                   GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       height: 30,
//                       width: 30,
//                       decoration: BoxDecoration(
//                         color: Colors.cyan,
//                         borderRadius: BorderRadius.circular(30),
//                       ),
//                       child: Icon(
//                         Icons.add,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//
//                   Expanded(
//                     child: TextField(
//                       controller: te_message,
//                       decoration: InputDecoration(
//                           hintText: "Write message...",
//                           hintStyle: TextStyle(color: Colors.black54),
//                           border: InputBorder.none),
//                     ),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                   FloatingActionButton(
//                     onPressed: () async {
//                       String fid = "";
//                       String toid = "";
//                       String message = te_message.text.toString();
//
//                       /////
//                       try {
//                         final pref = await SharedPreferences.getInstance();
//                         String ip = pref.getString("url").toString();
//
//                         String url = ip + "/user_sendchat/";
//
//                         var data = await http.post(Uri.parse(url), body: {
//                           'message': message,
//                           'from_id': pref.getString("lid").toString(),
//                           'to_id': pref.getString("tolid").toString()
//                         });
//                         var jsondata = json.decode(data.body);
//                         String status = jsondata['status'];
//
//                         te_message.text = "";
//
//                         var arr = jsondata["data"];
//
//                         setState(() {});
//
//                         print("");
//                       } catch (e) {
//                         print("Error ------------------- " + e.toString());
//                         //there is error during converting file image to base64 encoding.
//                       }
//                     },
//                     child: Icon(
//                       Icons.send,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                     backgroundColor: Colors.cyan,
//                     elevation: 0,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
