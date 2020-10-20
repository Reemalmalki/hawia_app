import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//import 'package:flutter_email_sender/flutter_email_sender.dart';

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

