import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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

// List of questions (Singly linked list questions in data structure)
final List<Question> allQuestions = [
Question(
  questionText: 'What is the time complexity to insert a new node at the beginning of a singly linked list?',
  options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to insert a new node at the end of a singly linked list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the structure of a node in a singly linked list?',
  options: ['Data and one pointer to the next node', 'Data and two pointers to the next and previous nodes', 'Only data', 'Only pointer'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to access an element at the nth position in a singly linked list?',
  options: ['O(n)', 'O(1)', 'O(n log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a singly linked list, how do you traverse the list?',
  options: ['Start from the head and move through each node using the next pointer', 'Start from the tail and move backwards', 'Access the middle node and move in both directions', 'All of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you check if a singly linked list is empty?',
  options: ['Check if the head is null', 'Check if the tail is null', 'Check if the next pointer is null', 'Check if all nodes have data'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of deleting the first node in a singly linked list?',
  options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which operation is not possible in a singly linked list?',
  options: ['Deleting a node', 'Traversing the list', 'Reversing the list', 'Accessing the previous node from a given node'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'How do you reverse a singly linked list?',
  options: ['By changing the next pointers of each node in the list', 'By swapping data between nodes', 'By creating a new linked list', 'By using a queue'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to reverse a singly linked list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Given a singly linked list, what is the time complexity to find the length of the list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the head of a singly linked list?',
  options: ['The first node', 'The last node', 'The middle node', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What does the next pointer in the last node of a singly linked list point to?',
  options: ['Null', 'Head', 'The second node', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens when you try to access an element beyond the length of a singly linked list?',
  options: ['Returns null', 'Throws an error', 'Returns the last element', 'Returns the first element'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'What is the space complexity of a singly linked list with n nodes?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is a common use case for a singly linked list?',
  options: ['Dynamic memory allocation', 'Binary search implementation', 'Stack implementation', 'None of the above'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'How do you add a node after a specific node in a singly linked list?',
  options: ['Update the next pointer of the specific node to point to the new node', 'Update the previous node\'s pointer', 'Swap the data', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following is NOT a valid operation in a singly linked list?',
  options: ['Insert at the beginning', 'Delete from the middle', 'Access by index in O(1)', 'Traverse through all nodes'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'In a singly linked list, what will happen if you remove the last node?',
  options: ['The second last node’s next pointer will be set to null', 'The list will break', 'The first node will be removed', 'All nodes will be deleted'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following data structures can be implemented using a singly linked list?',
  options: ['Stack', 'Queue', 'Both Stack and Queue', 'Binary Tree'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'How do you insert a new node at the end of a singly linked list?',
  options: ['Traverse the list to the last node and update its next pointer', 'Insert it at the head', 'Swap it with the middle node', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you check if a singly linked list has a cycle?',
  options: ['Use two pointers (slow and fast)', 'Check if the head is null', 'Check if all nodes have the same data', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to search for an element in a singly linked list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Given a singly linked list, what will be the next node after head in a list [10 -> 20 -> 30 -> 40]?',
  options: ['20', '30', '40', 'None'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens if you delete the head of a singly linked list?',
  options: ['The second node becomes the new head', 'The list is destroyed', 'All nodes are deleted', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the last node of a singly linked list typically called?',
  options: ['Tail', 'Head', 'Middle', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following operations is slow in a singly linked list compared to an array?',
  options: ['Accessing elements by index', 'Inserting at the head', 'Inserting at the tail', 'All of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you detect the middle element of a singly linked list?',
  options: ['Use two pointers (slow and fast)', 'Traverse the list twice', 'Use the head pointer', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens when you try to access the tail’s next pointer in a singly linked list?',
  options: ['It points to null', 'It points to the head', 'It points to the second last node', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the advantage of a singly linked list over an array?',
  options: ['Dynamic size allocation', 'Constant time access to elements', 'Less memory usage', 'None of the above'],
  correctAnswerIndex: 0,
),
];

//void main() => runApp(QuizApp());

class SinglylinkedlistQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Singly linked list Quiz',
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
        title: Text('Singly Linked List Quiz'),
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



