import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:edge_detection/edge_detection.dart';

//void main() => runApp(new edgeDetection( type: "Banner"));

class edgeDetection extends StatefulWidget {
  edgeDetection({@required this.type});
  final String type;
  @override
  _MyAppState createState() =>
      new _MyAppState(type: type);
}
class _MyAppState extends State<edgeDetection> {
  _MyAppState({@required this.type});
  String _imagePath = 'Unknown';
  final String type ;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String imagePath;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      imagePath = await EdgeDetection.detectEdge;
    } on PlatformException {
      imagePath = 'Failed to get cropped image path.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _imagePath = imagePath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('وجه الكاميرا إلى الشعار'),
        ),
        body: new Center(
         // child: new Text('Cropped image path: $_imagePath\n'),
        ),
      ),
    );
  }
}