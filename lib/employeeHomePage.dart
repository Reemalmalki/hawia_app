import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'usingcolors.dart';
import 'electronicComplaintsList.dart';
import 'helpRequestsList.dart';
import 'fieldComplaintsList.dart';
import 'main.dart';
Future<void> main() async {
  runApp(employeeHomePage());
}

class employeeHomePage extends StatelessWidget {
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
  /*void initState()  {
   Firebase.initializeApp();
    FirebaseAuth.instance.currentUser != null
        ? setState(() {
      isLoggedIn = true;
    })
        : setState(() {
      isLoggedIn = false;
    });
    print("isLoggedIn");
    print(isLoggedIn);
    super.initState()
    // new Future.delayed(const Duration(seconds: 2));
  }

  Widget _moveToLogin() {
  Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => helpRequestList1()));
}*/

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
              _electronicComplaintsListBtn(),
              _padding(),

              _fieldComplaintsListBtn(),

              _padding(),
              _helpRequestsListBtn(),
              _padding(),

              _appRaitingBtn(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _padding() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 25),
    );
  }

  Widget _helpRequestsListBtn() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: KSUColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
            "طلبات المساعدة",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => helpRequestList1()),
          );
        },
      ),
    );
  }

  Widget _electronicComplaintsListBtn() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: KSUColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
            "البلاغات الإلكترونية",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => electronicComplaintsList1()),
            );
            },
      ),
    );
  }

  Widget _fieldComplaintsListBtn() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: KSUColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
          "البلاغات الميدانية",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => fieldComplaintsList1()),
          );
        },
      ),
    );
  }

  Widget _appRaitingBtn() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: KSUColor,
          borderRadius: BorderRadius.all(Radius.circular(30)),
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
          "تقييم التطبيق",
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


