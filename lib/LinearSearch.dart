import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class LinearsearchNotes extends StatelessWidget {
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
      const url = 'assets/notes/Linear search.pdf';  // Relative path to the PDF
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


class LinearSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linear Search Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LinearSearchScreen(),
    );
  }
}

class LinearSearchScreen extends StatefulWidget {
  @override
  _LinearSearchScreenState createState() => _LinearSearchScreenState();
}

class _LinearSearchScreenState extends State<LinearSearchScreen> {
  List<int> array = []; // Initially empty array
  int? currentIndex; // For visual representation of current index
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
                            'Linear Search Visualizer',
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
      array = [10, 20, 30, 40]; // Default array
      currentIndex = null;
      currentAlgorithm = """
1. Start from the first element.
2. Compare the current element with the target value.
3. If a match is found, return the index.
4. If no match is found, continue to the next element.
5. Repeat until the target value is found or the end of the array is reached.
""";
      currentOutput = "Default array created.";
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      currentIndex = null;
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
        currentOutput = "Inserted $value into the array.";
      });
    }
  }

  // Show dialog to find the index of an element using linear search
  Future<void> _showFindValueDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Find Value');
    if (value != null) {
      await _linearSearch(value); // Perform linear search with animation
    }
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
          color: (index == currentIndex)
              ? Color.fromARGB(255, 85, 255, 227) // Highlight current index
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

  // Perform linear search with animation
  Future<void> _linearSearch(int value) async {
    searching = true;
    currentOutput = ""; // Clear previous output

    for (int i = 0; i < array.length; i++) {
      setState(() {
        currentIndex = i; // Highlight current index
        currentOutput += "Step ${i + 1}: Checking index $i\n"; // Update output
        currentOutput += "Current Value: ${array[i]}\n"; // Show current value
        currentOutput += "Comparing with target value: $value\n"; // Show comparison
      });
      await Future.delayed(Duration(seconds: 1)); // Pause for visual effect

      if (array[i] == value) {
        // Found the value
        setState(() {
          currentIndex = i; // Highlight found index
          currentOutput += "Match found!\n";
          currentOutput += "Value $value found at index $i.\n"; // Update output
        });
        await Future.delayed(Duration(seconds: 2));
        break;
      } else {
        currentOutput += "No match at index $i. Continuing search...\n"; // Update output for no match
      }
    }

    // Show result in a snackbar if not found
    if (currentIndex != null && array[currentIndex!] == value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$value found at index: $currentIndex'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$value not found in the array'),
        ),
      );
    }

    searching = false;
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

// List of questions (linear questions in data structure)
final List<Question> allQuestions = [
 Question(
  questionText: 'What is the time complexity of linear search in the best case?',
  options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of linear search in the worst case?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n log n)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of linear search in the average case?',
  options: ['O(n)', 'O(log n)', 'O(n^2)', 'O(1)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In which type of array does linear search work?',
  options: ['Sorted array', 'Unsorted array', 'Both sorted and unsorted array', 'None'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'What does the linear search algorithm do when the element is found?',
  options: ['Returns the index of the element', 'Continues searching', 'Throws an error', 'Stops the program'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Given an array [1, 4, 7, 9, 12], what will be the number of comparisons made when searching for 9 using linear search?',
  options: ['3', '4', '5', '2'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'Which of the following is true about linear search?',
  options: ['It requires the array to be sorted', 'It can be applied to both sorted and unsorted arrays', 'It works only on arrays', 'It is faster than binary search'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'What is returned if an element is not found during a linear search?',
  options: ['0', 'Null', '-1', 'The closest element'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'In the worst case, linear search has to traverse how many elements of an array?',
  options: ['All elements', 'Half of the elements', 'One element', 'None'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following is NOT a property of linear search?',
  options: ['It requires no additional space', 'It has O(n) time complexity', 'It can work on linked lists', 'It always runs in O(log n)'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'Linear search works for which of the following data structures?',
  options: ['Array', 'Linked List', 'Queue', 'All of the above'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'What is the best-case scenario for linear search?',
  options: ['Element is at the beginning of the array', 'Element is in the middle', 'Element is at the end', 'Element is not in the array'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How many comparisons will be made in the worst case for a linear search on an array of size 10?',
  options: ['10', '9', '1', '5'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which search algorithm is simpler to implement?',
  options: ['Linear search', 'Binary search', 'Both are equally complex', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following best describes the time complexity of linear search?',
  options: ['It grows linearly with the size of the array', 'It grows logarithmically with the size of the array', 'It remains constant regardless of array size', 'It grows quadratically with array size'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which condition terminates the linear search algorithm?',
  options: ['Element is found', 'All elements have been checked', 'Both of the above', 'None of the above'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'Linear search is also called:',
  options: ['Sequential search', 'Divide and conquer', 'Binary search', 'Exponential search'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following is true for linear search compared to binary search?',
  options: ['Linear search works on unsorted data', 'Linear search is faster than binary search', 'Linear search is only used for small datasets', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Given an array [3, 8, 10, 12], how many comparisons will be made when searching for 12 using linear search?',
  options: ['1', '2', '4', '3'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'The space complexity of linear search is:',
  options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following is the worst-case scenario for linear search?',
  options: ['Element is at the end of the array', 'Element is at the beginning', 'Element is in the middle', 'Array is sorted'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the advantage of linear search over binary search?',
  options: ['It works on unsorted data', 'It is always faster', 'It requires less memory', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a linear search, which element is compared first?',
  options: ['First element', 'Middle element', 'Last element', 'Random element'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Linear search is a brute-force algorithm. True or False?',
  options: ['True', 'False'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Linear search can be applied to which of the following data structures?',
  options: ['Array', 'Linked List', 'Both array and linked list', 'None'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'How does linear search differ from binary search?',
  options: ['Linear search does not require sorted data', 'Linear search is faster', 'Linear search uses more memory', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Linear search is used in which of the following applications?',
  options: ['Small datasets', 'Unsorted arrays', 'Linked lists', 'All of the above'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'Linear search makes how many comparisons in the average case for an array of size n?',
  options: ['n/2', 'log n', 'n', '1'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a linear search on a linked list, which of the following is true?',
  options: ['Elements are checked one by one', 'Elements are checked in pairs', 'Elements are checked using indices', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How many comparisons are required for a linear search in the worst case for an array of size 20?',
  options: ['20', '10', '5', '1'],
  correctAnswerIndex: 0,
),


];

// void main() => runApp(QuizApp());

class LinearSearchQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinearSearch Quiz',
      debugShowCheckedModeBanner: false,
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBack(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isSubmitted ? buildResultScreen() : buildQuizBody(),
        ),
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