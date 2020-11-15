import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mlkit/mlkit.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class VisionTextWidget extends StatefulWidget {
  @override
  _VisionTextWidgetState createState() => _VisionTextWidgetState();
}

class _VisionTextWidgetState extends State<VisionTextWidget> {
  String _imagePath = 'Unknown';
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
    String imagePath;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      imagePath = await EdgeDetection.detectEdge;
      _imagePath = imagePath;
    } on PlatformException {
      imagePath = 'Failed to get cropped image path.';
    }
    try {
      var currentLabels = await detector.detectFromPath(imagePath);
      setState(() {
        _imagePath = imagePath;
        _currentLabels = currentLabels;
      });
    } catch (e) {
      print(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    //}
    setState(() {
      _imagePath = imagePath;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text Detection'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: 'Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: _buildBody(),
        floatingActionButton: FloatingActionButton(
          /* onPressed: () async {
            try {
              //var file = await ImagePicker.pickImage(source: ImageSource.camera);
              var file =
                  await ImagePicker.pickImage(source: ImageSource.gallery);
              if (file != null) {
                setState(() {
                  _file = file;
                });
                try {
                  var currentLabels =
                      await detector.detectFromPath(_file?.path);
                  setState(() {
                    _currentLabels = currentLabels;
                  });
                } catch (e) {
                  print(e.toString());
                }
              }
            } catch (e) {
              print(e.toString());
            }*/
          //  },
          child: Icon(Icons.camera),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 500.0,
      child: Center(
        child: _imagePath == 'Unknown'
            ? Text('No Image')
            : FutureBuilder<Size>(
                future: _getImageSize(
                    Image.file(new File(_imagePath), fit: BoxFit.fitWidth)),
                builder: (BuildContext context, AsyncSnapshot<Size> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                        foregroundDecoration:
                            TextDetectDecoration(_currentLabels, snapshot.data),
                        child: Image.file(new File(_imagePath),
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
      _showMyDialog('تم التحقق بنجاح', 'الشعار محقق للمواصفات');
    }

    ///////   print("offset : ${offset}");
    /////// print("configuration : ${configuration}");

    final rect = offset & configuration.size;

    ////// print("rect container : ${rect}");

    //canvas.drawRect(rect, paint);
    canvas.restore();
  }

  Future<void> _showMyDialog(String title, String body) async {
    Alert(
      //context: context,
      title: title,
      desc: body,
      buttons: [
        DialogButton(
          child: Text(
            "حسناً",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          // onPressed: () => Navigator.pop(context), // هنا وين يروح بعدها ؟
          color: Colors.lightBlue[800],
          radius: BorderRadius.circular(0.5),
        ),
      ],
    ).show();
  }
}
