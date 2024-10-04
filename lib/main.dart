import 'package:flutter/material.dart';
import 'dart:async';
import 'Index.dart';

void main() {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    routes: {
      '/' : (BuildContext context) => Splash(),
      '/Index' :(BuildContext context) => Index()
    },
  )
  );
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() {return _SplashState(); } 
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 1),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) =>Index())));
  }
  @override
  Widget build(BuildContext context) {
    // return Center(child: Text("data"),);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 105, 1, 161),
      
        body: Center(
            child: Container(
              child: CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/images/SplashDSA.jpeg",
                    ),
                    //backgroundColor: Color.fromARGB(255, 165, 90, 252),
                    radius: 90,
           ),
          ),
        ),
      ),
      );
  }
}

