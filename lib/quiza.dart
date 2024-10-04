import 'package:flutter/material.dart';
import 'dart:math'; // Import for randomness

// void main() {
//   runApp(QuizApp());
// }

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizHome(),
    );
  }
}

class QuizHome extends StatefulWidget {
  @override
  _QuizHomeState createState() => _QuizHomeState();
}

class _QuizHomeState extends State<QuizHome> {
  // List of questions and options
  List<Map<String, Object>> _questions = [
    {
      'questionText': 'Which of the following is the correct way to declare an array in C?',
      'options': ['int arr(10);', 'int arr[10];', 'arr{10};', 'array int arr[10];'],
      'answer': 'int arr[10];',
    },
    {
      'questionText': 'If int arr[5] = {10, 20, 30, 40, 50}; what is the value of arr[3]?',
      'options': ['10', '20', '40', '50'],
      'answer': '40',
    },
    {
      'questionText': 'What is an array?',
      'options': ['A collection of variables of different types stored at contiguous memory locations', ' A collection of variables of the same type stored at contiguous memory locations', 'A collection of variables of the same type stored randomly in memory', 'A collection of variables of different types stored randomly in memory'],
      'answer': 'A collection of variables of the same type stored at contiguous memory locations',
    },
    {
      'questionText': 'How do you access the first element of an array in C/C++?',
      'options': ['arr[1]', 'arr[0]', 'arr(1)', 'arr[2]'],
      'answer': 'arr[0]',
    },
    {
      'questionText': 'Which of the following operations is not possible with arrays directly?',
      'options': ['Insertion of an element at the beginning', 'Accessing an element at a specific index', 'Traversing the array', 'Sorting the array'],
      'answer': 'Insertion of an element at the beginning',
    },
    {
      'questionText': 'If int arr[5] = {1, 2, 3, 4, 5}; what will be the value of arr[2]?',
      'options': ['1', '2', '5', '3'],
      'answer': '3',
    },

    {
      'questionText': 'Which of the following is a limitation of arrays?',
      'options': ['Arrays allow access to elements by index', 'Arrays can store multiple values in one variable', 'Arrays have a fixed size once created', 'Arrays allow traversal of elements'],
      'answer': ' Arrays have a fixed size once created',
    },

    {
      'questionText': 'If int arr[5] = {1, 2, 3, 4, 5}; what will be the result of arr[5]?',
      'options': ['5', '0', 'Runtime error or undefined behavior', 'Index out of bounds error'],
      'answer': 'Runtime error or undefined behavior',
    },

    {
      'questionText': 'Which of the following is not a feature of arrays?',
      'options': [' Fixed size', 'Contiguous memory allocation', 'Store elements of different data types', ' Access time is O(1) by index'],
      'answer': 'Store elements of different data types',
    },

    {
      'questionText': 'If int arr[4] = {11, 22, 30, 40}; what will be the value of arr[3]?',
      'options': ['11', '30', '40', '22'],
      'answer': '40',
    },
  ];

  // Track user's answers
  final Map<int, String> _selectedAnswers = {};

  // Track score
  int _score = 0;

  @override
  void initState() {
    super.initState();
    _shuffleQuestions(); // Shuffle questions at the start of the quiz
  }

  // Function to shuffle questions
  void _shuffleQuestions() {
    _questions.shuffle(Random());
  }

  // Calculate score
  void _calculateScore() {
    _score = 0;
    _selectedAnswers.forEach((index, answer) {
      if (_questions[index]['answer'] == answer) {
        _score++;
      }
    });
  }

  // Show score
  void _showScore(BuildContext context) {
    // Check if all questions are answered
    if (_selectedAnswers.length != _questions.length) {
      // Show alert dialog for unanswered questions
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Incomplete'),
          content: Text('Please answer all questions before submitting.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
      return; // Exit the function if not all questions are answered
    }

    _calculateScore();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Your Score'),
        content: Text('You scored $_score out of ${_questions.length}'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                _selectedAnswers.clear(); // Reset answers for a new attempt
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
      ),
      body: _buildQuiz(),
    );
  }

  Widget _buildQuiz() {
    return ListView.builder(
      itemCount: _questions.length + 1,
      itemBuilder: (ctx, index) {
        if (index == _questions.length) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Submit'),
              onPressed: () => _showScore(context),
            ),
          );
        }

        return _buildQuestionCard(index);
      },
    );
  }

  Widget _buildQuestionCard(int questionIndex) {
    final question = _questions[questionIndex]['questionText'] as String;
    final options = _questions[questionIndex]['options'] as List<String>;

    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...options.map((option) {
              return RadioListTile(
                title: Text(option),
                value: option,
                groupValue: _selectedAnswers[questionIndex],
                onChanged: (value) {
                  setState(() {
                    _selectedAnswers[questionIndex] = value as String;
                  });
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
