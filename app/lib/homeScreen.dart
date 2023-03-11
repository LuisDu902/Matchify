import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: SizedBox(
            
            child: Stack(children: <Widget>[
              Positioned(
                  top: 360,
                  left: 36,
                  child: Container(
                      width: 154,
                      height: 147,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(246, 217, 18, 1),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(154, 147)),
                      ))),
              Positioned(
                  top: 360,
                  left: 225,
                  child: Container(
                      width: 154,
                      height: 147,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(73, 43, 124, 1),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(154, 147)),
                      ))),
              Positioned(
                  top: 390,
                  left: 75,
                  child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/add.png'),
                            fit: BoxFit.fitWidth),
                      ))
                  ),
              Positioned(
                  top: 20,
                  left: 5,
                  child: Container(
                      width: 60,
                      height: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/settings.png'),
                            fit: BoxFit.fitWidth),
                      ))),
              Positioned(
                  top: 10,
                  left: 341,
                  child: //Mask holder Template
                      SizedBox(
                    width: 51,
                    height: 48,
                    child: ClipOval(
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: 0,
                            left: -4,
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: const BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.25),
                                        offset: Offset(0, 4),
                                        blurRadius: 4)
                                  ],
                                  image: DecorationImage(
                                      image: AssetImage('images/user.png'),
                                      fit: BoxFit.fitWidth),
                                ))),
                      ]),
                    ),
                  )),
              const Positioned(
                  top: 58,
                  left: 93,
                  child:
                      Divider(color: Color.fromRGBO(0, 0, 0, 1), thickness: 1)),
              const Positioned(
                  top: 25,
                  left: 156,
                  child: Text(
                    'Matchify',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(48, 21, 81, 1),
                        fontFamily: 'Italiana',
                        fontSize: 30,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              const Positioned(
                  top: 530,
                  left: 48,
                  child: Text(
                    'Add playlist',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(48, 21, 81, 1),
                        fontFamily: 'Istok Web',
                        fontSize: 25,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              const Positioned(
                  top: 530,
                  left: 236,
                  child: Text(
                    'Mix playlist',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(48, 21, 81, 1),
                        fontFamily: 'Istok Web',
                        fontSize: 25,
                        letterSpacing:
                            0 /*percentages not used in flutter. defaulting to zero*/,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  )),
              Positioned(
                  top: 380,
                  left: 250,
                  child: Container(
                      width: 108,
                      height: 108,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/mix.png'),
                            fit: BoxFit.fitWidth),
                      ))),
            ])));
  }
}
