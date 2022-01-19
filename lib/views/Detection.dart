import 'dart:convert';
import 'package:flutter/material.dart';
import 'api.dart';
import 'info.dart';
class Detection extends StatefulWidget {
  const Detection({ Key? key }) : super(key: key);

  @override
  _DetectionState createState() => _DetectionState();
}

class _DetectionState extends State<Detection> {
  _register() async {
    var data={'id':'1234'};
   var res= await CallAp().postData(data,'register');
    print("-------------------------- envoyer ------------------------------");
    var body =json.decode(res.body);
    //if(body['success']){
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context)=>Scaffold(
          appBar: AppBar(

          ),
          body: Container(
            color: Colors.white,
          ),
        ))
      );
   // }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        leading: IconButton(onPressed:(){_back(context);}, icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text(
          "Detection",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      // plusieurs elements horizontaux
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35,horizontal: 15),
          child: Center(
            child: Column(
              children: <Widget>[
              Image.asset('images/bluetooth.png'),
              SizedBox(
                height: 20,
              ),
              Text(
                          "Autoriser les 'contacts Bluetooth'",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      SizedBox(
                height: 5,
              ),
                Text(
                          "TousAntiCovid a besoin d'utiliser le Bluetooth de votre telephone pour fonctionner. aucune donnee de geolocalisation n'est echangee ou enrgistree.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
              SizedBox(
                height: 100,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    width: double.infinity,
                    color: Colors.tealAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xFF0D47A1),
                                      Color(0xFF1976D2),
                                      Color(0xFF42A5F5),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.all(8.0),
                                  primary: Colors.white,
                                  textStyle: const TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  _register();
                                  //avigator.pushNamed(context, 'advertiser');
                                  },

                                child: const Text('Autoriser'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),

              ],
            ),
          ),
        ),
      ),
    );
  }
void _back(BuildContext context) {
    final route=MaterialPageRoute(builder: (BuildContext context){
      return info();

    });
    Navigator.of(context).push(route);
  }
  void _info(BuildContext context) {
    final route=MaterialPageRoute(builder: (BuildContext context){
      return info();

    });
    Navigator.of(context).push(route);
  }
}