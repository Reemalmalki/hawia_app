import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//import 'package:flutter_email_sender/flutter_email_sender.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = 'البلاغ الميداني';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
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
  viewFieldComplaintsInfo createState() => new viewFieldComplaintsInfo();
}

class viewFieldComplaintsInfo extends State<MyHomePage> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final buildController = TextEditingController();
  final placeController = TextEditingController();
  final floorController = TextEditingController();

  bool _isButtonDisabled;
  @override
  void initState() {
    _isButtonDisabled = false;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Center(child: Text(widget.title)),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(30),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(children: <Widget>[
                Container(
                    child: TextField(
                  controller: numberController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(
                        Icons.keyboard_return_sharp,
                        color: Colors.blue,
                      ),
                      labelText: " رقم الطلب :" ,
                      labelStyle: TextStyle(color: Colors.black)),
                  enabled: false,
                )),
                Container(
                    child: TextField(
                  textAlign: TextAlign.right,
                  controller: nameController,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      labelText: " الاسم :",
                      labelStyle: TextStyle(color: Colors.black)),
                  enabled: false,
                )),
                Container(
                  child: TextField(
                    textAlign: TextAlign.right,
                    controller: emailController,
                    autofocus: true,
                    decoration: new InputDecoration(
                        // border: OutlineInputBorder(),
                        icon: const Icon(
                          Icons.email,
                          color: Colors.blue,
                        ),
                        labelText: " البريد الالكتروني :",
                        labelStyle: TextStyle(color: Colors.black)),
                    enabled: false,
                  ),
                ),

                Container(
                    child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: placeController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(
                        Icons.place,
                        color: Colors.blue,
                      ),
                      labelText: " المكان :" ,
                      labelStyle: TextStyle(color: Colors.black)),
                  enabled: false,
                )),
                Container(
                    child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: buildController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(
                        Icons.place,
                        color: Colors.blue,
                      ),
                      labelText: " المبنى :",
                      labelStyle: TextStyle(color: Colors.black)),
                  enabled: false,
                )),
                Container(
                    child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: buildController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(
                        Icons.stairs,
                        color: Colors.blue,
                      ),
                      labelText: " الدور :" ,
                      labelStyle: TextStyle(color: Colors.black)),
                  enabled: false,
                )),
                SizedBox(height: 90), //to add space between colmun
                ButtonTheme(
                  //padding: Ed
                  // geInsets.all(-50),
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: _isButtonDisabled ? null : _closedComplaint,
                    child: Text(
                      "اغلاق البلاغ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ])),
        )));
  }

  void _getData() async {

    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot doc = await databaseReference
        .collection('fieldsComplaints')
        .doc('7m4B7EYl3dy4H8kFR8Wz')
        .get();
    numberController.text = doc.get('requestId').toString();
    nameController.text = doc.get('name');
    emailController.text = doc.get('email');
    buildController.text = doc.get('building');
    floorController.text = doc.get('floor');
    placeController.text = doc.get('place');
  }

  void _closedComplaint() async {
    setState(() {
      _isButtonDisabled = true;
    });
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    databaseReference
        .collection('fieldsComplaints')
        .doc('7m4B7EYl3dy4H8kFR8Wz')
        .update({'status': "closed"});

    Alert(
      context: context,
      title: "تم اغلاق الطلب بنجاح",
      desc: "رقم الطلب :  " + numberController.text,
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
