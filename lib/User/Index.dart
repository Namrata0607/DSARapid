import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dsa_rapid/User/SignInUp.dart';
import 'package:dsa_rapid/Admin/admin_dash.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: mtext(),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth, // Use full screen width
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // Animated text container
                  Container(
                    height: 100.0,
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 224, 255),
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Color.fromARGB(255, 199, 167, 255),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(255, 244, 224, 255),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // Animated text on the left side
                        Expanded(
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 60.0,
                              fontFamily: 'Horizon',
                              color: Color.fromARGB(255, 105, 1, 161),
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

                  // Carousel slider
                  Container(
                    child: CarouselSlider(
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

                  // Description container
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 224, 255),
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Color.fromARGB(255, 199, 167, 255),
                        width: 1.0,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DSA Rapid Description",
                          style: h2(),
                        ),
                        SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "A Data Structure Virtual Lab is an online or software-based platform designed to help students and professionals understand, implement, and experiment with various data structures. These virtual labs provide interactive learning environments where users can visualize how data structures work, manipulate them, and observe their behavior in different scenarios. Users can see graphical representations of data structures like arrays, linked lists, stacks, queues, trees, and graphs. Visualizations help users understand the operations such as insertion, deletion, traversal, and searching. The lab usually provides a set of exercises or problems to solve using different data structures.",
                              textAlign: TextAlign.justify,
                              style: h3(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Start Learning Button
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignInPage()),
                        );
                      },
                      child: Text(
                        "Start Learning",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 105, 1, 161),
                        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  // Admin Button (No overflow issue)
                  SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => adminLogin()),
                        );
                      },
                      child: Text(
                        "Admin Login",
                        style: TextStyle(fontSize: 20.0),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 105, 1, 161),
                        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
