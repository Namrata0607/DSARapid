import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';

class Viewprofile extends StatefulWidget {
  const Viewprofile({super.key});

  @override
  State<Viewprofile> createState() => _ViewprofileState();
}

class _ViewprofileState extends State<Viewprofile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBack(context),
        body: Text("View Profile Data",
        style: TextStyle(
          fontSize: 30
        ),
        ),
      ),
      
    );
  }
}

class Updateprofile extends StatefulWidget {
  const Updateprofile({super.key});

  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,

      home: Scaffold(
        appBar: appBack(context),
        body: Text("Update Profile"),
      ),
    );
  }
}
// class IntroPage extends StatefulWidget {
//   const IntroPage({super.key});

//   @override
//   State<IntroPage> createState() => _IntroPageState();
// }

// class _IntroPageState extends State<IntroPage> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }