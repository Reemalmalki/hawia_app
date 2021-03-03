import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'template_date.dart';
import 'usingcolors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menue_templates.dart';
void main() => runApp(partnersAndAponsorsTemplate());

class partnersAndAponsorsTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Form Demo',
      home: template(
        title: "قوالب الشركاء والرعاة",
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
        title: Text('قوالب الشركاء والرعاة'),
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
                  itemCount: PartnersAndAponsors.length,
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
                    currentSelectedValue = PartnersAndAponsors[index].name;

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
                                    SizedBox(height: 65),//90
                                    Text(
                                      PartnersAndAponsors[index].name,
                                      style: TextStyle(
                                        fontSize: 20,//23
                                        color: bluegray_text,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      PartnersAndAponsors[index].description,
                                      style: TextStyle(
                                        fontSize: 13,//15
                                        color: bodycolor,
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 20),//20
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
                          PartnersAndAponsors[index].iconImage,
                          height: 200,
                          width: 70,
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
    const url = 'https://cdn.ksu.edu.sa/ksu-subsites/identity/GuideManual.pdf';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  downloadTemplate() async {
    if (currentSelectedValue == "الشريك الرئيسي") {
      const url =
          'https://cdn.ksu.edu.sa/ksu-subsites/identity/event_%D9%904.ai';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue == "A4 الشريك الرئيسي") {
      const url =
       'https://cdn.ksu.edu.sa/ksu-subsites/identity/Main_Partner.ai';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="الشريك المماثل") {
      const url =
      'https://cdn.ksu.edu.sa/ksu-subsites/identity/Main_Partner_A4.ai';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue == " A4 الشريك المماثل") {
      const url =
          'https://cdn.ksu.edu.sa/ksu-subsites/identity/Similar_Partner.ai';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }


    if (currentSelectedValue =="تعدد الرعاة") {
      const url =
          'https://cdn.ksu.edu.sa/ksu-subsites/identity/Similar_Partner_A4.ai';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue ==" A4 تعدد الرعاة") {
      const url =
'https://cdn.ksu.edu.sa/ksu-subsites/identity/Multiple_Sponsors.ai';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="فعالية داخلية") {
      const url =
          'https://cdn.ksu.edu.sa/ksu-subsites/identity/Multiple_Sponsors_A4.ai';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="A4 فعالية داخلية") {
      const url =
    'https://cdn.ksu.edu.sa/ksu-subsites/identity/event.ai';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
