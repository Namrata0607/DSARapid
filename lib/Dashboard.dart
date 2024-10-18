import 'package:dsa_rapid/AVLTree.dart';
import 'package:dsa_rapid/BFS.dart';
import 'package:dsa_rapid/BST.dart';
import 'package:dsa_rapid/BubbleSort.dart';
import 'package:dsa_rapid/CircularLinkedList.dart';
import 'package:dsa_rapid/CircularQueue.dart';
import 'package:dsa_rapid/DFS.dart';
import 'package:dsa_rapid/DoublyLinkedList.dart';
import 'package:dsa_rapid/Hashing.dart';
import 'package:dsa_rapid/HeapTree.dart';
import 'package:dsa_rapid/InsertionSort.dart';
import 'package:dsa_rapid/LinearSearch.dart';
import 'package:dsa_rapid/MergeSort.dart';
import 'package:dsa_rapid/PriorityQueue.dart';
import 'package:dsa_rapid/QuickSort.dart';
import 'package:dsa_rapid/SelectionSort.dart';
import 'package:dsa_rapid/SinglyLinkedList.dart';
import 'package:dsa_rapid/Stack.dart';
// import 'package:video_player/video_player.dart';

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
import 'package:dsa_rapid/Array.dart';
// import 'package:dsa_rapid/MergeSort.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:pdfx/pdfx.dart';


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

//   void openPdf(BuildContext context, String assetPath) {
//     print("Opening: $assetPath");
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PdfViewerPage(assetPath: assetPath), // Pass assetPath correctly
//     ),
//   );
// }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: mtext(),
        body: Container(
          child: Row(
            children: [
              SingleChildScrollView(
                child: Container(
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
                  Divider(), // Optional: Adds a divider line between items
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                    // subtitle: Text("B.Tech"), // Replace with dynamic data if needed
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
                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

                          // ElevatedButton(
                          //   onPressed: () {
                          //      (context) =>  openPdf(context, 'assets/files/array.pdf');
                          //   },
                          //   child: Text('Open Array PDF'),
                          // ),  
                          ],
                        ),
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
  // Base list of distinct colors
  final List<Color> baseColorsList = [
    Color.fromARGB(255, 155, 207, 250),
    
    // Color.fromARGB(255, 55, 242, 236),
    Color.fromARGB(255, 189, 132, 199),
    Color.fromARGB(255, 155, 207, 250),

    Color.fromARGB(255, 188, 110, 198),
    // Color.fromARGB(255, 183, 106, 154),
    // Color.fromARGB(255, 120, 26, 175),
    // Color.fromARGB(255, 90, 0, 145), //1
    // Color.fromARGB(255, 130, 45, 185), //2
    // Color.fromARGB(255, 115, 30, 170), //4
    // Color.fromARGB(255, 85, 0, 140), //5
    // Color.fromARGB(255, 140, 60, 190),
    // Color.fromARGB(255, 188, 110, 198),
    // Color.fromARGB(162, 111, 182, 191),
    // Color.fromARGB(255, 183, 106, 154),
  ];

  // Dynamically generate the colorsList based on the index
  final List<Color> colorsList = List.generate(
    21, // Same size as textList and gifList
    (index) => baseColorsList[index % baseColorsList.length], // Reuse colors in a cycle
  );

  final List<String> textList = [
    "Array", //Done
    "Stack",  //Done
    "Queue",  //Done
    "Circular Queue", //Done
    "Priority Queue", //Done
    "Singly Linked List", 
    "Doubly Linked List",
    "Circular Linked List",
    "Linear Search",
    "Binary Search",
    "Bubble Sort",
    "Selection Sort",
    "Insertion Sort",
    "Merge Sort",
    "Quick Sort",
    "Hashing",
    "Binary Search Tree",
    "Heap tree",
    "AVL tree",
    "BFS",
    "DFS"//21
  ];

  final List<String> gifList = [
    'assets/gifs/array.gif',
    'assets/gifs/stackop.gif',
    'assets/gifs/Q.gif',
    'assets/gifs/circularQ.gif',
    'assets/gifs/Q3.gif',
    'assets/gifs/linkedlist.gif',
    'assets/gifs/Doublylinkedlist.gif',
    'assets/gifs/Doublylinkedlist.gif',
    'assets/gifs/linearsearch.gif',
    'assets/gifs/binarysearch.gif',
    'assets/gifs/bubblesort.gif',
    'assets/gifs/selectionsort.gif',
    'assets/gifs/Insertionsort.gif',
    'assets/gifs/mergesort.gif',
    'assets/gifs/quicksort.gif',
    'assets/gifs/hashing.gif',
    'assets/gifs/binarysearchtree.gif',
    'assets/gifs/heaptree.gif',
    'assets/gifs/avltree.gif',
    'assets/gifs/bfs.gif',
    'assets/gifs/dfs.gif',//21
  ];

final List<List<String>> buttonTextsList = List.generate(21, (_) => ["Notes", "Visualizer", "Test"]);

// List of notes widget classes
final List<Widget Function()> notesClasses = [
  () => ArrayNotes(),
  () => StackNotes(),
  () => QueueNotes(),
  () => CircularQNotes(),
  () => PriorityQNotes(),
  () => linkedlistNotes(),
  () => DoublylinkedlistNotes(),
  () => CircularlinkedlistNotes(),
  () => LinearsearchNotes(),
  () => BinarysearchNotes(),
  () => BubblesortNotes(),
  () => SelectionsortNotes(),
  () => InsertionsortNotes(),
  () => MergesortNotes(),
  () => QuicksortNotes(),
  () => HashingNotes(),
  () => BSTNotes(),
  () => HeaptreeNotes(),
  () => AVLNotes(),
  () => BfsNotes(),
  () => DfsNotes(),
];

// Dynamically create the NotesBtn list
final List<Function(BuildContext)> NotesBtn = List.generate(
  notesClasses.length,
  (index) => (context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => notesClasses[index]()),
  ),
);


// List of visualizer widget classes
final List<Widget Function()> visualizerClasses = [
  () => ArrayVisualizer(),
  () => StackVisualizer(),
  () => QueueVisualizer(),
  () => CircularQueueVisualizerApp(),
  () => PriorityQueueVisualizerApp(),
  () => LinkedListVisualizerApp(),
  () => DoublyLinkedListVisualizerApp(),
  () => CircularLinkedListVisualizerApp(),
  () => LinearSearch(),
  () => BinarySearch(),
  () => BubbleSort(),
  () => SelectionSort(),
  () => InsertionSort(),
  () => QuickSort(),
  () => HashTable(),
  () => BSTVisualizer(),
  () => HeapTree(),  // Heap tree visualizer
  () => AVLTreeVisualizer(),
  () => BSTVisualizer(),  // BFS visualizer (replace with actual BFS if applicable)
  () => BSTVisualizer(),  // DFS visualizer (replace with actual DFS if applicable)
];

// Dynamically create the VisualizerBtn list
final List<Function(BuildContext)> VisualizerBtn = List.generate(
  visualizerClasses.length,
  (index) => (context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => visualizerClasses[index]()),
  ),
);

//Test Quiz
// List of quiz widget classes
final List<Widget Function()> quizClasses = [
  () => ArrayQuiz(),
  () => StackQuiz(),
  () => QueueQuiz(),
  () => CircularqueueQuiz(),
  () => PriorityqueueQuiz(),
  () => SinglylinkedlistQuiz(),
  () => DoublylinkedlistQuiz(),
  () => CircularlinkedlistQuiz(),
  () => LinearSearchQuiz(),
  () => BinarySearchQuiz(),
  () => BubbleSortQuiz(),
  () => SelectionSortQuiz(),
  () => InsertionSortQuiz(),
  () => MergesortQuiz(),
  () => QuickSortQuiz(),
  () => HashingQuiz(),
  () => BinarySearchTreeQuiz(),
  () => HeaptreeQuiz(),
  () => AvltreeQuiz(),
  () => BfsQuiz(),
  () => DfsQuiz(),
];

// Dynamically create the TestBtn list
final List<Function(BuildContext)> TestBtn = List.generate(
  quizClasses.length,
  (index) => (context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => quizClasses[index]()),
  ),
);



return GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3, // Number of items per row
      crossAxisSpacing: 5, // Spacing between the items horizontally
      mainAxisSpacing: 5, // Spacing between the items vertically
      childAspectRatio: 0.9, // Aspect ratio of each grid item (width/height)
    ),
    itemCount: colorsList.length, // Number of items (colors)
    padding: EdgeInsets.all(10),
    itemBuilder: (context, index) {
      return FittedBox(
        //height: 350, // Increased height
        child: Container(
          margin: EdgeInsets.all(10),
          // height: 500, // Increased height
          // width: double.infinity, // Takes the full width of the parent (optional)
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20), // Adjust padding to add some space from the top edge
                  child: Text(
                    textList[index], // Display the corresponding text
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0), // Change text color for better visibility
                      fontSize: 20,
                    ),
                  ),
                ),
                Divider(
                  // height: 2,
                ),
                SizedBox(height: 10),
                
                Image.asset(
                  gifList[index], // Display the corresponding GIF
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center, // Center the image horizontally
              //   children: [
              //     Container(
              //       alignment: Alignment.center,
              //       child: Image(
              //         image: AssetImage("assets/images/profile.png"),
              //         height: 100,
              //         width: 100,
              //       ),
              //     ),
              //   ],
              // ),

              SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.only(top: 40.0,bottom: 20,left: 4,right: 4), // Add margin above the row of buttons
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: buttonTextsList[index].asMap().entries.map((entry) {
                    int buttonIndex = entry.key;
                    String buttonText = entry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0), // Spacing between buttons
                      child: SizedBox(
                        height: 40,
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            if (buttonIndex == 0) {
                              NotesBtn[index](context);
                            } else if (buttonIndex == 1) {
                              VisualizerBtn[index](context);
                            } else if (buttonIndex == 2) {
                              TestBtn[index](context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, 
                            backgroundColor: Color.fromARGB(255, 105, 1, 161),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          ),
                          child: Text(
                            buttonText,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

// class GifPlayerWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       alignment: Alignment.center,
//       child: Image.asset(
//         'assets/videos/stack.gif',  // Path to the GIF file
//         height: 200,  // Set a specific height for the GIF container
//         width: 200,   // Set a specific width for the GIF container
//         fit: BoxFit.cover,  // Adjust the image's fit to cover the container
//       ),
//     );
//   }
// }