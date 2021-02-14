import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'usingcolors.dart';
import 'menue_templates.dart';

Future<void> main() async {
 // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //var userName = sharedPreferences.getString('userName');
 // print(userName.toString());
  runApp(instruction_template());
}

class instruction_template extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'الهوية',
      home: MyHomePage(title: 'الهوية' ),
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
  String userName='';
  @override
 /* void initState() {
    main1();
  }
    Future<void> main1() async  {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userName = sharedPreferences.getString('userName');
    _Text(userName);
    print(userName);
   // runApp(instruction_template());
  }*/
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       
        centerTitle: true,

        title: Text('تعليمات وضع أسماء وحدات الجامعة تحت الشعار '),
        backgroundColor: KSUColor,

      ),
      backgroundColor: Colors.white,

    body: SingleChildScrollView(
    child: Column(
    children: [
  //_Text(userName),
      Container(
    margin: EdgeInsets.only(top: 0, bottom: 290),//290
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/instruction1.jpeg"),
fit: BoxFit.contain

            //fit: BoxFit.fitHeight,
          ),

        ),

        padding: EdgeInsets.symmetric(horizontal: 35),
        width: double.infinity,
        child: next()
        )
        ])
    )
    );
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
            "التالي",
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
  );
  }

  Widget _Text(String userName) {
    return Container(
        margin: EdgeInsets.only(top:10, bottom: 10),//50 ,50
        child: Text(
           userName.split(" ")[0]+' '+'مرحبا ',
          style: TextStyle(
            fontSize: 22,//25
            fontWeight: FontWeight.w800,
            color: KSUColor,
          //  letterSpacing: 10,
          ),
        ));
  }
}

