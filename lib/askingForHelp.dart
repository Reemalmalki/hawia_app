import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'usingcolors.dart';
import 'questions.dart';
import 'homePage.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'dart:io' as Io;
import 'package:flutter/services.dart';
void main() => runApp(askingForHelp1());

class askingForHelp1 extends StatelessWidget {
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
  File _image;
  bool _loading ;

  @override
  void initState() {
    _loading = false;
    _isButtonDisabled = false;
  }

  void open_camera() async {
    // ignore: deprecated_member_use
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
              _loading ? Center(child: CupertinoActivityIndicator()) : Container(),

             // _loading==false ? Center(child: CupertinoActivityIndicator()) : Container(),
              _inputField(
                  Icon(Icons.speaker_notes_outlined,
                      size: 20, color: Color(0xffA6B0BD)),
                  "ملاحظات",
                  false,
                  noteController),
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
                        //  SizedBox(width: 30),
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
    try {
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
      if (_image != null) {
        var storage = FirebaseStorage.instance;
        var ref1 = storage.ref().child('helpRequests').child(id.toString());
        var uploadTask = ref1.putFile(_image);
        await uploadTask.then((res) async {
          final String downloadUrl =
          await res.ref.getDownloadURL();
          // ignore: deprecated_member_use
          await ref.update({'url': downloadUrl});
        });
      }
      print(ref.id);
      setState(() {
        _loading = false;
      });
      _showRatingDialog();
    }catch (e) {
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
            title: "تم إرسال طلبك بنجاح",
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
    var ref = databaseReference.collection('helpRequests').doc('Ratings');
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

