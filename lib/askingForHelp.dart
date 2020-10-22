import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'usingcolors.dart';
import 'questions.dart';

//import 'package:flutter_email_sender/flutter_email_sender.dart';
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
    final appName = 'طلب المساعدة';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
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
  askingForHelp createState() => new askingForHelp();
}

class askingForHelp extends State<MyHomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final noteController = TextEditingController();
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
                Container(
                    child: TextField(
                  controller: nameController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(Icons.person),
                      labelText: "الاسم",
                      hintText: "..."),

                )),

                Container(
                    child: TextField(
                  textAlign: TextAlign.right,
                  controller: emailController,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(Icons.email),
                      labelText: "البريد الالكتروني",
                      hintText: "..."),
                  keyboardType: TextInputType.emailAddress,

                )),

                Container(
                    child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: noteController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(Icons.text_snippet),
                      labelText: "الملاحظات",
                      hintText: "..."),
                )),
                SizedBox(height: 90), //to add space between colmun
                ButtonTheme(
                  //padding: Ed
                  // geInsets.all(-50),
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text("الاسئلة الشائعة"),
                  ),
                ),
                ButtonTheme(
                  //padding: Ed
                  // geInsets.all(-50),
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: _isButtonDisabled ? null : _checker,
                    child: Text("ساعدني"),
                  ),
                ),

              ])),
        )));
  }


  void _helpButtonPressed() async {
    setState(() {
      _isButtonDisabled = true;
    });
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot  doc =  await databaseReference.collection('helpRequests').doc('totalRequest').get();
    int id = doc.get('autoNumber');
    databaseReference.collection('helpRequests').doc('totalRequest').update({'autoNumber': FieldValue.increment(1)});
    DocumentReference ref = await databaseReference.collection("helpRequests")
        .add({
      'name': nameController.text,
      'email': emailController.text,
      'note' :noteController.text,
      'requestId': id,
      'status':'opened',
    });
    print(ref.id);
    Alert(
      context: context,
      title: "تم الإرسال بنجاح",
      desc:  "رقم الطلب :  " +id.toString() ,
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

  void _checker() {
    bool flag = true;
    if (nameController.text.isEmpty) {
      //
      _showMyDialog("غير مكتمل","الرجاء كتابة الأسم بشكل صحيح");
      flag = false;
      return;
    }
    if (!(isValidEmail(emailController.text))) {
      //
      _showMyDialog("غير مكتمل","الرجاء كتابة البريد الإلكتروني بشكل صحيح");
      flag = false;
      return;
    }
    if (noteController.text.isEmpty) {
      //
      _showMyDialog("غير مكتمل","الرجاء كتابةالملاحظات بشكل صحيح");
      flag = false;
      return;
    }

    if (flag) {
      _helpButtonPressed();
    }
  }



  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
  }

  Future<void> _showMyDialog(String title , String body) async {
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
}

*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = 'طلب المساعدة';

    return MaterialApp(
      title: appName,
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
  askingForHelp createState() => new askingForHelp();
}

class askingForHelp extends State<MyHomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final noteController = TextEditingController();
  bool _isButtonDisabled;
  @override
  void initState() {
    _isButtonDisabled = false;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        centerTitle: true,
        title: Text('طلب المساعده'),
        backgroundColor: KSUColor,
      ),
      //backgroundColor: gray_background,
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
                  "الاسم",
                  false,
                  nameController),
              _inputField(
                  Icon(Icons.email_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  "الايميل",
                  false,
                  emailController),
              _padding(),
              _inputField(
                  Icon(Icons.speaker_notes_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  "ملاحظات",
                  false,
                  noteController),
              _QandA(),
              _help(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _padding() {
    return Container(
      margin: EdgeInsets.only(top: 30, bottom: 30),
    );
  }

  Widget _QandA() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(
          color: KSUColor,
          width: 1.5,
        ),
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => qustions1()),
          );
        }, //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "اسئلة شائعة",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: KSUColor,
          ),
        ),
      ),
    );
  }

  Widget _help() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(
          color: KSUColor,
          width: 1.5,
        ),
      ),
      child: FlatButton(
        onPressed: _isButtonDisabled ? null : _checker,
        //qustions1
        //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "ساعدني",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: KSUColor,
          ),
        ),
      ),
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
        margin: EdgeInsets.only(top: 60, bottom: 50),
        child: Text(
          "سنقوم بمساعدتك بأقرب وقت",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: KSUColor,
            letterSpacing: 10,
          ),
        ));
  }

  void _helpButtonPressed() async {
    setState(() {
      _isButtonDisabled = true;
    });
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot doc = await databaseReference
        .collection('helpRequests')
        .doc('totalRequest')
        .get();
    int id = doc.get('autoNumber');
    databaseReference
        .collection('helpRequests')
        .doc('totalRequest')
        .update({'autoNumber': FieldValue.increment(1)});
    DocumentReference ref =
        await databaseReference.collection("helpRequests").add({
      'name': nameController.text,
      'email': emailController.text,
      'note': noteController.text,
      'requestId': id,
      'status': 'opened',
    });
    print(ref.id);
    Alert(
      context: context,
      title: "تم الإرسال بنجاح",
      desc: "رقم الطلب :  " + id.toString(),
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

  void _checker() {
    bool flag = true;
    if (nameController.text.isEmpty) {
      //
      _showMyDialog("غير مكتمل", "الرجاء كتابة الأسم بشكل صحيح");
      flag = false;
      return;
    }
    if (!(isValidEmail(emailController.text))) {
      //
      _showMyDialog("غير مكتمل", "الرجاء كتابة البريد الإلكتروني بشكل صحيح");
      flag = false;
      return;
    }
    if (noteController.text.isEmpty) {
      //
      _showMyDialog("غير مكتمل", "الرجاء كتابةالملاحظات بشكل صحيح");
      flag = false;
      return;
    }

    if (flag) {
      _helpButtonPressed();
    }
  }

  bool isValidEmail(String input) {
    final RegExp regex = new RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return regex.hasMatch(input);
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
}
