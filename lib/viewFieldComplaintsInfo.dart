import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'usingcolors.dart';
import 'fieldComplaintsList.dart';
class viewFieldComplaintsInfo1 extends StatelessWidget {
  viewFieldComplaintsInfo1({@required this.docId});
  final docId;
  @override
  Widget build(BuildContext context) {
    final appName = 'البلاغ الميداني';

    return MaterialApp(
      title: appName,
      home: MyHomePage(title: appName, docId: docId),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.docId}) : super(key: key);
  final String title;
  final docId;
  @override
  viewFieldComplaintsInfo createState() =>
      new viewFieldComplaintsInfo(docId: docId);
}

class viewFieldComplaintsInfo extends State<MyHomePage> {
  viewFieldComplaintsInfo({@required this.docId});

  final docId;

  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final emailController = TextEditingController();
  final buildController = TextEditingController();
  final placeController = TextEditingController();
  final floorController = TextEditingController();
  final imageController = TextEditingController();

  bool _isButtonDisabled;
  var imageUrl ;

  @override
  void initState() {
    _isButtonDisabled = false;
    imageUrl = null ;
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Center(child: new Text(widget.title)),
        backgroundColor: KSUColor,
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => fieldComplaintsList1()),
              );
            },
          ),
          //child: Icon(Icons.arrow_back_ios)
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/KSU_logo.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: Column(
            children: [
              _padding(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _inputField(
                        Icon(Icons.account_circle_outlined,
                            size: 20, color: Color(0xffA6B0BD)),
                        "الاسم",
                        false,
                        nameController),
                  ),
                  Expanded(
                    child: _inputField(
                        Icon(Icons.confirmation_number_outlined,
                            size: 20, color: Color(0xffA6B0BD)),
                        "رقم البلاغ",
                        false,
                        numberController),
                  ),
                ],
              ),
              _inputField(
                  Icon(Icons.email_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  "الايميل",
                  false,
                  emailController),
              _inputField(
                  Icon(Icons.location_on_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  "المكان",
                  false,
                  placeController),
              _inputField(
                  Icon(Icons.business, size: 20, color: Color(0xffA6B0BD)),
                  "المبنى",
                  false,
                  buildController),
              _inputField(
                  Icon(Icons.approval, size: 20, color: Color(0xffA6B0BD)),
                  "الدور",
                  false,
                  floorController),

              FlatButton(
                padding: EdgeInsets.all(0),
                height: 10,
                onPressed: () {
                  takePicture2();
                },
                child: _inputField(
                    Icon(Icons.camera_alt_outlined, size: 20, color: Color(0xffA6B0BD)),
                    'صورة البلاغ',
                    false,
                    imageController),
              ),
              takePicture2(),
              _closeReport(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _hi() {
    return Container(
      child: Column(
        children: [],
      ),
    );
  }

  Widget _padding() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 30),
    );
  }

  Widget _closeReport() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30, bottom: 30),
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
        onPressed: _isButtonDisabled ? null : _closedComplaint,
        //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "إغلاق البلاغ",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
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
  Widget takePicture2() {
    return Container(
      child: Container(
        child: Column(children: [
          Container(
              color: Colors.black12,
              child: imageUrl == null ? Text('hi') : Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.yellow,
                child: Image.network(
                  imageUrl,
                  width: 100.0,
                ),
              )          ),
        ]),
      ),
    );
  }

  void _getData() async {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot doc = await databaseReference
        .collection('fieldsComplaints')
        .doc(docId.toString())
        .get();
    numberController.text = doc.get('requestId').toString();
    nameController.text = doc.get('name');
    emailController.text = doc.get('email');
    buildController.text = doc.get('building');
    floorController.text = doc.get('floor');
    placeController.text = doc.get('place');
    imageController.text = 'معاينة صورة البلاغ' ;
    setState(() {
      imageUrl = doc.get('url');
    });
    print(imageUrl);

  }

  void _closedComplaint() async {
    setState(() {
      _isButtonDisabled = true;
    });
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    databaseReference
        .collection('fieldsComplaints')
        .doc(docId.toString())
        .update({'status': "closed"});
    _showMyDialog(
        "تم اغلاق الطلب بنجاح", "رقم الطلب :  " + numberController.text);
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
              MaterialPageRoute(builder: (context) => fieldComplaintsList1()),
            );
          },
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
      ],
    ).show();
  }
}
