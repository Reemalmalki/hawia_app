import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'template_date.dart';
import 'usingcolors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'menue_templates.dart';
void main() => runApp(publicationsTemplate());

class publicationsTemplate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      // title: 'Flutter Form Demo',
      home: template(
        title: "قوالب المطبوعات",
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
        title: Text('قوالب المطبوعات'),
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
                  itemCount: publications.length,
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
                    currentSelectedValue = publications[index].name;

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
                                      publications[index].name,
                                      style: TextStyle(
                                        fontSize: 23,
                                        color: bluegray_text,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      publications[index].description,
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
                          publications[index].iconImage,
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
    if (currentSelectedValue == "ملفات") {
      print('ملفات');
      const url =
      // 'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/File2.pdf?alt=media&token=24d3a10e-c8d8-4e52-aef9-6812c17683fc';
'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Banners.ai?alt=media&token=fc1e28a5-c972-4541-b3c9-153136fa7d2e';
      //'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Congratulations_card.ai?alt=media&token=f16e6998-1d42-45be-8d8a-03c7c6cd399a';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="بطاقات التهاني") {
      print('بطاقات التهاني');
      const url =
      //هنا اضيف رابط جديد
        'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/File2.pdf?alt=media&token=24d3a10e-c8d8-4e52-aef9-6812c17683fc';
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Banners.ai?alt=media&token=fc1e28a5-c972-4541-b3c9-153136fa7d2e';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="خلفية مسارح") {
      print('"بوب اب (خلفية مسارح)"');
      const url =
          //'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/File2.pdf?alt=media&token=24d3a10e-c8d8-4e52-aef9-6812c17683fc';
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Banners.ai?alt=media&token=fc1e28a5-c972-4541-b3c9-153136fa7d2e';
     'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Congratulations_card.ai?alt=media&token=f16e6998-1d42-45be-8d8a-03c7c6cd399a';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="ملصقات جدارية") {
      print('"ملصقات جدارية"');
      const url =
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/ExteriorWallPainting_1.3mX4m(X3).ai?alt=media&token=dbe6ed09-ad9a-4ee7-af20-597bc40e65e4';
 'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Popup_Stand.ai?alt=media&token=3298bf4a-e0b2-42dd-aa2f-f879e5444825';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="الرول اب") {
      print('"الرول اب"');
      const url =
//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Roll_up.ai?alt=media&token=1024bbe0-54de-43c1-a9d3-972880811164';
          'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/ExteriorWallPainting_1.3mX4m(X3).ai?alt=media&token=dbe6ed09-ad9a-4ee7-af20-597bc40e65e4';

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    if (currentSelectedValue =="رايات المعارض") {
      print('رايات المعارض');
      const url =
        // 'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Congratulations_card.ai?alt=media&token=f16e6998-1d42-45be-8d8a-03c7c6cd399a';
          'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Roll_up.ai?alt=media&token=1024bbe0-54de-43c1-a9d3-972880811164';

//'https://firebasestorage.googleapis.com/v0/b/hawia-5a663.appspot.com/o/Banners.ai?alt=media&token=fc1e28a5-c972-4541-b3c9-153136fa7d2e';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

  }
}
