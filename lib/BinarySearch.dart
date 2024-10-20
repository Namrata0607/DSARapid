import 'package:flutter/material.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class BinarysearchNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PDF Viewer',
      home: PDFViewerScreen(),  // Directly open the PDF on load
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Automatically open the PDF when this screen is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      const url = 'assets/notes/BSearch.pdf';  // Relative path to the PDF
      await launch(url);  // This opens the PDF in a new browser tab
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: Text('Opening PDF...'),
      ),
    );
  }
}


// void main() {
//   runApp(BinarySearchVisualizerApp());
// }

class BinarySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Binary Search Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BinarySearchScreen(),
    );
  }
}


class BinarySearchScreen extends StatefulWidget {
  @override
  _BinarySearchScreenState createState() => _BinarySearchScreenState();
}

class _BinarySearchScreenState extends State<BinarySearchScreen> {
  List<int> array = []; // Initially empty array
  int? low; // For visual representation of low index
  int? high; // For visual representation of high index
  int? mid; // For visual representation of mid index
  bool searching = false; // State for search animation
  String currentAlgorithm = ""; // Holds the current algorithm
  String currentOutput = ""; // Holds the step-by-step output

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBack(context),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Left Container (for Algorithm and Output)
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.grey.shade300,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Algorithm section
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Algorithm',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  Divider(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        currentAlgorithm,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Output/Step-by-step explanation section
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Step-by-Step Output',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                    ),
                                  ),
                                  Divider(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        currentOutput,
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Right Container (for Array Visualizer)
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Binary Search Visualizer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Divider(),
                          Expanded(
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: array.isEmpty
                                      ? [
                                          Text(
                                            'Array is empty',
                                            style: TextStyle(
                                                fontSize: 18, color: Colors.red),
                                          )
                                        ]
                                      : _buildBars(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Container (for Operation Buttons)
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              color: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _createDefaultArray,
                    child: Text('Create Default'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _clearArray,
                    child: Text('Clear'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _showInsertDialog(context),
                    child: Text('Insert'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: searching ? null : () => _showFindValueDialog(context),
                    child: Text('Search'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Create default array
  void _createDefaultArray() {
    setState(() {
      array = [10, 20, 30, 40, 50, 60, 70, 80]; // Default sorted array
      low = null;
      high = null;
      mid = null;
      currentAlgorithm = """
1. Set the low index to the start of the array (0).
2. Set the high index to the end of the array (length of the array - 1).
3. While low is less than or equal to high:
   a. Calculate mid as the average of low and high.
   b. If the value at mid is equal to the target value, return mid.
   c. If the value at mid is less than the target value, set low to mid + 1.
   d. If the value at mid is greater than the target value, set high to mid - 1.
4. If the target value is not found, return -1.
""";
      currentOutput = "Default array created.";
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      low = null;
      high = null;
      mid = null;
      currentAlgorithm = "";
      currentOutput = "Array cleared.";
    });
  }

  // Show dialog to input value for inserting into the array
  Future<void> _showInsertDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Insert Value');
    if (value != null) {
      setState(() {
        array.add(value); // Add element to array
        array.sort(); // Ensure the array remains sorted
        currentOutput = "$value inserted. Array: $array\n";
      });
    }
  }

  // Show dialog to find the index of an element using binary search
  Future<void> _showFindValueDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Find Value');
    if (value != null) {
      await _binarySearch(value); // Perform binary search with animation
    }
  }

  // Perform binary search with animation
  Future<void> _binarySearch(int value) async {
    searching = true;
    low = 0;
    high = array.length - 1;
    currentOutput = ""; // Clear previous output

    while (low! <= high!) {
      mid = (low! + high!) ~/ 2; // Find the middle index
      setState(() {
        // Highlight low, high, and mid indices
        currentOutput += "Current low: $low, high: $high, mid: $mid\n";
        currentOutput += "Comparing ${array[mid!]} with $value.\n";
      });
      await Future.delayed(Duration(seconds: 4)); // Pause for visual effect

      if (array[mid!] == value) {
        setState(() {
          currentOutput += "$value found at index: $mid!\n";
        });
        await Future.delayed(Duration(seconds: 1));
        break;
      } else if (array[mid!] < value) {
        low = mid! + 1; // Adjust low index
        setState(() {
          currentOutput += "Searching in the right half.\n";
        });
      } else {
        high = mid! - 1; // Adjust high index
        setState(() {
          currentOutput += "Searching in the left half.\n";
        });
      }
      await Future.delayed(Duration(seconds: 1)); // Pause for visual effect
    }

    if (low! > high!) {
      setState(() {
        currentOutput += "$value not found in the array.\n";
      });
    }

    searching = false;
  }

  // Build the visual bars for the array
  List<Widget> _buildBars() {
    return List<Widget>.generate(array.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: AnimatedContainer(
          height: 100, // Fixed height for all bars
          width: 60,
          duration: Duration(milliseconds: 500),
          color: (index == low) ? Colors.blue // Highlight low index
              : (index == high) ? Colors.red // Highlight high index
              : (index == mid) ? Colors.green // Highlight mid index
              : Colors.purple, // Default bar color
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Text(
              array[index].toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

  // Generalized input dialog to get user input
  Future<int?> _showInputDialog(BuildContext context, String title) async {
    final TextEditingController controller = TextEditingController();

    return showDialog<int>(context: context, builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(hintText: 'Enter a number'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Dismiss dialog
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = int.tryParse(controller.text);
              Navigator.of(context).pop(value); // Return value
            },
            child: Text('OK'),
          ),
        ],
      );
    });
  }
}

//Test

// List of questions (binary questions in data structure)
final List<Question> BinarySearchQuestions = [
  Question(
  questionText: 'What is the time complexity of the binary search algorithm in the best case?',
  options: ['O(1)', 'O(log n)', 'O(n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of binary search in the average case?',
  options: ['O(log n)', 'O(n)', 'O(n log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of binary search in the worst case?',
  options: ['O(1)', 'O(log n)', 'O(n)', 'O(n log n)'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'Binary search requires the array to be:',
  options: ['Unsorted', 'Sorted', 'Random', 'Reverse Sorted'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'Binary search requires the array to be:',
  options: ['Unsorted', 'Sorted', 'Random', 'Reverse Sorted'],
  correctAnswerIndex: 1,
),
  Question(
  questionText: 'Which of the following is a valid example of using binary search?',
  options: ['Searching in a sorted array', 'Searching in a linked list', 'Searching in an unsorted array', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Given a sorted array [10, 20, 30, 40, 50], what will be the mid index when performing binary search for 30?',
  options: ['2', '1', '3', '0'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following conditions is used to check if the search element is in the left half during binary search?',
  options: ['element < mid', 'element > mid', 'element == mid', 'element >= mid'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a sorted array [5, 15, 25, 35, 45], what would be the first mid element if we search for 35?',
  options: ['25', '35', '15', '45'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens if the element is not found in binary search?',
  options: ['The algorithm returns -1', 'The algorithm throws an error', 'It enters an infinite loop', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Binary search is most efficient when the array size is:',
  options: ['Large', 'Small', 'One element', 'Unsorted'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which data structure is most suitable for binary search?',
  options: ['Array', 'Linked List', 'Queue', 'Stack'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the space complexity of binary search?',
  options: ['O(1)', 'O(log n)', 'O(n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following is a correct recursive implementation of binary search?',
  options: ['Divide the array into halves', 'Iterate over the array linearly', 'Randomly select mid-point', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a binary search tree (BST), what is the time complexity of searching for an element in the average case?',
  options: ['O(log n)', 'O(n)', 'O(n^2)', 'O(1)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the main advantage of binary search over linear search?',
  options: ['It works faster on large data sets', 'It works on unsorted arrays', 'It uses more space', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which condition terminates the binary search algorithm?',
  options: ['left > right', 'mid == element', 'left == mid', 'right < element'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Binary search is an example of which type of algorithm?',
  options: ['Divide and conquer', 'Greedy', 'Dynamic programming', 'Backtracking'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following does binary search NOT work on?',
  options: ['Sorted arrays', 'Arrays with duplicate elements', 'Unsorted arrays', 'None of the above'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'In binary search, how many comparisons are made in the worst case for an array of size 16?',
  options: ['4', '16', '8', '5'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'Which of the following algorithms has a time complexity similar to binary search?',
  options: ['Quick sort', 'Merge sort', 'Linear search', 'Selection sort'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'Binary search can also be implemented iteratively. True or false?',
  options: ['True', 'False'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'If binary search fails to find an element, it returns:',
  options: ['-1', '0', 'None', 'The closest value'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Binary search is optimal when searching for an element in which data structure?',
  options: ['Sorted array', 'Linked list', 'Hash map', 'Tree'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the maximum depth of a binary search for an array of size 64?',
  options: ['6', '64', '5', '7'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'Which of the following is true about binary search?',
  options: ['It works faster than linear search for small datasets', 'It works on linked lists', 'It works on sorted arrays', 'It requires O(n) space'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'What is the major drawback of binary search?',
  options: ['Array must be sorted', 'It requires a lot of memory', 'It has O(n) time complexity', 'It only works for large datasets'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Binary search is applicable in searching through which of the following?',
  options: ['Sorted linked list', 'Hash tables', 'Sorted arrays', 'Unsorted stacks'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'Binary search compares the target element with:',
  options: ['Middle element', 'First element', 'Last element', 'Random element'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Binary search can be applied to which of the following data structures?',
  options: ['Array', 'Hash table', 'Linked list', 'Queue'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'If you perform binary search on a sorted array of size 1000, how many comparisons will be needed in the worst case?',
  options: ['10', '9', '11', '100'],
  correctAnswerIndex: 2,
),

];
class BinarySearchQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    return QuizUI(quizQuestions: BinarySearchQuestions); // Use the common UI
  }
}