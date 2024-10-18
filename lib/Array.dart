import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:math';
import 'dart:html' as html;
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:ui' as ui;     // Correct import for platformViewRegistry in Flutter Web
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart'; 


// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';


// void main() => runApp(MyApp());
// class PdfViewerPage extends StatelessWidget {
//   final String assetPath;

//   PdfViewerPage({required this.assetPath});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//         backgroundColor: Colors.purple,
//       ),
//       body: SfPdfViewer.asset(assetPath),
//     );
//   }
// }

// class PdfViewerPage extends StatelessWidget {
//   final String assetPath;

//   const PdfViewerPage({required this.assetPath});

//   @override
//   Widget build(BuildContext context) {
//     print("Loading PDF from: $assetPath");
//     return Scaffold(
//       appBar: appBack(context), // Use the appBack function for back navigation
//       body: SfPdfViewer.asset(assetPath), // Load the PDF from the provided path
//     );
//   }
// }

// class PdfViewerPage extends StatelessWidget {
//   final String assetPath;

//   PdfViewerPage({required this.assetPath});

//   @override
//   Widget build(BuildContext context) {
//     print("Loading PDF from: $assetPath");
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//         backgroundColor: Colors.purple,
//       ),
//       body: FutureBuilder(
//         future: Future.delayed(Duration(milliseconds: 500)), // Replace with your actual future
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text(
//                 'Error: ${snapshot.error}',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 18, color: Colors.red),
//               ),
//             );
//           } else {
//             try {
//               return SfPdfViewer.asset(assetPath);
//             } catch (e) {
//               return Center(
//                 child: Text(
//                   'Error loading PDF. Please make sure the asset path is correct.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(fontSize: 18, color: Colors.red),
//                 ),
//               );
//             }
//           }
//         },
//       ),


//     );
//   }
// }


//pdf final

// void main() {
//   runApp(MyApp());
// }

// import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class ArrayNotes extends StatelessWidget {
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
      const url = 'assets/notes/array.pdf';  // Relative path to the PDF
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

//visualizer

// void main() {
//   runApp(ArrayVisualizer());
// }
class ArrayVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Array Operations Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  String currentAlgorithm = ""; // Holds static algorithm for the current operation
  bool isProcessing = false;

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
                                    color: Colors.purple,
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
                        Text(
                          'Array Visualizer',
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
                                                    : Color.fromARGB(
                                                        255, 175, 87, 160),
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
                  onPressed: () => _showDeleteDialog(context),
                  child: Text('Delete'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showUpdateDialog(context),
                  child: Text('Update'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showFindIndexDialog(context),
                  child: Text('Find Index'),
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
      await Future.delayed(Duration(seconds: 1));
    }
  }

  // Insert value into the array step-by-step with highlighting
  Future<void> _showInsertDialog(BuildContext context) async {
    int? index = await _showInputDialog(context, 'Insert at Index');
    if (index != null && index >= 0 && index <= array.length) {
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
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {
          highlightedIndex = null;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid index'),
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
          array.removeAt(index); // Remove element
          currentAlgorithm = """
Algorithm for Delete:
1. Find the index of the value.
2. Remove the element at that index.
3. Shift the remaining elements.
""";
          currentOperation = "Deleted $value from index $index.";
          highlightedIndex = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Value not found'),
          ),
        );
      }
    }
  }

  // Show dialog for updating an array element at a specific index
  Future<void> _showUpdateDialog(BuildContext context) async {
    int? index = await _showInputDialog(context, 'Update Index');
    if (index != null && index >= 0 && index < array.length) {
      int? value = await _showInputDialog(context, 'New Value');
      if (value != null) {
        await _highlightInLoop(0, index); // Highlight until update position
        setState(() {
          array[index] = value; // Update element at index
          highlightedIndex = index;
          currentAlgorithm = """
Algorithm for Update:
1. Find the index of the element.
2. Update the value at the selected index.
""";
          currentOperation = "Updated index $index to $value.";
        });
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {
          highlightedIndex = null;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid index'),
        ),
      );
    }
  }

  // Show dialog to find the index of an element
  Future<void> _showFindIndexDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Find Index of Value');
    if (value != null) {
      await _highlightInLoop(0, array.length - 1);
      int index = array.indexOf(value);
      setState(() {
        highlightedIndex = index;
        currentAlgorithm = """
Algorithm for Find:
1. Iterate through the array.
2. Compare each element to the target value.
3. Return the index if found.
""";
        currentOperation = index >= 0
            ? 'Element found at index: $index'
            : 'Element not found';
      });
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        highlightedIndex = null;
      });
    }
  }

  // Generalized input dialog to get user input
  Future<int?> _showInputDialog(BuildContext context, String title) async {
    final TextEditingController controller = TextEditingController();

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
      },
    );
  }
}


//Test


// Question model
class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

// Function to generate random questions
List<Question> getRandomQuestions(List<Question> allQuestions) {
  var random = Random();
  List<Question> selectedQuestions = [];
  while (selectedQuestions.length < 10) {
    Question question = allQuestions[random.nextInt(allQuestions.length)];
    if (!selectedQuestions.contains(question)) {
      selectedQuestions.add(question);
    }
  }
  return selectedQuestions;
}

// List of questions (array questions in data structure)
final List<Question> allQuestions = [
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

// void main() => runApp(QuizApp());

class ArrayQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Array Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> quizQuestions = [];
  Map<int, int> selectedAnswers = {};
  bool isSubmitted = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
    quizQuestions = getRandomQuestions(allQuestions); // Get random 5 questions
  }

  void handleAnswer(int questionIndex, int answerIndex) {
    setState(() {
      selectedAnswers[questionIndex] = answerIndex;
    });
  }

  void submitQuiz() {
    setState(() {
      score = 0;
      for (var i = 0; i < quizQuestions.length; i++) {
        if (selectedAnswers[i] == quizQuestions[i].correctAnswerIndex) {
          score++;
        }
      }
      isSubmitted = true;
    });
  }

  void restartQuiz() {
    setState(() {
      isSubmitted = false;
      score = 0;
      selectedAnswers.clear();
      quizQuestions = getRandomQuestions(allQuestions);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBack(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isSubmitted ? buildResultScreen() : buildQuizBody(),
      ),
    );
  }

  Widget buildQuizBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Answer all questions:',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: quizQuestions.length,
            itemBuilder: (context, index) {
              return buildQuestionCard(index);
            },
          ),
        ),
        Center(
          child: SizedBox(
            width: 600,
            height: 60,
            child: ElevatedButton(
              onPressed: selectedAnswers.length == quizQuestions.length
                  ? submitQuiz
                  : null, // Enable button only if all questions are answered
              child: Text('Submit Quiz',
              style: TextStyle(
                fontSize: 20
              ),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0), 
                backgroundColor: Color.fromARGB(255, 105, 1, 161),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildQuestionCard(int questionIndex) {
    Question question = quizQuestions[questionIndex];
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${questionIndex + 1}. ${question.questionText}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...question.options.asMap().entries.map((entry) {
              int optionIndex = entry.key;
              String optionText = entry.value;
              return RadioListTile<int>(
                title: Text(optionText),
                value: optionIndex,
                groupValue: selectedAnswers[questionIndex],
                onChanged: (value) {
                  handleAnswer(questionIndex, value!);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildResultScreen() {
  return Center(
    child: SizedBox(
      height: 300,
      width: 400,
      child: Card(
        elevation: 8.0, // Adds shadow effect
        color: Color.fromARGB(255, 244, 224, 255),
        shape: RoundedRectangleBorder(
          
          borderRadius: BorderRadius.circular(15.0), // Rounded corners
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0), // Adds padding inside the card
          child: Column( 
            mainAxisSize: MainAxisSize.min, // Keeps the card size minimal
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Score: $score / ${quizQuestions.length}',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 180,
                child: ElevatedButton(
                  onPressed: restartQuiz,
                  child: Text('Restart Quiz',
                  style: TextStyle(
                    fontSize: 18
                  ),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16.0),
                    backgroundColor: Color.fromARGB(255, 105, 1, 161),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: 180,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your navigation or action for the second button
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );// For example, go back to the main menu
                  },
                  child: Text('Quit Quiz',
                  style: TextStyle(
                    fontSize: 18,
                  ),),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16.0),
                    backgroundColor: Color.fromARGB(255, 105, 1, 161), 
                    foregroundColor: Colors.white,
                  ),
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



