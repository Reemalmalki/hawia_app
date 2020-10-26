import 'package:flutter/material.dart';
import 'usingcolors.dart';
import 'electronicComplaintsList.dart';
import 'helpRequestsList.dart';
import 'fieldComplaintsList.dart';
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
  bool isLoggedIn;
  @override

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('الصفحة الرئيسية'),
        backgroundColor: KSUColor,
      ),
      backgroundColor: gray_background,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/KSU_logo.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 35),
          width: double.infinity,
          child: Column(
            children: [
              //  _Text(),
              _padding(),
              _padding(),


              _padding(),
              _padding(),


            ],
          ),
        ),
      ),
    );
  }

  Widget _padding() {
    return Container(
      margin: EdgeInsets.only(top: 50, bottom: 50),
    );
  }


}


