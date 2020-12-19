import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'usingcolors.dart';
import 'main.dart';

Future<void> main() async {
  runApp(qustions1());
}

class qustions1 extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الهوية',
      home: MyHomePage(title: 'الهوية'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => main1()),
              );
            },
          ),
          //child: Icon(Icons.arrow_back_ios)
        ),
        centerTitle: true,
        title: Text('الاسئلة الشائعة'),
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
          child: Column(children: [
            _Text(),
          ]),
        ),
      ),
    );
  }

  Widget _Text() {
    return Container(
        margin: EdgeInsets.only(top: 50, bottom: 90),
        child: Text(
          "  هل ممكن تغيير ألوان الشعار ؟ - "
              '\n'
              "لايمكن تغيير لون الشعار إلا بالحالات الاستثنائية الواردة في الدليل الارشادي في الموقع "
              '\n'
              '\n'
              " هل ممكن استخدام الشعار في الجهة اليسرى ؟ - "
              '\n'
              "يمنع منعاً باتاً وضع الشعار في الجهة اليسرى"
              '\n'
              '\n'
              " لون الكتابة تحت الشعار ممكن استخدام الوان اخرى؟-"
              '\n'
              "اللون الأساسي اللون الرمادي ويسمح باللون الاسود اذا كان اللون الرمادي لن يكون واضحا مع التصميم",
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 17.5,
            fontWeight: FontWeight.w800,
            color: KSUColor,
            // letterSpacing: 10,
          ),
        ));
  }
/*
 Text(' - هل ممكن تغيير الوان الشعار ؟'
                'لايمكن تغيير لون الشعار الا بالحالات الاستثنائية الواردة في الدليل الارشادي في الموقع '
                '- هل ممكن استخدام الشعار في الجهة اليسرى ؟'
                'يمنع منعاً باتاً وضع الشعار في الجهة اليسرى'
                '- لون الكتابة تحت الشعار ممكن استخدام الوان اخرى ؟'
                'اللون الاساسي اللون الرمادي ويسمح باللون الاسود اذا كان اللون الرمادي لن يكون واضحا مع التصميم')
 */
}
