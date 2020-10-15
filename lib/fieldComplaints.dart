import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
    final appName = 'رفع البلاغ';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        // Define the default brightness and colors.
        //  brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
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
  fieldComplaints createState() => new fieldComplaints();
}

class fieldComplaints extends State<MyHomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final buildController = TextEditingController();
  final floorController = TextEditingController();

  var currentSelectedValue;
  final deviceTypes = [
    "المدينة الجامعية للطالبات الدرعية",
    "المدينة الجامعية للطالبات عليشة",
    "المدينة الجامعية للطلاب",
    "مستشفى الملك خالد الجامعي"
  ];
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
                Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Hind'),
                    //   TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                    text: 'البلاغات الميدانية ', // default text style
                  ),
                ),
                SizedBox(height: 20), //to add space between colmun

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
                SizedBox(height: 20), //to add space between colmun
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                        textAlign: TextAlign.right,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            hint: Text("الرجاء اختيار المكان"),
                            value: currentSelectedValue,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                currentSelectedValue = newValue;
                              });
                              print(currentSelectedValue);
                            },
                            items: deviceTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                    child: TextField(
                  controller: buildController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(Icons.place),
                      labelText: "المبنى",
                      hintText: "..."),
                )),
                Container(
                    child: TextField(
                  controller: floorController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(Icons.stairs),
                      labelText: "الدور",
                      hintText: "..."),
                )),
                SizedBox(height: 90), //to add space between colmun

                ButtonTheme(
                  //padding: Ed
                  // geInsets.all(-50),
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: _checker,
                    child: Text("رفع البلاغ"),
                  ),
                ),
              ])),
        )));
  }

  void _helpButtonPressed() async {
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
      'note': buildController.text,
      'requestId': id,
      'response': ''
    });
    print(ref.id);
  }

  void _checker() {
    bool flag = true;
    if (nameController.text.isEmpty) {
      //
      print(nameController.text);
      flag = false;
    }
    if (!(isValidEmail(emailController.text))) {
      //
      print(emailController.text);
      flag = false;
    }
    if (buildController.text.isEmpty) {
      //
      print(buildController.text);
      flag = false;
    }
    if (floorController.text.isEmpty) {
      //
      print(buildController.text);
      flag = false;
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
}
