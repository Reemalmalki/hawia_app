import 'dart:async';
import 'package:flutter/material.dart';
import 'usingcolors.dart';
import 'menue_templates.dart';

Future<void> main() async {
  runApp(instruction_template());
}

class instruction_template extends StatelessWidget {
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
  var currentSelectedValue;
  var type;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (c) => MenueTemplates()),
                      (route) => false);
            },
          ),
          //child: Icon(Icons.arrow_back_ios)
        ),
        centerTitle: true,

        title: Text('التعليمات '),
        backgroundColor: KSUColor,
      ),
      backgroundColor: Colors.white,

    body: SingleChildScrollView(
    child: Container(
    margin: EdgeInsets.only(top: 10, bottom: 290),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/Instruction.jpeg"),
fit: BoxFit.contain

            //fit: BoxFit.fitHeight,
          ),

        ),

        padding: EdgeInsets.symmetric(horizontal: 35),
        width: double.infinity,
        child:Expanded(
        child: Column(
          children: [
            next()
          ],
        ),
        )
    )));
  }
  Widget next() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 340, bottom: 10),
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
        // onPressed: _signIn,
        //padding: EdgeInsets.symmetric(vertical: 25),
          child: Text(
            "حسناً",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          onPressed: goToTemplates

    ));
  }
  void goToTemplates(){
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => MenueTemplates()),
  );}

}

