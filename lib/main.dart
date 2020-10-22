import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

/*
Future<void> main() async {runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الهوية',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

   void _signIn() async{
    WidgetsFlutterBinding.ensureInitialized();
    try {
      print(emailController.text);
      print(passController.text);
      await Firebase.initializeApp();
      User user = (await FirebaseAuth.instance.
      signInWithEmailAndPassword(email: emailController.text , password: passController.text))
          .user;
      print(user.uid);
    } catch (e) {
      print('البريد الإلكتروني او كلمة المرور غير صحيحة، حاول مرة اخرى');
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'ادخل البريد الإلكتروني',
                      labelText: 'البريد الإلكتروني',
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),

                  new TextFormField(
                    controller: passController,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.lock),
                      hintText: 'ادخل  كلمة المرور',
                      labelText: ' كلمة المرور',
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                      if (value.isEmpty) {
                        return 'الرجاء ادخال كلمة المرور';
                      }else{
                       // _pass = passController.text;
                        print(passController.text);
                      }
                      return null;
                    },
                  ),
                  new Container(
                      padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                      child: new ElevatedButton(
                        child: const Text('تسجيل الدخول'),
                        onPressed: _signIn

                      )),
                ],
              ))),
    );
  }


  }
*/

import 'package:flutter/material.dart';
import 'usingcolors.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool error = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  void _signIn() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      print(emailController.text);
      print(passController.text);
      await Firebase.initializeApp();
      User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text, password: passController.text))
          .user;
      print(user.uid);
    } catch (e) {
      print('البريد الإلكتروني او كلمة المرور غير صحيحة، حاول مرة اخرى');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        centerTitle: true,
        title: Text('Sign in'),
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
                  Icon(Icons.email_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  "Email*",
                  false,
                  emailController),
              _inputField(
                  Icon(Icons.lock_outline, size: 20, color: Color(0xffA6B0BD)),
                  "Password*",
                  true,
                  passController),
              _padding(),
              _loginBtn(),
              _OR(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _padding() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
    );
  }

  Widget _OR() {
    return Text(
      'or',
      style: TextStyle(
        color: Color(0xffA6B0BD),
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
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
          onPressed: _signIn),
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
}
