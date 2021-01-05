import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:diff_image/diff_image.dart';
import 'package:flutter/material.dart';
import 'package:mlkit/mlkit.dart';
import 'package:flutter/services.dart';
import 'package:edge_detection/edge_detection.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'homePage.dart';
import 'askingForHelp.dart';
import 'fieldComplaints.dart';
import 'electronicComplaints.dart';

import 'package:image/image.dart' as img;

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
  bool flag_=true;
  List<VisionText> _currentLabels = <VisionText>[];

  FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;

  @override
  initState() {
    super.initState();
    initPlatformState();
  }


  /// Added New Function to get difference between Taken Image and logo in Assets folder
  /// [DiffImage] package cannot work with different Sizes, So You need to set the width and height for the both images
  /// Steps to get the difference
  ///
  void getDiffImage() async {
    try {


      /// 1- load images and convert it to byte array.
      Uint8List localImageDataBlue = (await rootBundle.load('assets/ksu_masterlogo_colour_rgb.png'))
          .buffer
          .asUint8List();

      Uint8List localImageDataWhite = (await rootBundle.load('assets/ksu_masterlogo_white_rgb.png'))
          .buffer
          .asUint8List();

      Uint8List localImageDataBlack = (await rootBundle.load('assets/ksu_masterlogo_black_rgb.png'))
          .buffer
          .asUint8List();
      Uint8List localImageDataGreen = (await rootBundle.load('assets/KSU_Logo_error_Green.png'))
          .buffer
          .asUint8List();

      Uint8List takenImageData = (await rootBundle.load(imagePath))
          .buffer
          .asUint8List();


      Uint8List localImageDataBlueError = (await rootBundle.load('assets/KSU_LOGO_ErorrBLUE.png'))
          .buffer
          .asUint8List();

      Uint8List localImageDataWhiteError = (await rootBundle.load('assets/KSU_logo_Error_White.png'))
          .buffer
          .asUint8List();

      Uint8List localImageDataPic = (await rootBundle.load('assets/Ksu_logo_Pic.png'))
          .buffer
          .asUint8List();

      /// 2- Decode the image using Image Package the  Resize it. you have to change the sizes.
      img.Image localImageBlue = img.copyResize(img.decodeImage(localImageDataBlue), width: 200,height: 120);
      img.Image localImageDataWhite1 = img.copyResize(img.decodeImage(localImageDataWhite), width: 200,height: 120);
      img.Image localImageDataBlack1 = img.copyResize(img.decodeImage(localImageDataBlack), width: 200,height: 120);
      img.Image localImageDataGreen1 = img.copyResize(img.decodeImage(localImageDataGreen), width: 200,height: 120);
      img.Image localImageDataBlueError1 = img.copyResize(img.decodeImage(localImageDataBlueError), width: 200,height: 120);
      img.Image localImageDataWhiteError1 = img.copyResize(img.decodeImage(localImageDataWhiteError), width: 200,height: 120);
      img.Image localImageDataPic1= img.copyResize(img.decodeImage(localImageDataPic), width: 200,height: 120);

      img.Image takenImage = img.copyResize(img.decodeImage(takenImageData), width: 200, height: 120);


      /// 3- get the difference
       var diff_Blue = DiffImage.compareFromMemory(
           localImageBlue,
          takenImage
      );
      var diff_Black = DiffImage.compareFromMemory(
          localImageDataBlack1,
          takenImage
      );

      var diff_White = DiffImage.compareFromMemory(
          localImageDataWhite1,
          takenImage
      );

      var diff_Green = DiffImage.compareFromMemory(
          localImageDataGreen1,
          takenImage
      );
      var diff_Pic = DiffImage.compareFromMemory(
          localImageDataPic1,
          takenImage
      );
      var list = [
        diff_Blue.diffValue,
        diff_Black.diffValue,
        diff_White.diffValue,
        diff_Green.diffValue,
        diff_Pic.diffValue,
      ];
      list.sort();
      if (list.first == diff_Pic.diffValue) {
        print("pic");
      }

      if (list.first == diff_Blue.diffValue) {

        print('The difference between images is: ${diff_Blue.diffValue} %');
        var diff_BlueError = DiffImage.compareFromMemory(
            localImageDataBlueError1,
            takenImage
        );

        var list_blue = [
          diff_BlueError.diffValue,
          diff_Blue.diffValue,];
        list.sort();

        if(list_blue.first==diff_BlueError.diffValue){print("blueerror");}
        if(list_blue.first==diff_Blue.diffValue){print("blue");}
      }


      if (list.first == diff_Black.diffValue) {
        print('The difference between images black is : ${diff_Black.diffValue} %');
      }
      if (list.first == diff_Green.diffValue) {
        print('The difference between images green is : ${diff_Black.diffValue} %');
      }
      if (list.first == diff_White.diffValue) {
        var diff_WhiteError = DiffImage.compareFromMemory(
            localImageDataWhiteError1,
            takenImage
        );
        var list_white = [
          diff_White.diffValue,
          diff_WhiteError.diffValue,];
        list.sort();
        if(list_white.first==diff_WhiteError.diffValue){print("whiteError");}
        if(list_white.first==diff_White.diffValue){print("white");}

      }

      /// 5- but your Logic here to display the difference value.


    } catch (e) {
      print('Error in get Diff');
      print(e);
    }
  }
  @override
  Future<void> initPlatformState() async {
    try {
      var currentLabels = await detector.detectFromPath(imagePath);


      getDiffImage();
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
    var year = '1957';
    var univeraityname1 = 'King '; // Saud\nUniversity\nDg2WloJl äeo La';


    final _heightRatio = _originalImageSize.height / configuration.size.height;
    final _widthRatio = _originalImageSize.width / configuration.size.width;
    var list = _texts.asMap();
    for (var text in _texts) {
   //   print(list[0].text.substring(0, 5));
      if (list[0].text.substring(0, 5) == (univeraityname1) &&
          list[1].text == (year)) {
        print('words english first');
         //flag_ = false;
      }
      // print('left');
      // print(offset.dx + text.rect.left / _widthRatio);
      // print('right');
      //print(offset.dx + text.rect.right / _widthRatio);

      //print("text : ${text.text}, rect : ${text.rect}");
      // print('**********');
      // print(tlist[0].rect.toString());
      double right = offset.dx + text.rect.right / _widthRatio;
    //  print('right');
    //  print(right);
      double xr = 60; //110;
      double yr = 125;
      double xl = 40; //90;
      double yl = 100;
      double left = offset.dx + text.rect.left / _widthRatio;
    //  print('left');
     // print(left);
      if (list[0].text == year) {
        if (xr <= right && right <= yr) {
      //    print('right');
          if (xl <= left && left <= yl) {
            flag = false;
        //    print('hi nouf-------------------------^^^^^^^^^');
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

    }



    final rect = offset & configuration.size;


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
