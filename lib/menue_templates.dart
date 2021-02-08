import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'instruction_template.dart';
import 'main.dart';
import 'usingcolors.dart';
import 'template.dart';
import 'certificationTemplate.dart';
import 'electronicCommunicationTemplate.dart';
import 'PartnersAndAponsorsTemplate.dart';
import 'publicationsTemplate.dart';
import 'SignBoardsTemplate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var userName = sharedPreferences.getString('userName');
  runApp(userName == null ? main1() : MenueTemplates());
}

class MenueTemplates extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

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

  Future<void> logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userName');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => main1()),
    );
  }

  var currentSelectedValue;
  var type;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            tooltip: 'تسجيل الخروج',
            icon: Icon(Icons.logout),
            onPressed: () {
              logOut();
            },
          ),

        ],
        leading: Container(

          child: IconButton(
            icon: Icon(Icons.live_help_outlined),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (c) => instruction_template()),
                      (route) => false);
            },
          ),
          //child: Icon(Icons.arrow_back_ios)
        ),
        centerTitle: true,
        title: Text('أقسام القوالب'),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
              ),
              menue(),
              menue2(),
              menue3(),
              menue4(),
              menue5(),
              menue6(),

            ],
          ),
        ),
      ),
    );
  }

  Widget initPlatformState(){

    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (c) => instruction_template()),
                      (route) => false);
            },
          ),
          //child: Icon(Icons.arrow_back_ios)
        ),
        centerTitle: true,
        title: Text('أقسام القوالب'),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
              ),
              menue(),
              menue2(),
              menue3(),
              menue4(),
              menue5(),
              menue6(),

            ],
          ),
        ),
      ),
    );
  }
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


  Widget menue() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 30.0, top: 0, right: 30.0, bottom: 30.0),
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
            MaterialPageRoute(builder: (context) => template1()),
          );
        }, //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "مايكروسوفت",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }




  Widget menue2() {
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
            MaterialPageRoute(builder: (context) => electronicComuniecationTemplate()),
          );
        }, //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "التواصل الالكتروني",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget menue3() {
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
            MaterialPageRoute(builder: (context) => publicationsTemplate()),
          );
        }, //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "المطبوعات",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Widget menue4() {
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
            MaterialPageRoute(builder: (context) => certificationTemplate()),
          );
        }, //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "التكريم",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
  Widget menue5() {
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
            MaterialPageRoute(builder: (context) => partnersAndAponsorsTemplate()),
          );
        }, //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "الشركاء والرعاة",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget menue6() {
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
            MaterialPageRoute(builder: (context) => signBoardsTemplate()),
          );
        }, //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "اللوحات الارشادية",
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

