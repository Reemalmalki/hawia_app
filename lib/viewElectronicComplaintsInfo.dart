import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'usingcolors.dart';
import 'electronicComplaintsList.dart';
//import 'package:flutter_email_sender/flutter_email_sender.dart';

//void main() => runApp(MyApp());
/*
class viewElectronicComplaintsInfo1 extends StatelessWidget {
  viewElectronicComplaintsInfo1({@required this.docId});
  final docId ;
  @override
  Widget build(BuildContext context) {
    final appName = 'البلاغ الالكتروني';

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
        docId: docId,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({@required this.docId ,this.title });
  final docId ;
  final String title;
  @override
  viewElectronicComplaintsInfo createState() =>
      new viewElectronicComplaintsInfo(docId: docId);
}

class viewElectronicComplaintsInfo extends State<MyHomePage> {
  viewElectronicComplaintsInfo({@required this.docId});
  final docId ;
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final linkController = TextEditingController();

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
                      labelText: " الاسم :" ,
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
                        labelText: " البريد الالكتروني :" ,
                        labelStyle: TextStyle(color: Colors.black)),
                    enabled: false,
                  ),
                ),

                Container(
                    child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 2,
                  controller: linkController,
                  textAlign: TextAlign.right,
                  autofocus: true,
                  decoration: new InputDecoration(
                      // border: OutlineInputBorder(),
                      icon: const Icon(
                        Icons.link,
                        color: Colors.blue,
                      ),
                      labelText: " الرابط :" ,
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
        .collection('electronicComplaints')
        .doc(docId.toString())
        .get();
    numberController.text = doc.get('requestId').toString();
    nameController.text = doc.get('name');
    emailController.text = doc.get('email');
    linkController.text = doc.get('link');

  }

  void _closedComplaint() async {
    setState(() {
      _isButtonDisabled = true;
    });
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    databaseReference
        .collection('electronicComplaints')
        .doc(docId.toString())
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
*/

class viewElectronicComplaintsInfo1 extends StatelessWidget {
  viewElectronicComplaintsInfo1({@required this.docId});
  final docId;
  @override
  Widget build(BuildContext context) {
    final appName = 'البلاغ الالكتروني';

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
        docId: docId,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({@required this.docId, this.title});
  final docId;
  final String title;
  @override
  viewElectronicComplaintsInfo createState() =>
      new viewElectronicComplaintsInfo(docId: docId);
}

class viewElectronicComplaintsInfo extends State<MyHomePage> {
  viewElectronicComplaintsInfo({@required this.docId});

  final docId;

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final linkController = TextEditingController();

  bool _isButtonDisabled;

  @override
  void initState() {
    _isButtonDisabled = false;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back_ios),
        centerTitle: true,
        title: Text('رفع بلاغ'),
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
                  Icon(Icons.vpn_key_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  "رقم الطلب",
                  false,
                  numberController),
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
        onPressed: _isButtonDisabled ? null : _closedComplaint,

        //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "اغلاق البلاغ",
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
        enabled: false,
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
          "للبلاغات الإلكترونية",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: KSUColor,
            letterSpacing: 10,
          ),
        ));
  }

  void _getData() async {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot doc = await databaseReference
        .collection('electronicComplaints')
        .doc(docId.toString())
        .get();
    numberController.text = doc.get('requestId').toString();
    nameController.text = doc.get('name');
    emailController.text = doc.get('email');
    linkController.text = doc.get('link');
  }

  void _closedComplaint() async {
    setState(() {
      _isButtonDisabled = true;
    });
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    databaseReference
        .collection('electronicComplaints')
        .doc(docId.toString())
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => electronicComplaintsList1()),
            );

          },
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => electronicComplaintsList1()),
            );
          },
          // () => Navigator.pop(electronicComplaintsList1.dart), // هنا وين يروح بعدها ؟
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
      ],
    ).show();
  }
}
