import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = 'طلبات المساعدة';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: MyHomePage(
        title: appName,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  viewHelpRequestInfo createState() => new viewHelpRequestInfo();
}

class viewHelpRequestInfo extends State<MyHomePage> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final noteController = TextEditingController();
  bool _isButtonDisabled;
  @override
  void initState() {
    _isButtonDisabled = false;
    _getData();
  }

  @override
  void sendto() async{
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    databaseReference
        .collection('helpRequests')
        .doc('xni9LTnYsP4niHapetxb')
        .update({'status': "closed"});

    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: emailController.text,
        queryParameters: {'subject': 'فريق هوية التابع لجامعة الملك سعود'});

    launch(_emailLaunchUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Center(child: Text(widget.title)),
        ),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(30),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(children: <Widget>[
                Container(
                    child: TextField(
                  controller: numberController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(
                        Icons.keyboard_return_sharp,
                        color: Colors.blue,
                      ),
                      labelText: " رقم الطلب :" ,
                      labelStyle: TextStyle(color: Colors.black)),
                  enabled: false,
                )),
                Container(
                    child: TextField(
                  textAlign: TextAlign.right,
                  controller: nameController,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      labelText: " الاسم :" ,
                      labelStyle: TextStyle(color: Colors.black)),
                  enabled: false,
                )),
                Container(
                  child: TextField(
                    textAlign: TextAlign.right,
                    controller: emailController,
                    autofocus: true,
                    decoration: new InputDecoration(
                        // border: OutlineInputBorder(),
                        icon: const Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        labelText: " البريد الالكتروني :" ,
                        labelStyle: TextStyle(color: Colors.black)),
                    enabled: false,
                  ),
                ),

                Container(
                    child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: noteController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(
                        Icons.text_snippet,
                        color: Colors.blue,
                      ),
                      labelText: " الملاحظات :" ,
                      labelStyle: TextStyle(color: Colors.black)),
                  enabled: false,
                )),
                SizedBox(height: 90), //to add space between colmun
                ButtonTheme(
                  //padding: Ed
                  // geInsets.all(-50),
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: sendto,
                    child: Text(
                      "الرد عن طريق الايميل",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ])),
        )));
  }

  void _getData() async {

    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot doc = await databaseReference
        .collection('helpRequests')
        .doc('HHchhDrbBKLKGyxzajDR')
        .get();
    numberController.text = doc.get('requestId').toString();
    nameController.text = doc.get('name');
    emailController.text = doc.get('email');
    noteController.text = doc.get('note');

  }

}
