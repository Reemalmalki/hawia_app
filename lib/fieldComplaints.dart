import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'usingcolors.dart';
import 'homePage.dart';
import 'package:flutter/services.dart';
import 'package:edge_detection/edge_detection.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appName = 'رفع البلاغ';
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
  bool _isButtonDisabled;

  @override
  fieldComplaints createState() => new fieldComplaints();
}

class fieldComplaints extends State<MyHomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final buildController = TextEditingController();
  final floorController = TextEditingController();
  final placeController = TextEditingController();
  File _image;
  bool _loading ;

  var currentSelectedValue;
  final deviceTypes = [
    "المدينة الجامعية للطالبات الدرعية",
    "المدينة الجامعية للطالبات عليشة",
    "المدينة الجامعية للطلاب",
    "مستشفى الملك خالد الجامعي"
  ];
  bool _isButtonDisabled;

  @override
  void initState() {
    _loading = false;
    _isButtonDisabled = false;
  }

  void open_camera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  void open_gallery() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: new Text(widget.title)),
        backgroundColor: KSUColor,
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (c) => homePage()),
                      (route) => false);
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
              _loading ? Center(child: CupertinoActivityIndicator()) : Container(),
              Container(
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
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.location_on_outlined,
                            size: 20, color: Color(0xffA6B0BD)),
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
                      textAlign: TextAlign.right,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text(
                            "الرجاء اختيار المكان",
                            style: TextStyle(
                              color: Color(0xffA6B0BD),
                            ),
                          ),
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
                              child: new Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(value)),
                              value: value,
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
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
              Container(
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
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Icon(Icons.file_download,
                            size: 20, color: Color(0xffA6B0BD)),
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
                      textAlign: TextAlign.right,
                      child: Row(
                        children: [
                          if (_image != null)
                            Text(
                                "   تم حفظ الصورة   ",
                                style: TextStyle(
                                  color: Color(0xffA6B0BD),
                                )
                            )
                          else Text(
                            "صورة الشعار المخالف",
                            style: TextStyle(
                              color: Color(0xffA6B0BD),
                            ),
                          ),
                        //  SizedBox(width: 10),
                          Padding(
                            padding: const EdgeInsets.only(left:1.0),
                            child: IconButton(
                              icon: Icon(Icons.image_outlined),
                              tooltip: 'استخدم الاستديو',
                              color: Color(0xFF008FC4),
                              onPressed: () {
                                open_gallery();
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:1.0),
                            child: IconButton(
                              icon: Icon(Icons.camera_alt_outlined),
                              tooltip: 'استخدم الكاميرا',
                              color: Color(0xFF008FC4),
                              onPressed: () {
                                open_camera();
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

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
        onPressed: _checker,
        child: Text(
          "رفع البلاغ",
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
        margin: EdgeInsets.only(top: 50, bottom: 30),
        child: Text(
          'البلاغات الميدانية',
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
    try{
      await Firebase.initializeApp();
      final databaseReference = FirebaseFirestore.instance;
      var doc = await databaseReference
          .collection('fieldsComplaints')
          .doc('totalFieldsComplaints')
          .get();
      int id = doc.get('autoNumber');
      await databaseReference
          .collection('fieldsComplaints')
          .doc('totalFieldsComplaints')
          .update({'autoNumber': FieldValue.increment(1)});
      var ref =
      await databaseReference.collection('fieldsComplaints').add({
        'name': nameController.text,
        'email': emailController.text,
        'place': currentSelectedValue,
        'building': buildController.text,
        'floor': floorController.text,
        'requestId': id,
        'status': 'opened',
      });

      var storage = FirebaseStorage.instance;
      var ref1 = storage.ref().child('fieldsComplaints').child(id.toString());
      var uploadTask = ref1.putFile(_image);
      await uploadTask.then((res) async {
        final String downloadUrl =
        await res.ref.getDownloadURL();
        // ignore: deprecated_member_use
        await ref.update({'url': downloadUrl});
      });
      print(ref.id);
      setState(() {
        _loading = false;
      });
      _showRatingDialog();
    } catch (e) {
      setState(() {
        _loading = false;
      });
      Alert(
        context: context,
        title: 'حدث خطأ',
        desc: 'عذراً حاول مرة اخرى',
        buttons: [
          DialogButton(
            child: Text(
              "حسناً",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.lightBlue[800],
            radius: BorderRadius.circular(0.5),
          ),
        ],
      ).show();
    }

  }

  void _checker() {
    setState(() {
      _loading = true;
    });
    bool flag = true;
    if (_isButtonDisabled) {
      return;
    }
    if (nameController.text.isEmpty) {
      //
      print(nameController.text);
      flag = false;
      _showMyDialog("غير مكتمل", "الرجاء كتابة الأسم بشكل صحيح");
      return;
    }
    if (!(isValidEmail(emailController.text))) {
      //
      print(emailController.text);
      flag = false;
      _showMyDialog("غير مكتمل", "الرجاء كتابة البريد الإلكتروني بشكل صحيح");
      return;
    }
    if (buildController.text.isEmpty) {
      //
      print(buildController.text);
      flag = false;
      _showMyDialog("غير مكتمل", "الرجاء كتابة رقم المبنى بشكل صحيح");
      return;
    }
    if (floorController.text.isEmpty) {
      //
      print(floorController.text);
      flag = false;
      _showMyDialog("غير مكتمل", "الرجاء كتابة رقم الدور بشكل صحيح");
      return;
    }

    if (currentSelectedValue == null) {
      //
      flag = false;
      _showMyDialog("غير مكتمل", "الرجاءاختيار المكان بشكل صحيح");
      return;
    }
    if (_image == null){
      flag = false;
      _showMyDialog("غير مكتمل", "الرجاء اضافة صورة للشعار");
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
    setState(() {
      _loading = false;
    });
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
    setState(() {
      _loading = false;
    });
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
            description: "كيف كانت تجربتك؟",
            submitButton: "تأكيد",
            positiveComment:
            "شكراً لتقييمك ، سعيدون بخدمتك دائماً :)", // optional
            negativeComment:
            " :( شكراً لتقييمك ، سنعمل على تحسين التجربة", // optional
            accentColor: Colors.lightBlue, // optional
            onSubmitPressed: (int rating) {
              _saveRating(rating);
              print(rating);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (c) => homePage()),
                      (route) => false);
            },
          );
        });
  }

  void _saveRating(int rating) async {
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    var ref = databaseReference.collection('fieldsComplaints').doc('Ratings');
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

  @override
  Future<void> initPlatformState() async {
    String imagePath;
    try {
      imagePath = await EdgeDetection.detectEdge;
      /*  Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VisionTextWidget(imagePath: imagePath)),
      );*/
      Alert(
        context: context,
        title: "تم حفظ الصوره بنجاح",
        // desc: "وجه الكاميرا الى الشعار",
        buttons: [
          DialogButton(
            child: Text(
              "حسناً",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: Takepicture900,
            color: Colors.lightBlue[800],
            radius: BorderRadius.circular(0.5),
          ),
        ],
      ).show();
    } on PlatformException {
      imagePath = 'Failed to get cropped image path.';
    }
    if (!mounted) return;
  }

  Takepicture() async {
    // if (currentSelectedValue == "A4") {
    print('a4 nouf');
    /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => main1()),
    );*/
    //  }
    //  if (currentSelectedValue == "Banner ") {
    //   print('panner nouf');
    //  }

    Alert(
      context: context,
      title: "التعليمات",
      desc: "وجه الكاميرا الى الشعار",
      buttons: [
        DialogButton(
          child: Text(
            "حسناً",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: initPlatformState,
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
      ],
    ).show();
  }

  Takepicture900() async {}
}