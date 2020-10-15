import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';


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

