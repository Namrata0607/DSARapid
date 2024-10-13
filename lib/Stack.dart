import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'dart:math';


class StackVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Visualizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StackScreen(),
    );
  }
}

class StackScreen extends StatefulWidget {
  @override
  _StackScreenState createState() => _StackScreenState();
}

class _StackScreenState extends State<StackScreen> {  
  List<int> stack = []; // Stack to hold elements
  int? topIndex; // For visual representation of the top of the stack
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Visualizer'),
        backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: stack.isEmpty
                      ? [
                          Text(
                            'Stack is empty',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          )
                        ]
                      : _buildStackBars(),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _createDefaultStack, // Create Default Button
                child: Text('Create Default'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: _clearStack, // Clear Button
                child: Text('Clear'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () => _showPushDialog(context), // Push Button
                child: Text('Push'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: stack.isEmpty ? null : _popElement, // Pop Button
                child: Text('Pop'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: stack.isEmpty ? null : _peekElement, // Peek Button
                child: Text('Peek'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
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

  // Build the visual representation of the stack
  List<Widget> _buildStackBars() {
    return List<Widget>.generate(stack.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: AnimatedContainer(
          height: 100, // Fixed height for all bars
          width: 60,
          duration: Duration(milliseconds: 300),
          color: (index == topIndex) ? Colors.red : Colors.purple, // Top element highlighted
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Text(
              stack[index].toString(),
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

  // Push element onto the stack
  Future<void> _showPushDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Push Value');
    if (value != null) {
      setState(() {
        stack.add(value); // Add element to stack
        topIndex = stack.length - 1; // Update top index
      });
    }
  }

  // Pop element from the stack
  void _popElement() {
    setState(() {
      if (stack.isNotEmpty) {
        stack.removeLast(); // Remove top element
        topIndex = stack.isNotEmpty ? stack.length - 1 : null; // Update top index
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Top element popped'),
      ),
    );
  }

  // Peek at the top element of the stack
  void _peekElement() {
    if (stack.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Top element: ${stack.last}'),
        ),
      );
    }
  }

  // Create a default stack with some values
  void _createDefaultStack() {
    setState(() {
      stack = [10, 20, 30, 40, 50]; // Default stack values
      topIndex = stack.length - 1; // Set top index
    });
  }

  // Clear the stack
  void _clearStack() {
    setState(() {
      stack = []; // Clear the stack
      topIndex = null; // Reset top index
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

// List of questions (Stack questions in data structure)
final List<Question> allQuestions = [
 Question(
    questionText: 'What is the time complexity for pushing an element onto a stack?',
    options: ['O(n)', 'O(log n)', 'O(1)', 'O(n log n)'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What is the primary data structure used to implement a stack?',
    options: ['Queue', 'Linked List', 'Array', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'Which of the following operations is not a valid stack operation?',
    options: ['Push', 'Pop', 'Peek', 'Insert'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'What is the last element that can be accessed in a stack data structure?',
    options: ['First element', 'Middle element', 'Last element', 'Top element'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'If a stack is implemented using an array, what happens if you try to push an element onto a full stack?',
    options: ['Underflow', 'Overflow', 'Stack is unchanged', 'Program crash'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which of the following is true about a stack?',
    options: ['It is a FIFO structure', 'It is a LIFO structure', 'It can grow in any direction', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What does the pop operation do in a stack?',
    options: ['Adds an element to the stack', 'Removes the top element', 'Returns the top element', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which operation is used to view the top element of a stack without removing it?',
    options: ['Pop', 'Peek', 'Push', 'Top'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'For an array-based implementation of a stack, which variable typically indicates the current top of the stack?',
    options: ['Size', 'Top', 'Count', 'Length'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What will happen if you call pop on an empty stack?',
    options: ['Returns null', 'Throws an exception', 'Returns 0', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Given the stack operations: Push(1), Push(2), Pop(), Push(3), what will the top element be?',
    options: ['1', '2', '3', 'Empty'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What is the maximum number of elements in a stack of size n?',
    options: ['n', 'n-1', 'n+1', '2n'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'If you have the following operations on an empty stack: Push(5), Push(10), Pop(), Push(20), what will the top element be?',
    options: ['5', '10', '20', 'Empty'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What type of problems can be solved using stacks?',
    options: ['Expression evaluation', 'Backtracking algorithms', 'Parenthesis matching', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'In which scenario would you use a stack data structure?',
    options: ['Undo functionality in text editors', 'Storing a list of items', 'Priority scheduling', 'None of the above'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'How would you check if a stack is empty?',
    options: ['Check if the top is null', 'Check if the size is 0', 'Both A and B', 'None of the above'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'For a stack with elements [1, 2, 3], what will be the state of the stack after performing a pop operation?',
    options: ['[1, 2, 3]', '[2, 3]', '[3]', '[]'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What is the result of performing Push(10), Push(20), Pop(), Push(30) on an empty stack?',
    options: ['10', '20', '30', '10, 30'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'If the stack is implemented using a linked list, how are the elements stored?',
    options: ['In contiguous memory locations', 'In non-contiguous memory locations', 'In a fixed size array', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What will be the contents of a stack after performing Push(5), Push(10), Push(15), Pop()?',
    options: ['[5, 10]', '[5, 10, 15]', '[10, 15]', '[15, 10, 5]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'In a stack, which of the following is not a method that is typically implemented?',
    options: ['Push', 'Pop', 'Peek', 'Merge'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'Which of the following statements is true about stacks?',
    options: ['Stacks are dynamic in size', 'Stacks can be implemented using arrays only', 'Stacks can hold duplicate elements', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'For a stack that can hold a maximum of 5 elements, what happens if you try to push the 6th element?',
    options: ['The 6th element is added', 'The stack will grow in size', 'Overflow error occurs', 'None of the above'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'How is the stack data structure categorized?',
    options: ['Linear', 'Non-linear', 'Both A and B', 'None of the above'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'What is the space complexity of a stack implemented using a linked list?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What data structure can be used to reverse a string?',
    options: ['Queue', 'Stack', 'Array', 'Tree'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What will be the output after performing these operations: Push(1), Push(2), Push(3), Pop(), Pop() on an empty stack?',
    options: ['1', '2', '3', '0'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which of the following can cause stack overflow?',
    options: ['Infinite recursion', 'Excessive stack push operations', 'Large data structures', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'If a stack contains elements [A, B, C, D] (with D at the top), what will be the result of performing two pops?',
    options: ['[A, B, C]', '[B, C, D]', '[A, B, C, D]', '[C, D]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'How would you implement a stack using two queues?',
    options: ['Using one queue for push and another for pop', 'Using one queue for pop and another for push', 'Using both queues for both push and pop', 'Not possible'],
    correctAnswerIndex: 0,
),
];

// void main() => runApp(QuizApp());

class StackQuiz extends StatelessWidget {
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
        title: Text('Stack Quiz'),
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
