import 'package:flutter/material.dart';
import 'BienvenuePge.dart';
import 'Detection.dart';
import 'Home.dart';

class info extends StatefulWidget {
  const info({Key? key}) : super(key: key);

  @override
  _infoState createState() => _infoState();
}

class _infoState extends State<info> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        leading: IconButton(onPressed:(){_back(context);}, icon: Icon(Icons.arrow_back)),
        backgroundColor: Colors.teal,
        elevation: 0,
        title: Text(
          "C'est simple !",
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
                Stack(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.limeAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      right: 17,
                      top: 11,
                      child: Text(
                        "1",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                height: 15,
              ),
                Text(
                          "J'active l'application",
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
                          "En utilisant le bluetooth de votre téléphone, notre application détecte les téléphones des autres utilisateurs qui restent à proximité du vôtre.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
              SizedBox(
                height: 15,
              ),
              Stack(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.limeAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      right: 17,
                      top: 11,
                      child: Text(
                        "2",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                height: 15,
              ),
                Text(
                          "Je reste informé",
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
                          "vous serez informé si vous avez côtoyé un utilisateur testé positif au COVID-19.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
               SizedBox(
                height: 15,
              ),
              Stack(
                  children: <Widget>[
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.limeAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Positioned(
                      right: 17,
                      top: 11,
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
                 SizedBox(
                height: 15,
              ),
                Text(
                          "Je protége mes proches et les autres",
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
                          "Si vous avez ete teste positif a la COVIDE-19, vous recevez un code a scanner ou a saisir avec vos resultats de test positif ou bien l'obtiendrez aupres de la personne ayant realise le prelevement les utilisateurs qui ont ete a proximite.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
              SizedBox(
                height: 50,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                    width: double.infinity,
                    //color: Colors.tealAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
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
                                      Color(0xFF42A5F5),
                                      Color(0xFF42A5F5),
                                      Color(0xFF1976D2),
                                      Color(0xFF0D47A1),

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
                                onPressed: () {_Detection(context);},
                                child: const Text('Continuer'),
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
      return Bienvenue();

    });
    Navigator.of(context).push(route);
  }
   void _Detection(BuildContext context) {
    final route=MaterialPageRoute(builder: (BuildContext context){
      return HomePage();

    });
    Navigator.of(context).push(route);
  }
}
