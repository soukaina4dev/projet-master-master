import 'dart:convert' as convert;
import 'package:flutter/cupertino.dart';

import 'fcm_manager.dart';
import 'helper.dart';
import 'package:http/http.dart' as http;

//import 'package:fcm_http/fcm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app_localizations.dart';

class MyStatistic extends StatefulWidget {
  const MyStatistic({Key? key}) : super(key: key);

  @override
  _MyStatisticState createState() => _MyStatisticState();
}

class _MyStatisticState extends State<MyStatistic> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID Stats',
      debugShowCheckedModeBanner: false,
      localeResolutionCallback: (
          Locale? locale,
          Iterable<Locale> supportedLocales,
          ) {
        return locale;
      },
      localizationsDelegates: [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('fr', ''),
        Locale('en', ''),
        Locale('ar', ''),
      ],
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const Statistic(title: 'COVID Stats'),

    );
  }
}

class Statistic extends StatefulWidget {
  const Statistic({ Key? key ,required this.title}): super(key: key);
  final String title;
  @override
  _StatisticState createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
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

  buildHome() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(18.0),

              child: Card(

                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text(AppLocalizations.of(context)!.totalcases),

                      SizedBox(
                        height: 10.0,
                      ),
                      Text(data['cases'].toString())
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text("Today's cases"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(data['todayCases'].toString())
                    ],
                  ),
                ),
                elevation: 10,
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text("Total deaths"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(data['deaths'].toString())
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text("Today's deaths"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(data['todayDeaths'].toString())
                    ],
                  ),
                ),
                elevation: 10,
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text("Total recovered"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(data['recovered'].toString())
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text("Today's recovered"),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(data['todayRecovered'].toString())
                    ],
                  ),
                ),
                elevation: 10,
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(18.0),

              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),

                  child: Column(
                    children: [
                      Text("Total tests"),
                      SizedBox(
                        height: 10.0,

                      ),
                      Text(data['tests'].toString())
                    ],
                  ),
                ),
                elevation: 10,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: const EdgeInsets.all(18.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Text(
                        "Tests / million",
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(data['testsPerOneMillion'].toString())
                    ],
                  ),
                ),
                elevation: 10,
              ),
            )
          ],
        )
      ],
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

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(

       title: Text(widget.title),
      ),
      body: Center(
        child: data.length > 0 ? buildHome() : CircularProgressIndicator(),
      ),
      floatingActionButton:
      FloatingActionButton(
        onPressed: _sendData,
        tooltip: 'refresh',
        child: const Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
