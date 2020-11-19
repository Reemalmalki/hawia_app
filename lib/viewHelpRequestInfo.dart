import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'usingcolors.dart';
import 'package:flutter/cupertino.dart';
import 'helpRequestsList.dart';

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
    return new Scaffold(
        appBar: new AppBar(
          title: Center(child: new Text(widget.title)),
          backgroundColor: KSUColor,
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => helpRequestList1()),
                );
              },
            ),
            //child: Icon(Icons.arrow_back_ios)
          ),
        ),
        body: new SafeArea(
            child: Container(
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
        )));
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
