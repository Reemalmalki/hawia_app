import 'package:flutter/material.dart';
import 'usingcolors.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'electronicComplaintsList.dart';
import 'helpRequestsList.dart';
import 'fieldComplaintsList.dart';
import 'main.dart';

Future<void> main() async {
  runApp(employeeHomePage());
}

class employeeHomePage extends StatelessWidget {
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
      dataMapH.putIfAbsent(
          "محايد", () => helpRequests.get('medium').toDouble());
      dataMapH.putIfAbsent(
          "غير راضي", () => helpRequests.get('low').toDouble());
    });
  }

  List<Color> colorList = [
    Color(0xFF008FC4),
    Color(0xFFb2bdc3),
    Color(0xFF606f8c),
  ];

  @override
  Widget build(BuildContext context) {
    if (dataMapF.isEmpty == false) {
      return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Text('الصفحة الرئيسية'),
              backgroundColor: KSUColor,
              actions: <Widget>[
                IconButton(
                  tooltip: 'تسجيل الخروج',
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => main1()),
                    );
                  },
                ),
              ]),
          backgroundColor: gray_background,
          body: SingleChildScrollView(
            child: Column(
              children: [
                _padding(),
                new Divider(
                  color: Colors.white,
                  height: 10,
                  thickness: 2,
                ),
                Card(
                    child: Container(
                      width: double.infinity,
                      height: 30,
                      child: Center(
                        child: Text(
                          "إحصائيات رضا العملاء",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: bluegray_text,
                            letterSpacing: 10,
                          ),
                        ),
                      ),
                    )),
                new Divider(
                  color: Colors.white,
                  height: 10,
                  thickness: 2,
                ),
                _padding(),
                Container(
                  height: 210.0,
                  decoration: BoxDecoration(),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _chart(dataMapE, 'البلاغات الإلكترونية'),
                      const VerticalDivider(
                        color: Colors.white10,
                        width: 10,
                        thickness: 3,
                        indent: 20,
                        endIndent: 0,
                      ),
                      _chart(dataMapF, 'البلاغات الميدانية'),
                      const VerticalDivider(
                        color: Colors.white10,
                        width: 10,
                        thickness: 3,
                        indent: 20,
                        endIndent: 0,
                      ),
                      _chart(dataMapH, "طلبات المساعدة"),
                    ],
                  ),
                ),
                _padding(),
                _BTN("إلكتروني"),
                _BTN("ميداني"),
                _BTN("مساعدة"),
              ],
            ),
            //  ),
          ));
    } else {
      return Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Text('الصفحة الرئيسية'),
              backgroundColor: KSUColor,
              actions: <Widget>[
                IconButton(
                  tooltip: 'تسجيل الخروج',
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => main1()),
                    );
                  },
                ),
              ]),
          backgroundColor: gray_background,
          body: SingleChildScrollView(
            child: Container(
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
        margin: EdgeInsets.only(top: 10, left: 75),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: bluegray_text,
            letterSpacing: 10,
          ),
          textAlign: TextAlign.center,
        ));
  }

  Widget _chart(Map<String, double> dataMap, String title) {
    //sleep(new Duration(seconds: 80));

    return Container(
      child: Stack(
        children: [
          PieChart(
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
          ),
          _Text(title),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12, width: 1),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
    );
  }

  Widget _padding() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
    );
  }

  Widget _BTN(String type) {
    String title;
    switch (type) {
      case "إلكتروني":
        title = "البلاغات الإلكترونية";
        break;
      case "ميداني":
        title = "البلاغات الميدانية";
        break;
      case "مساعدة":
        title = "طلبات المساعدة";
        break;
    }
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: new InkWell(
        onTap: () {
          switch (type) {
            case "إلكتروني":
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => electronicComplaintsList1()),
              );
              break;
            case "ميداني":
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => fieldComplaintsList1()),
              );
              break;
            case "مساعدة":
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => helpRequestList1()),
              );
              break;
          }
        },
        child: Container(
          width: 400,
          height: 80.0,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Color(0xFF008FC4),
                letterSpacing: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
