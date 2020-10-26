import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'usingcolors.dart';
import 'homePage.dart';

/*
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
            "كيف كانت تجربة رفع البلاغ؟",
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

}*/
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = 'رفع بلاغ';

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
      appBar: AppBar(
        centerTitle: true,
        title: Text('رفع البلاغ'),
        backgroundColor: KSUColor,
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homePage()),
              );
            },
          ),
          //child: Icon(Icons.arrow_back_ios)
        ),
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
              _inputField(Icon(Icons.link, size: 20, color: Color(0xffA6B0BD)),
                  "الرابط", false, linkController),
              _rebort(),
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

  Widget _rebort() {
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
        onPressed: _isButtonDisabled ? null : _checker,
        //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "رفع البلاغ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: KSUColor,
            //Color(0xffA6B0BD)
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
        margin: EdgeInsets.only(top: 50, bottom: 30),
        child: Text(
          "البلاغات الإلكترونية",
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
      'status': 'opened',
    });
    print(ref.id);

    _showRatingDialog();
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
    if (linkController.text.isEmpty) {
      //
      _showMyDialog("غير مكتمل", "الرجاء كتابة الرابط بشكل صحيح");
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

  void _showRatingDialog() {
    // We use the built in showDialog function to show our Rating Dialog
    showDialog(
        context: context,
        barrierDismissible: true, // set to false if you want to force a rating
        builder: (context) {
          return RatingDialog(
            icon: Icon(
              Icons.favorite,
              color: Colors.lightBlue,
              size: 24.0,
            ), // set your own image/icon widget
            title: "تم إرسال البلاغ بنجاح",
            description: "كيف كانت تجربة رفع البلاغ؟",
            submitButton: "تأكيد",
            positiveComment:
                "شكراً لتقييمك ، سعيدون بخدمتك دائماً :)", // optional
            negativeComment:
                " :( شكراً لتقييمك ، سنعمل على تحسين التجربة", // optional
            accentColor: Colors.lightBlue, // optional
            onSubmitPressed: (int rating) {
              print(rating);
              _saveRating(rating);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => homePage()),
              );
            },
          );
        });
  }

  void _saveRating(int rating) async {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    var ref =
        databaseReference.collection('electronicComplaints').doc('ratings');
    ref.update({'total': FieldValue.increment(1)});

    switch (rating) {
      case 1:
      case 2:
        ref.update({'low': FieldValue.increment(1)});
        break;
      case 3:
        ref.update({'medium': FieldValue.increment(1)});
        break;
      case 4:
      case 5:
        ref.update({'high': FieldValue.increment(1)});
        break;
    }
  }
}
