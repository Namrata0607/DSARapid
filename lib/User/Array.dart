import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/User/Dashboard.dart';
import 'dart:math';
import 'package:url_launcher/url_launcher.dart'; 
import 'package:dsa_rapid/UI_Helper/UI.dart'; // Import the helper
import 'package:dsa_rapid/User/SignInUp.dart';


class ArrayNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      const url = 'assets/notes/array.pdf';  // Relative path to the PDF
      await launch(url);  // This opens the PDF in a new browser tab
    });
    
    return Scaffold(
      
      appBar: appBack(context),
      body: Center(
        child: Text('Opening PDF...'),
      ),
    );
  }
}





//visualizer

class ArrayVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ArrayVisualizerScreen(),
    );
  }
}

class ArrayVisualizerScreen extends StatefulWidget {
  @override
  _ArrayVisualizerScreenState createState() => _ArrayVisualizerScreenState();
}

class _ArrayVisualizerScreenState extends State<ArrayVisualizerScreen> {
  List<int> array = [];
  int? highlightedIndex;
  String currentOperation = "";
  String currentAlgorithm = "";
  bool isProcessing = false;
  final int maxArraySize = 8; // Maximum size of the array

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBack(context),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left container (for Algorithm and Output)
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey.shade300,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Algorithm part (Static)
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
                                    color:  Color.fromARGB(255, 105, 1, 161),
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
                        // Output/Step-by-step explanation part
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
                                    color:  Color.fromARGB(255, 105, 1, 161),
                                  ),
                                ),
                                Divider(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      currentOperation,
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
                // Right container (Array Visualizer)
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
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
                                    : array
                                        .asMap()
                                        .map((index, value) => MapEntry(
                                            index,
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              child: AnimatedContainer(
                                                duration:
                                                    Duration(milliseconds: 500),
                                                height: 100,
                                                width: 60,
                                                color: highlightedIndex == index
                                                    ? Colors.greenAccent
                                                    :  Color.fromARGB(255, 105, 1, 161),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  value.toString(),
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )))
                                        .values
                                        .toList(),
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
          // Bottom container (for Operation Buttons)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _createArray,
                  child: Text('Create Default'),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>( Color.fromARGB(255, 105, 1, 161),),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _clearArray,
                  child: Text('Clear'),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>( Color.fromARGB(255, 105, 1, 161),),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showInsertDialog(context),
                  child: Text('Insert'),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>( Color.fromARGB(255, 105, 1, 161),),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showDeleteDialog(context),
                  child: Text('Delete'),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>( Color.fromARGB(255, 105, 1, 161),),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showUpdateDialog(context),
                  child: Text('Update'),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>( Color.fromARGB(255, 105, 1, 161),),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showFindIndexDialog(context),
                  child: Text('Find Index'),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>( Color.fromARGB(255, 105, 1, 161),),
                    foregroundColor:
                        WidgetStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Create default array
  void _createArray() {
    setState(() {
      array = [10, 50, 30, 80]; // Default array
      currentAlgorithm = """
Algorithm for Create:
1. Define the array.
2. Populate the array with initial values.
""";
      currentOperation = "Initial array created.";
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = [];
      currentAlgorithm = """
Algorithm for Clear:
1. Set the array length to 0.
2. Remove all elements.
""";
      currentOperation = "Array cleared.";
    });
  }

  // Highlight the element by index in a loop
  Future<void> _highlightInLoop(int start, int end) async {
    for (int i = start; i <= end; i++) {
      setState(() {
        highlightedIndex = i; // Highlight current index being processed
        currentOperation = "Current index: $i";
      });
      await Future.delayed(Duration(seconds: 2)); // Increased delay
    }
  }

  // Insert value into the array step-by-step with highlighting
  Future<void> _showInsertDialog(BuildContext context) async {
    int? index = await _showInputDialog(context, 'Insert at Index');
    if (index != null && index >= 0 && index <= array.length && array.length < maxArraySize) {
      int? value = await _showInputDialog(context, 'Value to Insert');
      if (value != null) {
        await _highlightInLoop(0, index); // Highlight until insert position
        setState(() {
          array.insert(index, value); // Insert element
          highlightedIndex = index;
          currentAlgorithm = """
Algorithm for Insert:
1. Select the index.
2. Insert the value at the selected index.
3. Shift the remaining elements.
""";
          currentOperation = "Inserted $value at index $index.";
        });
        await Future.delayed(Duration(milliseconds: 1500)); // Snackbar delay
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Inserted $value at index $index.'),
            duration: Duration(milliseconds: 1500), // Snackbar duration
          ),
        );
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {
          highlightedIndex = null;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid index or max size reached'),
          duration: Duration(milliseconds: 1500), // Snackbar duration
        ),
      );
    }
  }

  // Delete value from the array with highlighting
  Future<void> _showDeleteDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Delete Value');
    if (value != null) {
      int index = array.indexOf(value);
      if (index != -1) {
        await _highlightInLoop(0, index); // Highlight until delete position
        setState(() {
          highlightedIndex = index;
          array.removeAt(index); // Remove element
          currentAlgorithm = """
Algorithm for Delete:
1. Find the value in the array.
2. Remove the value from the array.
""";
          currentOperation = "Deleted $value from the array.";
        });
        await Future.delayed(Duration(milliseconds: 1500)); // Snackbar delay
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Deleted $value from the array.'),
            duration: Duration(milliseconds: 1500), // Snackbar duration
          ),
        );
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {
          highlightedIndex = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Value not found in the array.'),
            duration: Duration(milliseconds: 1500), // Snackbar duration
          ),
        );
      }
    }
  }

  // Update a value in the array with highlighting
  Future<void> _showUpdateDialog(BuildContext context) async {
    int? index = await _showInputDialog(context, 'Update at Index');
    if (index != null && index >= 0 && index < array.length) {
      int? value = await _showInputDialog(context, 'New Value');
      if (value != null) {
        await _highlightInLoop(0, index); // Highlight until update position
        setState(() {
          highlightedIndex = index;
          array[index] = value; // Update element
          currentAlgorithm = """
Algorithm for Update:
1. Select the index.
2. Update the value at the selected index.
""";
          currentOperation = "Updated index $index to $value.";
        });
        await Future.delayed(Duration(milliseconds: 1500)); // Snackbar delay
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Updated index $index to $value.'),
            duration: Duration(milliseconds: 1500), // Snackbar duration
          ),
        );
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {
          highlightedIndex = null;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid index'),
          duration: Duration(milliseconds: 1500), // Snackbar duration
        ),
      );
    }
  }

  // Find index of a value in the array with highlighting
  Future<void> _showFindIndexDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Value to Find');
    if (value != null) {
      int index = array.indexOf(value);
      if (index != -1) {
        await _highlightInLoop(0, index); // Highlight until find position
        setState(() {
          highlightedIndex = index;
          currentAlgorithm = """
Algorithm for Find Index:
1. Search for the value in the array.
2. Return the index of the found value.
""";
          currentOperation = "Found $value at index $index.";
        });
        await Future.delayed(Duration(milliseconds: 1500)); // Snackbar delay
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Found $value at index $index.'),
            duration: Duration(milliseconds: 1500), // Snackbar duration
          ),
        );
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {
          highlightedIndex = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Value not found in the array.'),
            duration: Duration(milliseconds: 1500), // Snackbar duration
          ),
        );
      }
    }
  }

  // Function to show an input dialog and return the entered integer
  Future<int?> _showInputDialog(BuildContext context, String title) {
    TextEditingController controller = TextEditingController();
    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter a number'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(int.tryParse(controller.text));
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}











//Test



// Define your array-specific questions here
final List<Question> arrayQuestions = [
  Question(
    questionText: 'What is an array?',
    options: ['A data structure', 'A function', 'An operator', 'A loop'],
    correctAnswerIndex: 0,
  ),//1
  Question(
    questionText: 'How is an array accessed?',
    options: ['By index', 'By name', 'By function', 'By operator'],
    correctAnswerIndex: 0,
  ),//2
  Question(
    questionText: 'What is the time complexity of accessing an element in an array by index?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
    correctAnswerIndex: 0,
  ),//3
  Question(
    questionText: 'What is the disadvantage of arrays?',
    options: [
      'Fixed size',
      'Efficient memory usage',
      'Ease of access by index',
      'Faster than other data structures'
    ],
    correctAnswerIndex: 0,
  ),//4

  Question(
     questionText: 'What is the index of the first element in an array?',
    options: ['0', '1', '2', 'Depends on the language'],
    correctAnswerIndex: 0,
  ),//5

   Question(
    questionText: 'Which of the following is the correct way to declare an array in C?',
     options: ['int arr(10);', 'int arr[10];', 'arr{10};', 'array int arr[10];'],
     correctAnswerIndex: 1,
  ),//6

   Question(
    questionText: 'If int arr[5] = {10, 20, 30, 40, 50}; what is the value of arr[3]?',
     options: ['10', '20', '40', '50'],
     correctAnswerIndex: 2,
  ),//7

  Question(
    questionText: 'What is an array?',
    options: ['A collection of variables of different types stored at contiguous memory locations',
     ' A collection of variables of the same type stored at contiguous memory locations', 
     'A collection of variables of the same type stored randomly in memory', 
     'A collection of variables of different types stored randomly in memory'],
    correctAnswerIndex: 2,
  ),//8

  Question(
    questionText: 'How do you access the first element of an array in C/C++?',
    options: ['arr[1]', 'arr[0]', 'arr(1)', 'arr[2]'],
    correctAnswerIndex: 1,
  ),//9

  Question(
    questionText: 'Which of the following operations is not possible with arrays directly?',
    options: ['Insertion of an element at the beginning', 'Accessing an element at a specific index', 'Traversing the array', 'Sorting the array'],
    correctAnswerIndex: 0,
  ),//10

   Question(
    questionText: 'If int arr[4] = {11, 22, 30, 45}; what is the value of arr[3]?',
     options: ['11', '22', '30', '45'],
     correctAnswerIndex: 3,
  ),//11
   Question(
    questionText: 'Which of the following allows dynamic resizing in arrays?',
    options: ['Dynamic arrays', 'Static arrays', 'Both', 'None'],
    correctAnswerIndex: 0,
  ),//12

   Question(
    questionText: 'What is a multidimensional array?',
    options: [
      'Array with more than one dimension',
      'Array with one dimension',
      'Array without elements',
      'Array that cannot be resized'
    ],
    correctAnswerIndex: 0,
  ),//13

   Question(
     questionText: 'What is the time complexity of inserting an element at the end of an array?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
    correctAnswerIndex: 0,
  ),//14

   Question(
   questionText: 'How do you declare an array in most programming languages?',
    options: ['int[] arr;', 'int arr[];', 'arr[] int;', 'array of int'],
    correctAnswerIndex: 0,
  ),//15

   Question(
     questionText: 'What does it mean when an array is "zero-indexed"?',
    options: [
      'The first element is at index 0',
      'The array starts with a zero',
      'Array cannot hold any values',
      'Array contains only one element'
    ],
    correctAnswerIndex: 0,
  ),//16

   Question(
    questionText: 'If int arr[3] = {78,98,20}; what is the value of arr[1]?',
     options: ['78', '98', '20'],
     correctAnswerIndex: 2,
  ),//17

   Question(
     questionText: 'Which of the following is not a valid way to iterate through an array?',
    options: ['For loop', 'While loop', 'Do-while loop', 'Switch statement'],
    correctAnswerIndex: 3,
  ),//18

   Question(
    questionText: 'What is the time complexity of accessing an element in a 2D array?',
    options: ['O(1)', 'O(n)', 'O(n^2)', 'O(log n)'],
    correctAnswerIndex: 0,
  ),//19

   Question(
    questionText: 'Which of the following is not a valid way to iterate through an array?',
    options: ['For loop', 'While loop', 'Do-while loop', 'Switch statement'],
    correctAnswerIndex: 3,
  ),//20

   Question(
    questionText: 'How can you copy the contents of one array to another?',
    options: ['By loop', 'By function', 'By reference', 'All of the above'],
    correctAnswerIndex: 3,
  ),//21

   Question(
    questionText: 'If int arr[6] = {78,98,20,33,22,11}; what is the value of arr[5]?',
     options: ['78', '98', '20','11'],
     correctAnswerIndex: 3,
  ),//22

   Question(
    questionText: 'What is a jagged array?',
    options: [
      'An array with rows of different lengths',
      'An array with rows of the same length',
      'A type of stack',
      'A type of queue'
    ],
    correctAnswerIndex: 0,
  ),//23

   Question(
    questionText: 'How do you find the length of an array in most programming languages?',
    options: [ 'array.size', 'array.length','length(array)', 'size(array)'],
    correctAnswerIndex: 1,
  ),//24

   Question(
   questionText: 'What happens when you access an index that is out of bounds in an array?',
    options: [
      'An error occurs',
      'It returns the last element',
      'It returns the first element',
      'It returns null'
    ],
    correctAnswerIndex: 0,
  ),//25

  Question(
    questionText: 'Which of the following is a valid array operation?',
    options: ['Insertion', 'Deletion', 'Traversal', 'All of the above'],
    correctAnswerIndex: 3,
  ),//26

  Question(
    questionText: 'If int arr[5] = {1, 2, 3, 4, 5}; what will be the result of arr[5]?',
    options: ['5', '0', 'Runtime error or undefined behavior', 'Index out of bounds error'],
    correctAnswerIndex: 2,
  ),//27

  Question(
    questionText: 'Which of the following is not a feature of arrays?',
    options: [' Fixed size', 'Contiguous memory allocation', 'Store elements of different data types', ' Access time is O(1) by index'],
    correctAnswerIndex: 2,
  ),//28

  Question(
    questionText: 'Which of the following is a limitation of arrays?',
    options: ['Arrays allow access to elements by index', 'Arrays can store multiple values in one variable', 'Arrays have a fixed size once created', 'Arrays allow traversal of elements'],
    correctAnswerIndex: 2,
  ),//29

  Question(
    questionText: 'If int arr[4] = {1, 3, 4, 5}; what will be the result of arr[4]?',
    options:  ['5', '4', 'Runtime error or undefined behavior', 'Index out of bounds error'],
    correctAnswerIndex: 2,
  ),//30
];

class ArrayQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(arrayQuestions);
    String testId = 'Array'; 
    // String topicName = 'Array';
    return QuizUI(quizQuestions:randomQuestions , testId: testId); // Use the common UI
  }
}

// Future<void> submitTest(String quizId, int score) async {
//   // Assume testCollection is a reference to the Firebase collection
//   final testDocument = FirebaseFirestore.instance.collection('test').doc(userId);
  
//   await testDocument.update({
//     'test_id': FieldValue.arrayUnion([quizId]),
//     'marks': FieldValue.arrayUnion([score]),
//     'time': FieldValue.arrayUnion([DateTime.now().toString()]),
//   });
// }

// Usage
// submitTest('QZ001', 80); // For ArrayQuiz with a score of 80

// Question model