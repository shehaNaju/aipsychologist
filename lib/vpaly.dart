import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FileListScreen extends StatefulWidget {
  @override
  _FileListScreenState createState() => _FileListScreenState();
}

class _FileListScreenState extends State<FileListScreen> {
  List<String> fileList = []; // List to store file names

  Future<void> fetchFileList() async {
    var response = await http.get(Uri.parse('YOUR_SERVER_ENDPOINT'));
    if (response.statusCode == 200) {
      setState(() {
        fileList = json.decode(response.body); // Assuming the response is a JSON array of file names
      });
    } else {
      // Handle error
      print('Failed to fetch file list');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFileList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File List'),
      ),
      body: fileList.isEmpty
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: fileList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(fileList[index]),
            onTap: () {
              // Implement code to play the selected file here
              // You can use audioplayers or video_player package to play the file
              // For simplicity, let's assume it's an audio file using audioplayers
              // You need to replace 'fileList[index]' with the actual URL to play the file
              // Example:
              // AudioPlayer player = AudioPlayer();
              // player.play(fileList[index]);
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FileListScreen(),
  ));
}
