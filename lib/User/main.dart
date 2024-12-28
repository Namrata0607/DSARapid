import 'package:flutter/material.dart';
import 'dart:async';
import 'Index.dart';  // Ensure this file is correctly implemented
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  const FirebaseOptions firebaseOptions = FirebaseOptions(
      apiKey: "AIzaSyBOewaldLgxm141r47USG4sNf8xfhCHgso",
      authDomain: "dsarapid-33e23.firebaseapp.com",
      projectId: "dsarapid-33e23",
      storageBucket: "dsarapid-33e23.appspot.com",
      messagingSenderId: "932885380272",
      appId: "1:932885380272:web:acd0656d9e8c81a19f8f75",
      measurementId: "G-XNRTWPYK25"
  );

  // Initialize Firebase with the options
  await Firebase.initializeApp(options: firebaseOptions);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => Splash(),
        '/Index': (BuildContext context) => Index(),
      },
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 1),
          () => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Index()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 105, 1, 161),
      body: Center(
        child: CircleAvatar(
          backgroundImage: AssetImage("assets/images/SplashDSA.jpeg"),
          radius: 90,
        ),
      ),
    );
  }
}