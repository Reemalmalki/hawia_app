import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hawia_app/main.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'menue_templates.dart';
import 'template_date.dart';
import 'usingcolors.dart';
import 'package:url_launcher/url_launcher.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var userName = sharedPreferences.getString('userName');
  runApp(userName == null ? template1() : MenueTemplates());
}

class template1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,

      // title: 'Flutter Form Demo',
      home: template(
        title: "قوالب مايكروسوفت",
      ),
    );
  }
}

class template extends StatefulWidget {
  template({Key key, this.title}) : super(key: key);
  final String title;
  @override
  templateState createState() => templateState();
}

class templateState extends State<template> {
  var currentSelectedValue;
  @override
  initState() {
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray_background,
      body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
              ),
              Container(
                height: 650,
                child: Swiper(
                  itemCount: welcomePages.length,
                  itemWidth: MediaQuery.of(context).size.height ,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeSize: 15,
                      space: 8,
                      activeColor: KSUColor,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    currentSelectedValue = welcomePages[index].name;

                    return Stack(
                      children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: gray_background,
                              ),
                              child:  Column(
                                children: <Widget>[
                                  Image.asset(
                                welcomePages[index].iconImage,
                                fit: BoxFit.fitWidth,
                              ),
                                  SizedBox(height: 20),

                    Text(
                                    welcomePages[index].description,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: bodycolor,
                                      backgroundColor: gray_background,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  currentSelectedValue == "welcome Page2"?_loginBtn():Center(),
                            ])
                    )]
                    );
                  },
                ),
          ),
    ])
    ),
      persistentFooterButtons: [
        FlatButton(
          textColor: Colors.grey,
        onPressed: () {
          moveToLogin();
             },
    child: Text('تخطي'),
    ),
    ],
    );
  }

  void moveToLogin(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => main1()),
    );
  }
  Widget _loginBtn() {
    return Container(
      width: 250,
      margin: EdgeInsets.only(top: 20, bottom: 20),
      decoration: BoxDecoration(
          color: gray_background,
          border: Border.all(color:KSUColor),
          borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: FlatButton(
          child: Text(
            "ابدأ",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: KSUColor,
            ),
          ),
          onPressed:()=> {
            moveToLogin()
          }),
    );
  }

}
