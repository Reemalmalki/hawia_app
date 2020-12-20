import 'package:flutter/material.dart';
import 'usingcolors.dart';

class imagePreview extends StatefulWidget {
  imagePreview({Key key, this.path}) : super(key: key);
  final String path;
  @override
  imagePreview1 createState() => new imagePreview1(path: path);
}

class imagePreview1 extends State<imagePreview> {
  imagePreview1({@required this.path});
  String path ;

  @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: Center(child: new Text("صورة البلاغ")),
          backgroundColor: KSUColor,
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            //child: Icon(Icons.arrow_back_ios)
          ),
        ),
        body: new SafeArea(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white54,
              child: Image.network(path,fit: BoxFit.cover,
                loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ?
                      loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                          : null,
                    ),
                  );
                },
              ),
            )
        ),
      );
    }
}
