import 'package:db_qr_code/statistique/details.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'DataChart.dart';
import 'Statistic.dart';
import 'helper.dart';
import 'liteQr.dart';
import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';

import 'fcm_manager.dart';
import 'package:http/http.dart' as http;

//import 'package:fcm_http/fcm_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> data = Map<String, dynamic>();

  Future<void> _sendData() async {
    showLoader(context);
    var url = Uri.parse(
        'https://corona.lmao.ninja/v2/countries/Morocco?yesterday=false&strict=true&query =');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        this.data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    hideLoader(context);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FcmManager fcm = FcmManager();
    fcm.initFCM();
    this.initData();
  }
  int currentPage = 0;
  GlobalKey bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        //backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text(
            "Home Page",
            style: TextStyle(
              fontSize: 24,
              //fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            Stack(
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,
                  child: IconButton(
                    icon: Icon(Icons.add_alert_sharp),
                    onPressed: () {
                      _Detection(context);
                    },
                  ),
                ),
                Positioned(
                  right: 9,
                  top: 10,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2)),
                  ),
                ),
              ],
            )
          ],
        ),
        //-------------------------------------------------fin AppBar ----------------------------------------
        body: SingleChildScrollView(

          child: Column(
            children: [
              SizedBox(height: 10),
            Container(
                width: double.infinity,
                height: 180,
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26, offset: Offset(0, 20), blurRadius: 10.0)
                    ],
                    image: DecorationImage(
                        image: AssetImage('images/covid.jpg'), fit: BoxFit.cover)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 180,
                      child: Text(
                        'Covid au maroc',
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 120,
                      child: Container(
                        child: RaisedButton(
                          onPressed: () {_Details(context);},
                          color: Colors.white,
                          textColor: Colors.teal,
                          child: Text('Détails'),
                        ),
                      ),
                    ),
                  ],
                )),
              //-------------------------------------------------Box secton ----------------------------------------

              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                              onTap: () {
                                _Detection(context);
                              },
                              child: Icon(
                                Icons.qr_code_scanner_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Scanner')
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Paramètre')
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('A propos')
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: InkWell(
                              onTap: () {
                                _Detection(context);
                              },
                              child: Icon(
                                Icons.pin_drop,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Project')
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //-------------------------------------------------fin icons section ----------------------------------------
              lineSection,
              subTitleSection,
              InkWell(
                onTap: () {
                  _MyStatistic(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.teal,
                        Colors.tealAccent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total tests',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Mis a jour quotidiennement',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(height: 5),
                      Text(
                        data['tests'].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  print("tapped on container");
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.teal,
                        Colors.tealAccent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total deaths",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Mis a jour quotidiennement',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(height: 5),
                      Text(
                        data['deaths'].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  print("tapped on container");
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.teal,
                        Colors.tealAccent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tests / million',
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Mis a jour quotidiennement',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(height: 5),
                      Text(
                        data['testsPerOneMillion'].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  print("tapped on container");
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.teal,
                        Colors.tealAccent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's deaths",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Mis a jour quotidiennement',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(height: 5),
                      Text(
                        data['todayDeaths'].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  print("tapped on container");
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.teal,
                        Colors.tealAccent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today's recovered",
                        style: TextStyle(
                            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Today's recovered",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(height: 5),
                      Text(
                        data['todayRecovered'].toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        /***************** Fancy Bar ***********/
        bottomNavigationBar: FancyBottomNavigation(
          circleColor: Colors.teal,
          inactiveIconColor: Colors.teal,
          tabs: [
            TabData(
                iconData: Icons.home,

                title: "Home",
                onclick: () {
                  final FancyBottomNavigationState fState = bottomNavigationKey
                      .currentState as FancyBottomNavigationState;
                 fState.setPage(1);
                }),
            TabData(
                iconData: Icons.analytics,
                title: "Statistics",
                onclick: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DatatChart()))),
            TabData(iconData: Icons.account_balance_wallet, title: "My wallet",
                onclick: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => DatatChart()))
            ),
            TabData(iconData: Icons.settings, title: "Paramètre")
          ],
          initialSelection: 1,
          key: bottomNavigationKey,
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
        ),
        /**************************/
      ),
    );
  }
  initData() async {
    var url = Uri.parse(
        'https://corona.lmao.ninja/v2/countries/Morocco?yesterday=false&strict=true&query =');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        this.data = convert.jsonDecode(response.body) as Map<String, dynamic>;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

Widget containerSection = Container(
  height: 200,
  width: double.infinity,
  margin: EdgeInsets.all(20),
  padding: EdgeInsets.all(20),
  decoration: BoxDecoration(
    boxShadow: [
      BoxShadow(color: Colors.black26, offset: Offset(0, 20), blurRadius: 10.0)
    ],
    borderRadius: BorderRadius.circular(10),
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.orange,
        //Colors.green,
      ],
    ),
  ),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Titre',
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
      Text('Sous-titre'),
      RaisedButton(
        onPressed: () {},
        color: Colors.orange,
        textColor: Colors.white,
        child: Text('Acheter'),
      )
    ],
  ),
);

Widget rowSection = Container(
  color: Colors.black,
  height: 100,
  margin: EdgeInsets.all(20),
  child: Row(
    children: [
      Container(
        color: Colors.blue,
        height: 100,
        width: 100,
      ),
      Expanded(
        child: Container(
          color: Colors.amber,
        ),
      ),
      Container(
        color: Colors.purple,
        height: 100,
        width: 100,
      ),
    ],
  ),
);

void _Detection(BuildContext context) {
  final route = MaterialPageRoute(builder: (BuildContext context) {
    return const MyHomePage(
      title: 'Qr Code Scanner',
    );
  });
  Navigator.of(context).push(route);
}

void _Details (BuildContext context) {
  final route = MaterialPageRoute(builder: (BuildContext context) {

    return const Details(
    );
  });
  Navigator.of(context).push(route);
}
void Statistic(BuildContext context) {
  final route = MaterialPageRoute(builder: (BuildContext context) {
    return const MyStatistic();
  });
  Navigator.of(context).push(route);
}

Widget lineSection = Container(
  color: Colors.grey[200],
  padding: EdgeInsets.all(4),
);

Widget subTitleSection = Container(
  margin: EdgeInsets.all(20),
  child: Row(
    children: [
      Container(
        color: Colors.indigoAccent,
        width: 5,
        height: 25,
      ),
      SizedBox(width: 10),
      Text(
        'Curriculum',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      )
    ],
  ),
);

void _MyStatistic(BuildContext context) {
  final route=MaterialPageRoute(builder: (BuildContext context){
    return MyStatistic();

  });
  Navigator.of(context).push(route);
}
void _DatatChart(BuildContext context) {
  final route=MaterialPageRoute(builder: (BuildContext context){
    return DatatChart();

  });
  Navigator.of(context).push(route);
}