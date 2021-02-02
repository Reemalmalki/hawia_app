import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'template_date.dart';
import 'usingcolors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menue_templates.dart';
void main() => runApp(template1());

class template1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
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
    _showMyDialog("nouf","reem");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (c) => MenueTemplates()),
                      (route) => false);
            },
          ),
          //child: Icon(Icons.arrow_back_ios)
        ),        centerTitle: true,
        title: Text('قوالب'),
        backgroundColor: KSUColor,
      ),
      backgroundColor: gray_background,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/KSU_logo_large.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(32.0),
              ),
              Container(
                height: 400,
                padding: const EdgeInsets.only(left: 32),
                child: Swiper(
                  itemCount: templates.length,
                  itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                  layout: SwiperLayout.STACK,
                  pagination: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                      activeSize: 13,
                      space: 3,
                      activeColor: KSUColor,
                    ),
                  ),
                  itemBuilder: (context, index) {
                    currentSelectedValue = templates[index].name;

                    return Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: 40),
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32)),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(25.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 90),
                                    Text(
                                      templates[index].name,
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: bluegray_text,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      templates[index].description,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: bodycolor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: <Widget>[
                                        FlatButton(
                                          textColor: linkColor,
                                          onPressed: downloadTemplate,
                                          child: Text(
                                            "للتحميل",
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: linkColor,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          shape: CircleBorder(
                                              side: BorderSide(
                                                  color: Colors.transparent)),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: linkColor,
                                          size: 20,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          templates[index].iconImage,
                          height: 200,
                          width: 100,
                        ),
                      ],
                    );
                  },
                ),
              ),
              _Download(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _Download() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 30.0, top: 5.0, right: 30.0, bottom: 30.0),
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
        onPressed: _launchURL,
        //padding: EdgeInsets.symmetric(vertical: 25),
        child: Text(
          "رابط الدليل الإرشادي",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://identity.ksu.edu.sa/ar';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  downloadTemplate() async {
    if (currentSelectedValue =="قالب وورد عربي") {
      print('بوربوينت');
      const url =
'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/KSU_Template_En.dotx?alt=media&token=079d559f-f21e-4b28-b528-2319543b0d32';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    //"قالب وورد انجليزي"

    if (currentSelectedValue == "قالب بوربوينت") {
      print('ورد');
      const url =
          'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/KSU_Template_Ar.dotx?alt=media&token=7a32bc2c-888a-4d5b-b4bd-94c53cead6dc';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    if (currentSelectedValue == "قالب وورد انجليزي") {
      print('ورد');
      const url =
'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/KSU_PowerPoint_Template.potx?alt=media&token=15c70f40-011e-4d7a-92af-2efcf7633b45';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
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
