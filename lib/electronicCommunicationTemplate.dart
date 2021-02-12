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
      debugShowCheckedModeBanner: false,

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
                                    SizedBox(height: 65),//90
                                    Text(
                                      electronicCommunication[index].name,
                                      style: TextStyle(
                                        fontSize: 20,//23
                                        color: bluegray_text,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      electronicCommunication[index].description,
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
                          electronicCommunication[index].iconImage,
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
    const url = 'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/_%D8%A7%D9%84%D8%AF%D9%84%D9%8A%D9%84%20%D8%A7%D9%84%D8%A7%D9%95%D8%B1%D8%B4%D8%A7%D8%AF%D9%8A%20%D9%84%D9%87%D9%88%D9%8A%D8%A9%20%D8%AC%D8%A7%D9%85%D8%B9%D8%A9%20%D8%A7%D9%84%D9%85%D9%84%D9%83%20%D8%B3%D8%B9%D9%88%D8%AF%20%D8%A7%D9%84%D8%A7%D8%B5%D8%AF%D8%A7%D8%B1%20%D8%A7%D9%84%D8%AB%D8%A7%D9%86%D9%8A.pdf?alt=media&token=bb5ce925-fab7-470e-83f5-5a3c4fe53357';//'https://identity.ksu.edu.sa/ar';
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
'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Electronic%20Avertising.ai?alt=media&token=0afe76a2-b239-4be3-a030-ad28e52a41ed';
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
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Email_Signature2.ai?alt=media&token=226d2589-6ce2-43aa-80f0-4872fd242196';
'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Website_Instructions.ai?alt=media&token=e2d56b02-3536-413b-9715-3ba97c623917';
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
