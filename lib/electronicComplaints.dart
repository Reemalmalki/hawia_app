import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rating_dialog/rating_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    final appName = 'رفع بلاغ';

    return MaterialApp(
      title: appName,
      theme: ThemeData(
        // Define the default brightness and colors.
        //  brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
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
  electronicComplaints createState() => new electronicComplaints();
}

class electronicComplaints extends State<MyHomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final linkController = TextEditingController();
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
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(30),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(children: <Widget>[
                Text.rich(
                  TextSpan(
                    style: TextStyle(fontSize: 17.0, fontFamily: 'Hind'),
                    text: 'البلاغات الالكترونية ', // default text style
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

                Container(
                    child: TextField(
                  controller: linkController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(Icons.link),
                      labelText: "الرابط",
                      hintText: "..."),
                )),
                SizedBox(height: 90), //to add space between colmun
                ButtonTheme(
                  //padding: Ed
                  // geInsets.all(-50),
                  minWidth: 200.0,
                  height: 40.0,
                  child: RaisedButton(
                    onPressed: _isButtonDisabled ? null : _checker,
                    child: Text("رفع البلاغ"),
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
    DocumentSnapshot doc = await databaseReference
        .collection('electronicComplaints')
        .doc('totalElectronicComplaints')
        .get();
    int id = doc.get('autoNumber');
    databaseReference
        .collection('electronicComplaints')
        .doc('totalElectronicComplaints')
        .update({'autoNumber': FieldValue.increment(1)});
    DocumentReference ref =
        await databaseReference.collection("electronicComplaints").add({
      'name': nameController.text,
      'email': emailController.text,
      'link': linkController.text,
      'requestId': id,
          'status':'opened',
    });
    print(ref.id);

    _showRatingDialog();

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
    if (linkController.text.isEmpty) {
      //
      _showMyDialog("غير مكتمل","الرجاء كتابة الرابط بشكل صحيح");
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

  void _showRatingDialog() {
    // We use the built in showDialog function to show our Rating Dialog
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon:  Icon(
              Icons.favorite,
              color: Colors.lightBlue,
              size: 24.0,
            ), // set your own image/icon widget
            title:"تم إرسال البلاغ بنجاح",
            description:
            "كيق كانت تجربة رفع البلاغ؟",
            submitButton: "تأكيد",
            positiveComment:  "شكراً لتقييمك ، سعيدون بخدمتك دائماً :)", // optional
            negativeComment: " :( شكراً لتقييمك ، سنعمل على تحسين التجربة", // optional
            accentColor: Colors.lightBlue, // optional
            onSubmitPressed: (int rating) {
              print(rating);
              _saveRating(rating);
            },          );
        });
  }
void _saveRating(int rating) async{
  await Firebase.initializeApp();
  final databaseReference = FirebaseFirestore.instance;
  var ref = databaseReference
      .collection('electronicComplaints')
      .doc('ratings');
      ref.update({'total': FieldValue.increment(1)});

    switch(rating){
      case 1:
      case 2: ref.update({'low': FieldValue.increment(1)}); break;
      case 3: ref.update({'medium': FieldValue.increment(1)});  break;
      case 4:
      case 5 :ref.update({'high': FieldValue.increment(1)});   break;
    }
}

}

