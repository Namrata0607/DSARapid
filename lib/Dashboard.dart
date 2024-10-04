import 'package:dsa_rapid/BubbleSort.dart';
import 'package:dsa_rapid/InsertionSort.dart';
import 'package:dsa_rapid/LinearSearch.dart';
import 'package:dsa_rapid/QuickSort.dart';
import 'package:dsa_rapid/SelectionSort.dart';
import 'package:dsa_rapid/Stack.dart';
import 'package:dsa_rapid/quiza.dart';
import 'package:video_player/video_player.dart';

import 'SignInUp.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:dsa_rapid/ViewUpdateProfile.dart';
import 'package:dsa_rapid/BinarySearch.dart';
import 'package:dsa_rapid/LinearSearch.dart';
import 'package:dsa_rapid/InsertionSort.dart';
import 'package:dsa_rapid/QuickSort.dart';
import 'package:dsa_rapid/Stack.dart';
import 'package:dsa_rapid/Queue.dart';
import 'package:dsa_rapid/quiza.dart';




// void main() => runApp(
//       Home()
// );

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

 void _Viewprofile(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Viewprofile()),
    );
  }

  void _Updateprofile(){
     Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Updateprofile()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: mtext(),
        body: Container(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: Color.fromARGB(255, 199, 167, 255),
                height: 1000,
                width: 300,
        // margin: EdgeInsets.all(16.0), // Add margin around the Column
        child: Column(
          children: [
            Center(
              child: Container(
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profile.png"),
                  radius: 90,
                ),
              ),
            ),
            // Profile information section
            SizedBox(height: 16.0), // Adds spacing between the image and the next row
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("Name:"),
                  subtitle: Text("Namrata Daphale"), // Replace with dynamic data if needed
                  onTap: () {
                    // Add onTap functionality if needed
                  },
                ),
                Divider(), // Optional: Adds a divider line between items
                ListTile(
                  leading: Icon(Icons.confirmation_number),
                  title: Text("Roll Number:"),
                  subtitle: Text("66"), // Replace with dynamic data if needed
                  onTap: () {
                    // Add onTap functionality if needed
                  },
                ),
                Divider(), // Optional: Adds a divider line between items
                ListTile(
                  leading: Icon(Icons.group),
                  title: Text("Division:"),
                  subtitle: Text("C"), // Replace with dynamic data if needed
                  onTap: () {
                    // Add onTap functionality if needed
                  },
                ),
                Divider(), // Optional: Adds a divider line between items
                ListTile(
                  leading: Icon(Icons.class_),
                  title: Text("Class:"),
                  subtitle: Text("B.Tech"), // Replace with dynamic data if needed
                  onTap: () {
                    // Add onTap functionality if needed
                  },
                ),
              ],
            ),

            SizedBox(height: 16.0), // Adds spacing between the rows
            Row(
               mainAxisAlignment: MainAxisAlignment.center, // Centers children vertically
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50, // Set the desired height
                  width: 250, // Set the desired width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 105, 1, 161), // Set the button's background color
                    ),
                    onPressed: _Viewprofile,
                    child: Text(
                      'View profile',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.0), // Adds spacing between the rows
            Row(
               mainAxisAlignment: MainAxisAlignment.center, // Centers children vertically
                crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50, // Set the desired height
                  width: 250, // Set the desired width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 105, 1, 161), // Set the button's background color
                    ),
                    onPressed: _Updateprofile,
                    child: Text(
                      'Update profile',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
              Expanded(child: myFunc(),)
            ],
          ),
        ),
      ),
    );
  }
}
Widget myFunc() {
  // List of colors
  final List<Color> colorsList = [
    Color.fromARGB(255, 250, 145, 138),
    Color.fromARGB(255, 152, 248, 155),
    Color.fromARGB(255, 155, 207, 250),
    Color.fromARGB(255, 249, 240, 152),
    Color.fromARGB(255, 55, 242, 236),
    Color.fromARGB(255, 235, 153, 249),
    Color.fromARGB(255, 250, 145, 138),
    Color.fromARGB(255, 152, 248, 155),
    Color.fromARGB(255, 155, 207, 250),
    Color.fromARGB(255, 249, 240, 152),
    Color.fromARGB(255, 55, 242, 236),
    Color.fromARGB(255, 235, 153, 249),
  ];

  final List<String> textList = [
    "Binary Search",
    "Linear Search",
    "Insertion Sort",
    "Selection Sort",
    "Bubble Sort",
    "Quick Sort",
    "Stack",
    "Queue",
    "data9",
    "data10",
    "data11",
    "data12",
  ];

  // List of button texts
  final List<List<String>> buttonTextsList = [
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
      ["Notes", "Visualizer", "Test"],
  ];

// List of functions to call for the middle button
final List<Function(BuildContext)> VisualizerBtn = [
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => BinarySearch())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => LinearSearch())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => InsertionSort())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => SelectionSort())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => BubbleSort())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => QuickSort())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => StackVisualizer())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => QueueVisualizer())),
  // (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => BreadthFirstSearch())),
  // (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => KruskalAlgorithm())),
  // (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => PrimAlgorithm())),
  // (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => FloydWarshall())),
];

final List<Function(BuildContext)> TestBtn = [
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => QuizApp())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => LinearSearch())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => InsertionSort())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => SelectionSort())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => BubbleSort())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => QuickSort())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => StackVisualizer())),
  (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => QueueVisualizer())),
  // (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => BreadthFirstSearch())),
  // (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => KruskalAlgorithm())),
  // (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => PrimAlgorithm())),
  // (context) => Navigator.push(context, MaterialPageRoute(builder: (context) => FloydWarshall())),
];




return GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 3, // Number of items per row
    crossAxisSpacing: 2, // Reduced spacing between the items horizontally
    mainAxisSpacing: 2, // Reduced spacing between the items vertically
    childAspectRatio: 0.8, // Adjusted aspect ratio to increase height (width/height)
  ),
  itemCount: colorsList.length, // Number of items (colors)
  padding: EdgeInsets.all(5), // Reduced padding around the entire grid
  itemBuilder: (context, index) {
    return Container(
      margin: EdgeInsets.all(5), // Reduced margin for individual containers
      height: 300, // Increased height of each container
      decoration: BoxDecoration(
        color: colorsList[index], // Assign the color from the list
        borderRadius: BorderRadius.circular(15), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 5.0, // How much the shadow should blur
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      ),
      alignment: Alignment.center, // Center align the text within the container
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
        children: [
          Text(
            textList[index], // Display the corresponding text
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0), // Change text color for better visibility
              fontSize: 20,
            ),
          ),
          SizedBox(height: 10), 
          
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: 16 / 9, // Set the desired aspect ratio for the video
                    // child: VideoPlayerWidget(
                      
                    // ), // Add a video widget here (custom widget for video playback)
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10), 

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: buttonTextsList[index].asMap().entries.map((entry) {
              int buttonIndex = entry.key; // Get the index of the button
              String buttonText = entry.value; // Get the text of the button

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0), // Spacing between buttons
                child: SizedBox(
                  height: 30, // Set the desired height
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      if (buttonIndex == 0) {
                        // Handle button 0 press
                      } else if (buttonIndex == 1) {
                        // Access the middle button
                        VisualizerBtn[index](context);
                      } else if (buttonIndex == 2) {
                        TestBtn[index](context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 105, 1, 161), // Set the button background color
                      onPrimary: Color.fromARGB(255, 199, 167, 255), // Set the text color when button is pressed
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), // Padding for button content
                    ),
                    child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255), // Text color
                        fontSize: 15, // Font size
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  },
);

}
