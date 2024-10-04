import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dsa_rapid/SignInUp.dart';


class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: mtext(),
      //   appBar: AppBar(
      //     title: Text("DSA Rapid",
      //       textAlign: TextAlign.left,
      //       style: TextStyle(
      //         fontSize: 20,
      //         color: Colors.white,
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //     backgroundColor: Color.fromARGB(255, 105, 1, 161),
      // ),
      body: Container(
          height: double.infinity,
          width: double.infinity,

          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              
              children: [
               Container(
                  //color: Colors.deepPurple[100],
                  height: 100.0, 
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Adds padding inside the container
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 244, 224, 255), // Set the background color
                    borderRadius: BorderRadius.circular(15.0), // Round the borders
                    border: Border.all(
                      color: Color.fromARGB(255, 199, 167, 255), // Border color
                      width: 1.0, // Border width
                    ),
                    boxShadow: [
                      BoxShadow(
                       color: Color.fromARGB(255, 244, 224, 255),
                        // color: Color.fromARGB(255, 228, 184, 252).withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),// Set a fixed height to ensure vertical alignment
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // The animated text on the left side
                      Expanded(
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 60.0,
                            fontFamily: 'Horizon',
                            
                          ),
                          child: AnimatedTextKit(
                            repeatForever: true,
                            animatedTexts: [
                              RotateAnimatedText('LEARN ALGO', textAlign: TextAlign.left),
                              RotateAnimatedText('VISUALIZE ALGO', textAlign: TextAlign.left),
                            ],
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ),
                     
                    ],
                  ),                 
                ),
                // Divider(
                  
                //   color: Color.fromARGB(255, 105, 1, 161),
                //   thickness: 0.2,
                // ),
                  Container(
                  child: CarouselSlider(
                    //main column's children 1 means like row 1
                    items: [
                      Container(
                        width: 340,
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage("assets/images/SplashDSA.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 340,
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage("assets/images/SplashDSA.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 340,
                        margin: EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: AssetImage("assets/images/SplashDSA.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                
                    ],
                    options: CarouselOptions(
                      height: 250.0,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      viewportFraction: 1.0,
                    ),
  
                ),
                ),
                Container(
                  height: 300.0, 
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0), // Adds padding inside the container
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 244, 224, 255), // Set the background color
                    borderRadius: BorderRadius.circular(15.0), // Round the borders
                    border: Border.all(
                      color: Color.fromARGB(255, 199, 167, 255), // Border color
                      width: 1.0, // Border width
                    ),
                  ),

                  child: Column(
                    children: [
                      Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 8.0),
                        child: Center(
                          child: Text(
                            "DSA Rapid Desceiption",
                            // textAlign: TextAlign.center,
                            style: h2()
                          ),
                        ),
                      ),
                    ],
                  ),
                 SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      // width: 500,
                      child: Text(
                        "A Data Structure Virtual Lab is an online or software-based platform designed to help students and professionals understand, implement, and experiment with various data structures. These virtual labs provide interactive learning environments where users can visualize how data structures work, manipulate them, and observe their behaviour in different scenarios. Users can see graphical representations of data structures like arrays, linked lists, stacks, queues, trees, and graphs. Visualizations help users understand the operations such as insertion, deletion, traversal, and searching. The lab usually provides a set of exercises or problems to solve using different data structures.",
                        textAlign: TextAlign.justify,
                        style: h3(),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  
                  onPressed: () {
            // Navigate to the login/signup page
                  Navigator.push(
                    context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      }, child: Text("Start Learning",
                          style: TextStyle(fontSize: 20.0),
                        ),
                  style: ElevatedButton.styleFrom(
                    
                    // alignment: Alignment.bottomCenter,
                    backgroundColor: Color.fromARGB(255, 105, 1, 161),
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      ),
                  )
                    ],
                    
                  ),
                ),
              ],  
            ),
          ),
        ),
      ),
    );
  }
}


