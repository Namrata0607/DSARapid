import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'dart:math';
import 'package:flutter/material.dart';

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

//Questions 
final List<Question> allQuestions = [
  Question(
    questionText: 'What is a priority queue?',
    options: [
      'A queue where elements are processed in the order they arrive',
      'A queue where each element has a priority, and higher priority elements are dequeued first',
      'A queue where elements can only be dequeued in reverse order',
      'A queue where elements are processed alphabetically'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which data structure is commonly used to implement a priority queue?',
    options: [
      'Array',
      'Linked list',
      'Heap',
      'Stack'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the time complexity of insertion in a priority queue using a binary heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'In a priority queue, which element is dequeued first?',
    options: [
      'The element with the highest priority',
      'The element with the lowest priority',
      'The element that was added last',
      'The element with the middle priority'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity of deleting the maximum (or minimum) element in a priority queue implemented with a heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  
  Question(
    questionText: 'What is the best data structure for implementing a priority queue when frequent access to the highest-priority element is required?',
    options: [
      'Stack',
      'Binary heap',
      'Queue',
      'Linked list'
    ],
    correctAnswerIndex: 1,
  ),

  Question(
    questionText: 'Which of the following is an application of priority queues?',
    options: [
      'Job scheduling in operating systems',
      'Breadth-first search',
      'Quick sort',
      'Depth-first search'
    ],
    correctAnswerIndex: 0,
  ),
  

  Question(
    questionText: 'How is the priority determined in a priority queue?',
    options: [
      'By the order of insertion',
      'By a predefined comparison of elements',
      'By the user input during insertion',
      'Randomly'
    ],
    correctAnswerIndex: 1,
  ),

  Question(
    questionText: 'What is a major advantage of a priority queue over a regular queue?',
    options: [
      'It is faster for enqueuing operations',
      'It allows elements to be dequeued based on their priority rather than their order of arrival',
      'It can store more elements',
      'It requires less memory'
    ],
    correctAnswerIndex: 1,
  ),

  Question(
    questionText: 'Which operation is faster in a binary heap compared to a sorted array?',
    options: [
      'Insert',
      'Find max',
      'Delete max',
      'Traversal'
    ],
    correctAnswerIndex: 0,
  ),

  Question(
    questionText: 'Which operation is used to remove the highest-priority element from a priority queue?',
    options: [
      'Delete',
      'Dequeue',
      'Extract',
      'Pop'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is the most efficient way to implement a priority queue with frequent insertions?',
    options: [
      'Sorted array',
      'Unsorted array',
      'Binary heap',
      'Linked list'
    ],
    correctAnswerIndex: 2,
  ),
  
  Question(
    questionText: 'In which of the following scenarios is a priority queue most useful?',
    options: [
      'Sorting data in ascending order',
      'Finding the median of a set of elements',
      'Managing job scheduling tasks',
      'Performing depth-first search'
    ],
    correctAnswerIndex: 2,
  ),
  
  Question(
    questionText: 'In a priority queue, what is the time complexity of inserting an element when implemented using an unsorted array?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the primary difference between a regular queue and a priority queue?',
    options: [
      'Regular queues are faster than priority queues',
      'Priority queues process elements based on priority rather than order of insertion',
      'Regular queues can only store integers',
      'Priority queues allow duplicates while regular queues do not'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What happens if two elements have the same priority in a priority queue?',
    options: [
      'One element is discarded',
      'Both elements are removed at once',
      'The order of insertion is preserved (FIFO)',
      'They cannot be inserted into the queue'
    ],
    correctAnswerIndex: 2,
  ),

  Question(
    questionText: 'Which of the following can be used to implement a priority queue with a time complexity of O(1) for insertion?',
    options: [
      'Binary heap',
      'Fibonacci heap',
      'Sorted array',
      'Unsorted linked list'
    ],
    correctAnswerIndex: 3,
  ),
];



//void main() => runApp(QuizApp());

class PriorityqueueQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Queue Quiz',
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
            padding: EdgeInsets.all(16.0), backgroundColor: Color.fromARGB(255, 167, 69, 167),
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



