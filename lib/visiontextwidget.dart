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
class VisionTextWidget extends StatefulWidget {
  VisionTextWidget({@required this.imagePath});
  String imagePath;
  @override
  _VisionTextWidgetState createState() => _VisionTextWidgetState(imagePath:imagePath);
}

class _VisionTextWidgetState extends State<VisionTextWidget> {
  _VisionTextWidgetState({@required this.imagePath});
  String imagePath;
  final String type = null;
  int x = 0;
  File _file;
  List<VisionText> _currentLabels = <VisionText>[];

  FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Future<void> initPlatformState() async {
    try {
      var currentLabels = await detector.detectFromPath(imagePath);
      setState(() {
        _currentLabels = currentLabels;
      });
    } catch (e) {
      print(e.toString());
    }
    if (!mounted) return;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('الصفحة الرئيسية'),
        ),
        body: _buildBody(),

      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 500.0,
      child: Center(
        child: imagePath == 'Unknown'
            ? Text('No Image')
            : FutureBuilder<Size>(
                future: _getImageSize(
                    Image.file(new File(imagePath), fit: BoxFit.fitWidth)),
                builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        foregroundDecoration:
                            TextDetectDecoration(_currentLabels, snapshot.data),
                        child: Image.file(new File(imagePath),
                            fit: BoxFit.fitWidth));
                  } else {
                    return Text('Detecting...');
                  }
                },
              ),
      ),
    );
  }

  Future<Size> _getImageSize(Image image) {
    Completer<Size> completer = Completer<Size>();
    image.image.resolve(ImageConfiguration()).addListener(ImageStreamListener(
        (ImageInfo info, bool _) => completer.complete(
            Size(info.image.width.toDouble(), info.image.height.toDouble()))));
    return completer.future;
  }

  Widget _buildBody() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildImage(),
          _buildList(_currentLabels),
        ],
      ),
    );
  }

  Widget _buildList(List<VisionText> texts) {
    if (texts.length == 0) {
      return Text('Empty');
    }
    return Expanded(
      child: Container(
        child: ListView.builder(
            padding: const EdgeInsets.all(1.0),
            itemCount: texts.length,
            itemBuilder: (context, i) {
              return _buildRow(texts[i].text);
            }),
      ),
    );
  }

  Widget _buildRow(String text) {
    return ListTile(
      title: Text(
        "Text1: ${text}",
      ),
      dense: true,
    );
  }
}

class TextDetectDecoration extends Decoration {
  final Size _originalImageSize;
  final List<VisionText> _texts;
  TextDetectDecoration(List<VisionText> texts, Size originalImageSize)
      : _texts = texts,
        _originalImageSize = originalImageSize;

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return _TextDetectPainter(_texts, _originalImageSize);
  }
}

class _TextDetectPainter extends BoxPainter {
  bool flag = true;
  final List<VisionText> _texts;
  final Size _originalImageSize;
  _TextDetectPainter(texts, originalImageSize)
      : _texts = texts,
        _originalImageSize = originalImageSize;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final paint = Paint()
      ..strokeWidth = 2.0
      ..color = Colors.red
      ..style = PaintingStyle.stroke;
    // print("original Image Size : ${_originalImageSize}");
    var year = '1957';
    //var univeraityname = 'King Saud\nUniversity';
    var univeraityname1 = 'King '; // Saud\nUniversity\nDg2WloJl äeo La';
   // var universityname2 = 'King Saud\nUniversity\nag2uloJl äeo La';
    //var universityname3 = 'King Saud\nUniversity\nDgwloJl äo0la';

    final _heightRatio = _originalImageSize.height / configuration.size.height;
    final _widthRatio = _originalImageSize.width / configuration.size.width;
    var list = _texts.asMap();
    for (var text in _texts) {
      print(list[0].text.substring(0, 5));
      if (list[0].text.substring(0, 5) == (univeraityname1) &&
          list[1].text == (year)) {
        print('words english first');
        // flag = false;
      }
      // print('left');
      // print(offset.dx + text.rect.left / _widthRatio);
      // print('right');
      //print(offset.dx + text.rect.right / _widthRatio);

      //print("text : ${text.text}, rect : ${text.rect}");
      // print('**********');
      // print(tlist[0].rect.toString());
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
            print('hi nouf-------------------------^^^^^^^^^');
          }
        }
      }
      /* final _rect = Rect.fromLTRB(/
          offset.dx + text.rect.left / _widthRatio,
          offset.dy + text.rect.top / _heightRatio,
          offset.dx + text.rect.right / _widthRatio,
          offset.dy + text.rect.bottom / _heightRatio);
      //final _rect = Rect.fromLTRB(24.0, 115.0, 75.0, 131.2);
      print("_rect : ${_rect}");
      canvas.drawRect(_rect, paint);*/
    }
    if (flag) {
      //_showSuccessDialog(context);
    }

    ///////   print("offset : ${offset}");
    /////// print("configuration : ${configuration}");

    final rect = offset & configuration.size;

    ////// print("rect container : ${rect}");

    //canvas.drawRect(rect, paint);
    canvas.restore();
  }

    Future<void> _showErrorDialog( context, String body)  {
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

  Future<void> _showSuccessDialog(context)  {
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

  Future<void> _showUnDefindDialog(context)  {
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
          },                 color: Colors.lightBlue[800],
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
          },                 color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.9),
        ),
      ],
    ).show();
  }


}
