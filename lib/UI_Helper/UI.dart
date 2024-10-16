import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dsa_rapid/Dashboard.dart';
 
AppBar mtext(){
          return AppBar(
            title: Text("DSA Rapid",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 105, 1, 161),
          );
}
AppBar appBack(BuildContext context) {
  return AppBar(
    title: Text(
      "DSA Rapid",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Color.fromARGB(255, 105, 1, 161),
    // Add back button
    leading: IconButton(
      icon: Icon(Icons.arrow_back,color: Colors.white,),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()), // Redirect to Home
        );
      },
    ),
  );
}

TextStyle h2(){
  return TextStyle(
     fontSize: 22,
      fontWeight: FontWeight.bold,
  );
}

TextStyle h3(){
   return TextStyle(
     fontSize: 18,
  );
}
