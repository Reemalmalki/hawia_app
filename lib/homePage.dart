import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'instruction_template.dart';
import 'usingcolors.dart';
import 'package:flutter/services.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'visiontextwidget.dart';
import 'main.dart';



import 'menue_templates.dart';

Future<void> main() async {
  runApp(homePage());
}

class homePage extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الهوية',
      home: MyHomePage(title: 'الهوية'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentSelectedValue;
  var type;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            tooltip: 'تسجيل الدخول',
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => main1()),
              );
            },
          ),
        ],
        title: Text(' الصفحة الرئيسية'),
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
                padding: const EdgeInsets.all(120.0),
              ),
              btn(),
              _Download(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMyDialog(String title, String body) async {

    Alert(
      context: context,
      title: title,
      desc: body,
      buttons: [
        DialogButton(
          child: Text(
            "حسناً",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context), // هنا وين يروح بعدها ؟
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
      ],
    ).show();
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
        onPressed: () {
        Navigator.push(
            context,
           MaterialPageRoute(builder: (context) => instruction_template()),
       );
        }, //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "القوالب",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Future<void> initPlatformState() async {
    String imagePath;
    try {
      imagePath = await EdgeDetection.detectEdge;
      Navigator.pop(context);
      await Navigator.of(context).push(PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) =>
              VisionTextWidget(imagePath: imagePath)));
      /*await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VisionTextWidget(imagePath: imagePath)),
      );*/
    } on PlatformException {
      imagePath = 'Failed to get cropped image path.';
    }
    if (!mounted) return;
  }
  /*Widget _BTN(String title) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: new InkWell(
        onTap: () {
      Alert(
        context: context,
        title: 'التعليمات',
        desc: 'وجه الكاميرا الى الشعار',
        buttons: [
          DialogButton(
            child: Text(
              'حسناً',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: initPlatformState,
            color: Colors.lightBlue[800],
            radius: BorderRadius.circular(0.5),
          ),
        ],
      ).show();
    },
        child: Container(
          width: 600,
          height: 80.0,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF008FC4),
                letterSpacing: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }*/
  Widget btn() {
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
        onPressed: () {
          Alert(
            context: context,
            title: 'التعليمات',
            desc: 'وجه الكاميرا الى الشعار',
            image: Image.asset("assets/Instruction.jpeg" ,height: 300,    width: 300,  ),

            buttons: [
              DialogButton(
                child: Text(
                  'حسناً',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: initPlatformState,
                color: Colors.lightBlue[800],
                radius: BorderRadius.circular(0.5),
              ),
            ],
          ).show();
        }, //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          'تحقق من صحة الشعار',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

