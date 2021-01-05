import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'template_date.dart';
import 'usingcolors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menue_templates.dart';
void main() => runApp(electronicComuniecationTemplate());

class electronicComuniecationTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // title: 'Flutter Form Demo',
      home: template(
        title: "قوالب التواصل الالكتروني",
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
        title: Text('قوالب التواصل الالكتروني'),
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
                  itemCount: electronicCommunication.length,
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
                    currentSelectedValue = electronicCommunication[index].name;

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
                                      electronicCommunication[index].name,
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: bluegray_text,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      electronicCommunication[index].description,
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
                        /* Image.asset(
                          electronicCommunication[index].iconImage,
                          height: 200,
                          width: 100,
                        ),*/
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
    if (currentSelectedValue == "تويتر") {
      print("1");
      const url =
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Twitter.ai?alt=media&token=5d168bbe-0320-4748-bd11-53f0bd0b3ab4';
 'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature5.ai?alt=media&token=49eb201f-d884-4b78-a181-f40376368924';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="الاعلان الالكتروني(شاشات)") {
      print("2");
      const url =
          'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Twitter.ai?alt=media&token=5d168bbe-0320-4748-bd11-53f0bd0b3ab4';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue ==" دليل المواقع الالكترونية ") {
      print("3");
      const url =
         'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Thanks_Certificare.ai?alt=media&token=c272098c-951e-4ee0-a470-61f0370704c1';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="توقيع البريد الالكتروني١") {
      print("4");
      const url =
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature1.ai?alt=media&token=1586467b-c3be-4f47-9df2-0487d3e061da';
'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature2.ai?alt=media&token=226d2589-6ce2-43aa-80f0-4872fd242196';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }


    if (currentSelectedValue =="توقيع البريد الالكتروني٢") {
      print("5");
      const url =
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature2.ai?alt=media&token=226d2589-6ce2-43aa-80f0-4872fd242196';
      'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature1.ai?alt=media&token=1586467b-c3be-4f47-9df2-0487d3e061da';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="توقيع البريد الالكتروني٣") {
      print("6");
      const url =
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature3.ai?alt=media&token=8138177f-abba-4b7c-9c73-991b1a5ecda5';
'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature2.ai?alt=media&token=226d2589-6ce2-43aa-80f0-4872fd242196';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="توقيع البريد الالكتروني٤") {
      print("7");
      const url =
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature4.ai?alt=media&token=ee1d16b1-7efb-4ca1-9f14-e8ba7382cc21';
    //  'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature5.ai?alt=media&token=49eb201f-d884-4b78-a181-f40376368924';
      'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature3.ai?alt=media&token=8138177f-abba-4b7c-9c73-991b1a5ecda5';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="توقيع البريد الالكتروني٥") {
      print("8");
      const url =
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature5.ai?alt=media&token=49eb201f-d884-4b78-a181-f40376368924';
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature3.ai?alt=media&token=8138177f-abba-4b7c-9c73-991b1a5ecda5';
        //'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature5.ai?alt=media&token=49eb201f-d884-4b78-a181-f40376368924';
'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature4.ai?alt=media&token=ee1d16b1-7efb-4ca1-9f14-e8ba7382cc21';

      //    'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature4.ai?alt=media&token=ee1d16b1-7efb-4ca1-9f14-e8ba7382cc21';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

  }
}
