import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController ipcontroller=new TextEditingController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    ipunique();


}

  void ipunique() async{
    SharedPreferences s=await SharedPreferences.getInstance();
    ipcontroller.text=s.getString('ip').toString();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(


        child: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.all(10),
                child: TextField(
                  controller: ipcontroller ,
                  decoration: InputDecoration(border: OutlineInputBorder(),labelText: 'ip address'),
                ),
              ),
              ElevatedButton(onPressed: ()async{

                String ip= ipcontroller.text.toString();



                //stable ip address settings second
                print(ip);
                SharedPreferences sh=await SharedPreferences.getInstance();

                //stable ip address settings first
                sh.setString('ip', ip);
                sh.setString('url', 'http://$ip:9000/myapp');
                sh.setString('imgurl', 'http://$ip:9000');
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginNewPage()));

              }, child: Text('Apply'))


            ],
          ),
        ),
      ),
    );
  }
}
