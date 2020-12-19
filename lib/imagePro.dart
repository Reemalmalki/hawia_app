import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mlkit/mlkit.dart';
import 'package:flutter/services.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'homePage.dart';
import 'askingForHelp.dart';
import 'fieldComplaints.dart';
import 'electronicComplaints.dart';

import 'package:diff_image/diff_image.dart';
import 'package:image/image.dart' as image1;
import 'dart:math';
import 'dart:convert';
import 'dart:io' as Io;

class VisionTextWidget {
  VisionTextWidget({@required this.imagePath});

  String imagePath;
  final String type = null;
  int x = 0;
  File _file;
  List<VisionText> _currentLabels = <VisionText>[];

  FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;

  void detectFromPath() async {
    try {
      var image =  Image.file(File(imagePath));
      var currentLabels = await detector.detectFromPath(imagePath);
      _currentLabels = currentLabels;
      var textDetectPainter = TextDetectPainter(
          _currentLabels, image.width, imagePath);
    } catch (e) {
      print(e.toString());
    }
  }
}


class TextDetectPainter extends BoxPainter {

  bool flag = true;
  final List<VisionText> _texts;
  final double _originalImageWidth;
  final String IamgeUser;
  TextDetectPainter(texts, _originalImageWidth, img)
      : _texts = texts,
        _originalImageWidth = _originalImageWidth,
        IamgeUser = img;
  var b;
  var eb1;
  var ek;
  var eb3;
  var eb4;
  var green;
  var eb6;
  var eb7;
  var eb8;
  var eb9;
  var eb10;
  var ew;
  var withoutbackground;
  var diff1;
  var diff2;
  var user;
  void initState() {
    user = image1.decodeImage(
      File(
        IamgeUser,
      ).readAsBytesSync(),
    );
  }
  var ew1 = image1.decodeImage(
    File(
      'assets/12.png',
    ).readAsBytesSync(),
  );
  var withoutbackground1 = image1.decodeImage(
    File(
      'assets/11.png',
    ).readAsBytesSync(),
  );
  var ebb1 = image1.decodeImage(
    File(
      'assets/1.png',
    ).readAsBytesSync(),
  );
  var ekk = image1.decodeImage(
    File(
      'assets/2(1).png',
    ).readAsBytesSync(),
  );

  var ebb3 = image1.decodeImage(
    File(
      'assets/3test.png',
    ).readAsBytesSync(),
  );
  var ebb4 = image1.decodeImage(
    File(
      'assets/4.png',
    ).readAsBytesSync(),
  );
  var green1 = image1.decodeImage(
    File(
      'assets/5.png',
    ).readAsBytesSync(),
  );
  var ebb6 = image1.decodeImage(
    File(
      'assets/6.png',
    ).readAsBytesSync(),
  );
  var ebb7 = image1.decodeImage(
    File(
      'assets/7.png',
    ).readAsBytesSync(),
  );
  var ebb8 = image1.decodeImage(
    File(
      'assets/8.png',
    ).readAsBytesSync(),
  );

  var blue = image1.decodeImage(
    File(
      'assets/ksub.png',
    ).readAsBytesSync(),
  );

  var black = image1.decodeImage(
    File(
      'assets/black.png',
    ).readAsBytesSync(),
  );
  var white = image1.decodeImage(
    File(
      'assets/white.png',
    ).readAsBytesSync(),
  );

  void getPaint() {

  }

  @override
  void paint(
      Canvas canvas, Offset offset, ImageConfiguration configuration) async {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.red
      ..style = PaintingStyle.stroke;
    var year = '1957';
    var univeraityname1 = 'King ';
    final _widthRatio = _originalImageWidth / configuration.size.width;
    var list = _texts.asMap();
    for (var text in _texts) {
      print(list[0].text.substring(0, 5));
      if (list[0].text.substring(0, 5) == (univeraityname1) &&
          list[1].text == (year)) {
        print('words english first');
        // flag = false;
      }

      double right = offset.dx + text.rect.right / _widthRatio;
      print('right');
      print(right);
      double xr = 60; //110;
      double yr = 125;
      double xl = 40; //90;
      double yl = 100;
      double left = offset.dx + text.rect.left / _widthRatio;
      print('left');
      print(left);
      if (list[0].text == year) {
        if (xr <= right && right <= yr) {
          print('right');
          if (xl <= left && left <= yl) {
            flag = false;
            print('flag = false');
          }
        }
      }

    }
    if (flag) {
      var blue1 = DiffImage.compareFromMemory(
        user,
        blue,
        ignoreAlpha: false,
        asPercentage: false,
      );
      print('blue: ${blue1.diffValue} percent');

      var withoutbackground2 = DiffImage.compareFromMemory(
        user,
        withoutbackground1,
        ignoreAlpha: false,
        asPercentage: false,
      );
      print('withoutbackground2: ${withoutbackground2.diffValue} percent');

      var black1 = DiffImage.compareFromMemory(
        user,
        black,
        ignoreAlpha: false,
        asPercentage: false,
      );
      print('black: ${black1.diffValue} percent');

      var white1 = DiffImage.compareFromMemory(
        user,
        white,
        ignoreAlpha: false,
        asPercentage: false,
      );

      var green2 = DiffImage.compareFromMemory(
        user,
        green1,
        ignoreAlpha: false,
        asPercentage: false,
      );
      print('green: ${green2.diffValue} percent');

      print('white: ${white1.diffValue} percent');
      var lis = [
        blue1.diffValue,
        black1.diffValue,
        white1.diffValue,
        // img.diffValue,
        withoutbackground2.diffValue,
        green2.diffValue
      ];
      lis.sort();
      print('smallest first ${lis.first}');
//

      if (lis.first == blue1.diffValue) {
        eb1 = DiffImage.compareFromMemory(
          user,
          ebb1,
          ignoreAlpha: false,
          asPercentage: false,
        );
        eb3 = DiffImage.compareFromMemory(
          user,
          ebb3,
          ignoreAlpha: false,
          asPercentage: false,
        );

        eb4 = DiffImage.compareFromMemory(
          user,
          ebb4,
          ignoreAlpha: false,
          asPercentage: false,
        );

        eb6 = DiffImage.compareFromMemory(
          user,
          ebb6,
          ignoreAlpha: false,
          asPercentage: false,
        );
        eb7 = DiffImage.compareFromMemory(
          user,
          ebb7,
          ignoreAlpha: false,
          asPercentage: false,
        );

        eb8 = DiffImage.compareFromMemory(
          user,
          ebb8,
          ignoreAlpha: false,
          asPercentage: false,
        );

        print('blue: ${blue1.diffValue} percent');
        print('eb1: ${eb1.diffValue} percent');
        print('eb3: ${eb3.diffValue} percent');
        print('eb4: ${eb4.diffValue} percent');
        print('eb6: ${eb6.diffValue} percent');
        print('eb7: ${eb7.diffValue} percent');
        print('eb8: ${eb8.diffValue} percent');

        var listblue = [
          blue1.diffValue,
          eb1.diffValue,
          eb3.diffValue,
          eb4.diffValue,
          eb6.diffValue,
          eb7.diffValue,
          eb8.diffValue,
        ];
        listblue.sort();

        print('smallest  blue: ${listblue.first}');
        //

        //
        if (listblue.first == blue1.diffValue) {
          _showSuccessDialog('context,' '');
          print('blue');
        }
        if (listblue.first == eb1.diffValue) {
          print('1');
        }

        if (listblue.first == eb3.diffValue) {
          print('3');
        }
        if (listblue.first == eb4.diffValue) {
          print('4');
        }
        if (listblue.first == eb6.diffValue) {
          print('6');
        }
        if (listblue.first == eb7.diffValue) {
          print('7');
        }
        if (listblue.first == eb8.diffValue) {
          print('8');
        }
        if (listblue.first == eb9.diffValue) {
          print('9');
        }
        if (listblue.first == eb10.diffValue) {
          print('10');
        }
      }

      //

      if (lis.first == black1.diffValue) {
        print('black');
      }
      if (lis.first == white1.diffValue) {
        var ew2 = DiffImage.compareFromMemory(
          user,
          ew1,
          ignoreAlpha: false,
          asPercentage: false,
        );
        print('ew: ${ew2.diffValue} percent');

        var listwhite = [white1.diffValue, ew2.diffValue];

        listwhite.sort();
        if (listwhite.first == white1.diffValue) {
          print('white');
        }

        if (listwhite.first == ew2.diffValue) {
          print('error white');
        }
      }

      if (lis.first == green2.diffValue) {
        print('green');
      }
    }
    final rect = offset & configuration.size;
    canvas.restore();
  }

  Future<void> _showErrorDialog(context, String body) {
    Alert(
      context: context,
      title: "الشعار غير محقق للمواصفات التالية",
      desc: "BODY",
      type: AlertType.error,
      buttons: [
        DialogButton(
          child: Text(
            "بلاغ ميداني",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homePage()),
            );
          },
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
        DialogButton(
          child: Text(
            "بلاغ إلكتروني",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homePage()),
            );
          },
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
        DialogButton(
          child: Text(
            "طلب مساعدة",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homePage()),
            );
          },
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
      ],
    ).show();
  }

  Future<void> _showSuccessDialog(context) {
    Alert(
      context: context,
      title: 'تم التحقق بنجاح',
      desc: 'الشعار محقق للمواصفات',
      image: ImageIcon(
        AssetImage('assets/successIcon.png'),
        size: 100,
        color: Colors.green,
      ),
      buttons: [
        DialogButton(
          child: Text(
            "حسناً",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homePage()),
            );
          },
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
      ],
    ).show();
  }

  Future<void> _showUnDefindDialog(context) {
    Alert(
      context: context,
      title: "لم يتم التعرف على الشعار",
      type: AlertType.warning,
      buttons: [
        DialogButton(
          child: Text(
            "طلب مساعدة",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => askingForHelp1()),
            );
          },
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
        DialogButton(
          child: Text(
            "الصفحة الرئيسية",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => homePage()),
            );
          },
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.9),
        ),
      ],
    ).show();
  }
}
