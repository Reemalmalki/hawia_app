import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'instruction_template.dart';
import 'menue_templates.dart';
import 'usingcolors.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var userName = sharedPreferences.getString('userName');
  runApp(userName == null ? main1() : MenueTemplates());
}

class main1 extends StatelessWidget {
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
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passController = TextEditingController();
  bool error = false;
  bool _loading ;
  @override
  void initState() {
    _loading = false;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    userNameController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _signIn() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      print(userNameController.text);
      print(passController.text);
      await Firebase.initializeApp();
      User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userNameController.text, password: passController.text))
          .user;
      print(user.uid);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => instruction_template()),
      );
    } catch (e) {
      _showMyDialog("البريد الالكتروني او كلمة المرور غير صحيحة ، حاول مرة اخرى", "");
      print('البريد الإلكتروني او كلمة المرور غير صحيحة، حاول مرة اخرى');
    }
  }

  void _signInWithAPI(String userId ,String password) async {
    WidgetsFlutterBinding.ensureInitialized();
    Map data ={
      'UserName':userId,
      'Password':password,
      'ConsumerApplication':'Hawia'
    };
    var jsonData = null;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var URL = 'https://ksuintegration.ksu.edu.sa/SSOStaff/EmployeeAuthentication';
    var headers = { 'Content-type': 'application/json',
      'Accept': 'application/json'};

    var response = await http.post(URL,
        body: jsonEncode(data) , headers: headers );
    if(response.statusCode == 200){
      jsonData = json.decode(response.body);
      if(jsonData['ActionStatus']==true){
      print(response.body);
      setState(() {
        _loading = false;
        sharedPreferences.setString('userName', jsonData['Name']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => instruction_template()),
        );
      });
      }else{
        print(response.body);
        _showMyDialog("البريد الالكتروني او كلمة المرور غير صحيحة ، حاول مرة اخرى", "");

      }
    }
    else {
      _showMyDialog("البريد الالكتروني او كلمة المرور غير صحيحة ، حاول مرة اخرى", "");
    }
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text('  '),
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
              _Text(),
              _inputField(
                  Icon(Icons.account_circle_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  "اسم المستخدم ",
                  false,
                  userNameController),
              _inputField(
                  Icon(Icons.lock_outline, size: 20, color: Color(0xffA6B0BD)),
                  "كلمة المرور",
                  true,
                  passController),
              _padding(),
              _loading? Center(child: CupertinoActivityIndicator()):Center(),
              _padding(),
              _loginBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _padding() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 15),
    );
  }

  Widget _loginBtn() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, bottom: 20),
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
            "دخـول",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          onPressed:()=> {
            setState(() {
              _loading = true;
            }),
            //_signIn()
            _signInWithAPI(userNameController.text,passController.text),
          }),
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
      margin: EdgeInsets.only(bottom: 20),
      child: TextField(
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
        margin: EdgeInsets.only(top: 50, bottom: 90),
        child: Text(
          "تسجيل الدخول",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: KSUColor,
            letterSpacing: 10,
          ),
        ));
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => main1()),
            );
          },
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
      ],
    ).show();
  }
}

