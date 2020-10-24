import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hawia_app/viewElectronicComplaintsInfo.dart';

Future<void> main() async {runApp(electronicComplaintsList1());
}

class electronicComplaintsList1 extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'البلاغات الاإلكترونية',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'البلاغات الإلكترونية'),

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

  List<String> idsList  = List<String>();
  List<String> docsIdList  = List<String>();

  @override
  void initState() {
    getDocs();
  }
  @override
  Widget build(BuildContext context) {
    if (idsList.isEmpty == false) {
      return new Scaffold(
          appBar: new AppBar(
            title: new Text(widget.title),
          ),
          body: new SafeArea(
            top: false,
            bottom: false,

            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: idsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new ListTile(
                          selectedTileColor: Colors.lightBlue,
                          trailing: Icon(
                            Icons.admin_panel_settings,
                            color: Colors.lightBlue,
                            size: 30.0,),
                          onTap:  () {
                            _onTapped(index);
                          },
                          title: new Text('${idsList[index]}', style: TextStyle(
                            color: Colors.black54, fontSize: 20,),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      )
                  );
                }
            ),
          ));
    } else {
      return new Scaffold(
          appBar: new AppBar(
          title: new Text(widget.title),
    ),
    body: new SafeArea(
    top: false,
    bottom: false,
      child: Center(
        child: new Text("سيتم عرض البلاغات هنا حال توفرها", style: TextStyle(
          color: Colors.black45, fontSize: 20,),
          textAlign: TextAlign.right,
        ),
      ),
    )
      );
    }
  }
  Future getDocs() async {
    await Firebase.initializeApp();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection("electronicComplaints").where("status",isEqualTo: "opened").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i].data();
      setState(() {
        docsIdList.add(querySnapshot.docs[i].id);
        idsList.add(a["requestId"].toString()+ " : "+ "رقم البلاغ ");
      });
    }
  }
  void _onTapped(int index) {
    // navigate to the next screen.
    var id = docsIdList[index];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => viewElectronicComplaintsInfo1(docId: id)),
    );
  }
}

