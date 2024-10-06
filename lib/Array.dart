import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'dart:math';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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


class PdfViewerPage extends StatelessWidget {
  final String assetPath;

  PdfViewerPage({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    print("Loading PDF from: $assetPath");
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 500)), // Delay to simulate loading
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            try {
              return SfPdfViewer.asset(assetPath);
            } catch (e) {
              return Center(
                child: Text(
                  'Error loading PDF. Please make sure the asset path is correct.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
// void main() {
//   runApp(ArrayVisualizer());
// }

class ArrayVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Array Visualizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArrayScreen(),
    );
  }
}

class ArrayScreen extends StatefulWidget {
  @override
  _ArrayScreenState createState() => _ArrayScreenState();
}

class _ArrayScreenState extends State<ArrayScreen> {
  List<int> array = []; // Array to hold elements

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mtext(),
      body: Column(
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
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          )
                        ]
                      : _buildArrayBars(),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _showAddDialog(context), // Add Button
                child: Text('Add Element'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () => _showUpdateDialog(context), // Update Button
                child: Text('Update Element'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: _removeElement, // Remove Button
                child: Text('Remove Last Element'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: _createDefaultArray, // Default Array Button
                child: Text('Create Default'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.teal),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // Build the visual representation of the array
  List<Widget> _buildArrayBars() {
    return List<Widget>.generate(array.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: AnimatedContainer(
          height: 100, // Fixed height for all bars
          width: 60,
          duration: Duration(milliseconds: 300),
          color: Colors.teal,
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

  // Add element to the array
  Future<void> _showAddDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Add Element');
    if (value != null) {
      setState(() {
        array.add(value); // Add element to the array
      });
    }
  }

  // Update element in the array
  Future<void> _showUpdateDialog(BuildContext context) async {
    int? index = await _showInputDialog(context, 'Index to Update');
    if (index != null && index >= 0 && index < array.length) {
      int? value = await _showInputDialog(context, 'New Value');
      if (value != null) {
        setState(() {
          array[index] = value; // Update element at the given index
        });
      }
    } else if (index != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid Index')),
      );
    }
  }

  // Remove the last element from the array
  void _removeElement() {
    setState(() {
      if (array.isNotEmpty) {
        array.removeLast(); // Remove last element
      }
    });
  }

  // Create a default array with some values
  void _createDefaultArray() {
    setState(() {
      array = [5, 15, 25, 35, 45]; // Default array values
    });
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
      appBar: AppBar(
        title: Text('Array Quiz'),
      ),
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
        ElevatedButton(
          onPressed: selectedAnswers.length == quizQuestions.length
              ? submitQuiz
              : null, // Enable button only if all questions are answered
          child: Text('Submit Quiz'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16.0),
            primary: Color.fromARGB(255, 167, 69, 167),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Score: $score / ${quizQuestions.length}',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: restartQuiz,
            child: Text('Restart Quiz'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16.0),
              primary: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}



