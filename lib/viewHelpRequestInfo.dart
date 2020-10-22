import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'usingcolors.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';

//void main() => runApp(MyApp());
/*
class viewHelpRequestInfo1 extends StatelessWidget {
  viewHelpRequestInfo1({@required this.docId});
  final docId ;
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
          docId : docId,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title , this.docId}) : super(key: key);
  final String title;
  final docId;
  @override
  viewHelpRequestInfo createState() => new viewHelpRequestInfo(docId:docId);
}

class viewHelpRequestInfo extends State<MyHomePage> {
  viewHelpRequestInfo({@required this.docId});
  final docId ;
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
        .doc(docId.toString())
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
        .doc(docId.toString())
        .get();
    numberController.text = doc.get('requestId').toString();
    nameController.text = doc.get('name');
    emailController.text = doc.get('email');
    noteController.text = doc.get('note');

  }

}
*/
class viewHelpRequestInfo1 extends StatelessWidget {
  viewHelpRequestInfo1({@required this.docId});
  final docId;
  @override
  Widget build(BuildContext context) {
    final appName = 'طلبات المساعدة';

    return MaterialApp(
      title: appName,
      home: MyHomePage(
        title: appName,
        docId: docId,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.docId}) : super(key: key);
  final String title;
  final docId;
  @override
  viewHelpRequestInfo createState() => new viewHelpRequestInfo(docId: docId);
}

class viewHelpRequestInfo extends State<MyHomePage>
    with TickerProviderStateMixin {
  TabController tabController;
  viewHelpRequestInfo({@required this.docId});

  final docId;

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
  void sendto() async {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    databaseReference
        .collection('helpRequests')
        .doc(docId.toString())
        .update({'status': "closed"});

    final Uri _emailLaunchUri = Uri(
        scheme: 'mailto',
        path: emailController.text,
        queryParameters: {'subject': 'فريق هوية التابع لجامعة الملك سعود'});

    launch(_emailLaunchUri.toString());
  }

  Widget build(BuildContext context) {
    tabController = new TabController(length: 2, vsync: this);

    var tabBarItem = new TabBar(
      tabs: [
        new Tab(
          icon: new Text("قبل"),
        ),
        new Tab(
          icon: new Text("بعد"),
        ),
      ],
      controller: tabController,
      indicatorColor: Colors.white,
    );

    var _Befor = new ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/KSU_logo_large.png"),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          margin: new EdgeInsets.only(
              left: 30.0, top: 60.0, right: 30.0, bottom: 20.0),
          child: Column(
            children: [
              _inputField(
                  Icon(Icons.confirmation_number_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  "رقم الطلب",
                  false,
                  numberController),
              _inputField(
                  Icon(Icons.person, size: 20, color: Color(0xffA6B0BD)),
                  "الاسم",
                  false,
                  nameController),
              _inputField(Icon(Icons.email, size: 20, color: Color(0xffA6B0BD)),
                  "البريد الالكتروني", false, emailController),
              _inputField(
                  Icon(Icons.speaker_notes_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  " ملاحظات الطلب",
                  false,
                  noteController),
              _help(),
            ],
          ),
        );
      },
    );

    var _After = new ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, int index) {
        return new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/KSU_logo_large.png"),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          margin: new EdgeInsets.only(
              left: 30.0, top: 60.0, right: 30.0, bottom: 20.0),
          child: Column(
            children: [
              _inputField(
                  Icon(Icons.confirmation_number_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  "رقم الطلب",
                  false,
                  numberController),
              _inputField(
                  Icon(Icons.person, size: 20, color: Color(0xffA6B0BD)),
                  "الاسم",
                  false,
                  nameController),
              _inputField(Icon(Icons.email, size: 20, color: Color(0xffA6B0BD)),
                  "البريد الالكتروني", false, emailController),
              _inputField(
                  Icon(Icons.speaker_notes_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  " ملاحظات الطلب",
                  false,
                  noteController),
              _help(),
            ],
          ),
        );
      },
    );

    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back_ios),
          centerTitle: true,
          title: Text('طلبات المساعده'),
          backgroundColor: KSUColor,
          bottom: tabBarItem,
        ),
        backgroundColor: gray_background,
        body: new TabBarView(
          controller: tabController,
          children: [
            _Befor,
            _After,
          ],
        ),
      ),
    );
  }

  Widget _help() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
          color: KSUColor,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFb2bdc3),
              blurRadius: 10,
              offset: Offset(0, 5),
              spreadRadius: 0,
            ),
          ]),
      child: FlatButton(
        onPressed: sendto,
        //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "رد عن طريق الايميل",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _inputField(
      Icon prefixIcon, String hintText, bool isPassword, controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 25,
            offset: Offset(0, 5),
            spreadRadius: -25,
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: TextField(
        enabled: false,
        controller: controller,
        obscureText: isPassword,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Color(0xff000912),
        ),
        decoration: InputDecoration(
          //contentPadding: EdgeInsets.symmetric(vertical: 25),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xffA6B0BD),
          ),
          fillColor: Colors.white,
          filled: true,
          prefixIcon: prefixIcon,
          prefixIconConstraints: BoxConstraints(
            minWidth: 75,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(50),
            ),
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _Text() {
    return Container(
        margin: EdgeInsets.only(top: 50, bottom: 50),
        child: Text(
          "سنقوم بمساعدتك بأقرب وقت",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: KSUColor,
            letterSpacing: 10,
          ),
        ));
  }

  void _getData() async {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot doc = await databaseReference
        .collection('helpRequests')
        .doc(docId.toString())
        .get();
    numberController.text = doc.get('requestId').toString();
    nameController.text = doc.get('name');
    emailController.text = doc.get('email');
    noteController.text = doc.get('note');
  }
}
