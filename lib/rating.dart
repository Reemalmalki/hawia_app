import 'package:flutter/material.dart';
import 'usingcolors.dart';
import 'employeeHomePage.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';

Future<void> main() async {
  runApp(rating());
}

class rating extends StatelessWidget {
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
  bool finish = false;
  int count = 0;
  @override

  void initState() {
    super.initState();
    getDocs();
  }

  final Map<String, double> dataMapE = Map();
  final Map<String, double> dataMapF = Map();
  final Map<String, double> dataMapH = Map();

  Future getDocs() async {
    print('1');
    await Firebase.initializeApp();
    final databaseReference = FirebaseFirestore.instance;
    DocumentSnapshot fieldsComplaints = await databaseReference
        .collection('fieldsComplaints')
        .doc('Ratings')
        .get();
    DocumentSnapshot helpRequests =
    await databaseReference.collection('helpRequests').doc('Ratings').get();
    DocumentSnapshot electronicComplaints = await databaseReference
        .collection('electronicComplaints')
        .doc('ratings')
        .get();
    setState(() {
    dataMapF.putIfAbsent(
        "راضي تماماً", () => (fieldsComplaints.get('high').toDouble()));
    dataMapF.putIfAbsent(
        "محايد", () => fieldsComplaints.get('medium').toDouble());
    dataMapF.putIfAbsent(
        "غير راضي", () => fieldsComplaints.get('low').toDouble());

    dataMapE.putIfAbsent(
        "راضي تماماً", () => electronicComplaints.get('high').toDouble());
    dataMapE.putIfAbsent(
        "محايد", () => electronicComplaints.get('medium').toDouble());
    dataMapE.putIfAbsent(
        "غير راضي", () => electronicComplaints.get('low').toDouble());


    dataMapH.putIfAbsent(
        "راضي تماماً", () => helpRequests.get('high').toDouble());
    dataMapH.putIfAbsent("محايد", () => helpRequests.get('medium').toDouble());
    dataMapH.putIfAbsent("غير راضي", () => helpRequests.get('low').toDouble());
    });
  }

  List<Color> colorList = [
    Color(0xFF008FC4),
    Color(0xFFb2bdc3),
    Color(0xFF606f8c),
  ];

  @override
  Widget build(BuildContext context) {
    if(dataMapF.isEmpty == false ){
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('مدى رضا العملاء '),
          backgroundColor: KSUColor,
          leading: Container(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => employeeHomePage()),
                );
              },
            ),
            //child: Icon(Icons.arrow_back_ios)
          ),
        ),
        backgroundColor: gray_background,
        body:  SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(),
            padding: EdgeInsets.symmetric(horizontal: 35),
            width: double.infinity,
            child: Column(
              children: [
                //  _Text(),
                _Text('البلاغات الإلكترونية'),
                _chart(dataMapE),
                _Text('البلاغات الميدانية'),
                _chart(dataMapF),
                _Text('طلبات المساعدة'),
                _chart(dataMapH),
              ],
            ),
          ),
          //  ),
        ));
  }else{
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('مدى رضا العملاء '),
            backgroundColor: KSUColor,
            leading: Container(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => employeeHomePage()),
                  );
                },
              ),
              //child: Icon(Icons.arrow_back_ios)
            ),
          ),
          backgroundColor: gray_background,
          body:  SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(),
              padding: EdgeInsets.symmetric(horizontal: 35),
              width: double.infinity,
              child: Container(
                  margin: EdgeInsets.only(top: 40, bottom: 40),
                  child: Center(
                    child: Text(
                      "جاري تحميل الإحصائيات  ",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                        letterSpacing: 10,
                      ),
                    ),
                  )),
            ),
            //  ),
          ));
    }

  }


  Widget _Text(String text) {
    return Container(
        margin: EdgeInsets.only(top: 20, bottom: 20),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: bluegray_text,
            letterSpacing: 10,
          ),
        ));
  }

  Widget _chart(Map<String, double> dataMap) {
    //sleep(new Duration(seconds: 80));


    return Container(
            child: PieChart(
              dataMap: dataMap,
              animationDuration: Duration(milliseconds: 800),
              chartLegendSpacing: 32.0,
              chartRadius: MediaQuery.of(context).size.width / 3.0,
              showChartValuesInPercentage: true,
              showChartValues: true,
              showChartValuesOutside: false,
              chartValueBackgroundColor: Colors.white10,
              colorList: colorList,
              showLegends: true,
              legendPosition: LegendPosition.right,
              decimalPlaces: 1,
              showChartValueLabel: true,
              initialAngle: 0,
              chartValueStyle: defaultChartValueStyle.copyWith(
                color: Colors.white,
              ),
              chartType: ChartType.disc,
            ));
  }
}
