//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:rflutter_alert/rflutter_alert.dart';
//import 'package:url_launcher/url_launcher.dart';
/*
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  /* Widget build(BuildContext context) {
    return new MaterialApp(
      // title: 'Flutter Form Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: ' طلب المساعدة '),
    );
  }
}*/

  Widget build(BuildContext context) {
    final appName = 'رفع بلاغ';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        // Define the default brightness and colors.
        //  brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
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
  electronicComplaints createState() => new electronicComplaints();
}

class electronicComplaints extends State<MyHomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final linkController = TextEditingController();
  bool _isButtonDisabled;
  @override
  void initState() {
    _isButtonDisabled = false;
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
                SizedBox(height: 40), //to add space between colmun
                Container(
                    width: 290,
                    // width: 210,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        onPressed: _isButtonDisabled ? null : _checker,
                        textColor: Colors.white,
                        color: Colors.blue,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  /* child: Text(
                                    'التحميل',
                                    style: TextStyle(color: Colors.white),
                                  ),*/
                                  child: new Align(
                                      alignment: Alignment.center,
                                      child: Text("التحميل")),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(4, 0, 10, 0),
                                  child: Icon(
                                    Icons.arrow_circle_down,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            )))),
                SizedBox(height: 40), //to add space between colmun
                //
                Container(
                    width: 290,
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        onPressed:
                            _launchURL, //_isButtonDisabled ? null : _checker,
                        textColor: Colors.white,
                        color: Colors.blue,
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  color: Colors.blue,
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  /* child: Text(
                                    'التحميل',
                                    style: TextStyle(color: Colors.white),
                                  ),*/
                                  child: new Align(
                                      alignment: Alignment.center,
                                      child: Text("رابط الدليل الارشادي")),
                                ),
                              ],
                            )))),
              ])),
        )));
  }

  void _checker() {
    _showMyDialog("الرجاء اختيار القالب ", " ");
  }

  Future<void> _showMyDialog(String title, String body) async {
    Alert(
      context: context,
      title: title,
      desc: body,
      buttons: [
        DialogButton(
          child: Text(
            "Word",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context), // هنا وين يروح بعدها ؟
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
        DialogButton(
          child: Text(
            "PowerPoint",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context), // هنا وين يروح بعدها ؟
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
      ],
    ).show();
  }

  _launchURL() async {
    const url = 'https://identity.ksu.edu.sa/ar';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
*/
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'template_date.dart';
import 'usingcolors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // title: 'Flutter Form Demo',
      home: template(
        title: "القوالب",
      ),
    );
  }
}

class template extends StatefulWidget {
  template({Key key, this.title}) : super(key: key);
  final String title;
  @override
  templateState createState() => templateState();
}

class templateState extends State<template> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios_outlined),
        centerTitle: true,
        title: Text('قوالب'),
        backgroundColor: KSUColor,
      ),
      backgroundColor: gray_background,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/KSU_logo_large.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
              ),
              Container(
                height: 400,
                padding: const EdgeInsets.only(left: 32),
                child: Swiper(
                  itemCount: templates.length,
                  itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeSize: 13,
                      space: 3,
                      activeColor: KSUColor,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 40),
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 90),
                                    Text(
                                      templates[index].name,
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: bluegray_text,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      templates[index].description,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: bodycolor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          'المزيد للتحميل ',
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: linkColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Icon(Icons.arrow_forward,
                                            color: linkColor),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          templates[index].iconImage,
                          height: 200,
                          width: 100,
                        ),
                      ],
                    );
                  },
                ),
              ),
              _Download(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Download() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 30.0, top: 5.0, right: 30.0, bottom: 30.0),
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
        onPressed: _launchURL,
        //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "رابط الدليل الإرشادي",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://identity.ksu.edu.sa/ar';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
