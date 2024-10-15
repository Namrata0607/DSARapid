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
  questionText: 'What is a doubly linked list?',
  options: ['A list where each node has two pointers', 'A list with one pointer per node', 'A circular list', 'A list with no pointers'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What are the advantages of using a doubly linked list over a singly linked list?',
  options: ['Easier to traverse backwards', 'Easier to insert and delete nodes', 'Both A and B', 'None of the above'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'What is the time complexity to insert a new node at the beginning of a doubly linked list?',
  options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to delete a node from a doubly linked list?',
  options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a doubly linked list, what does the next pointer in a node point to?',
  options: ['The next node in the list', 'The previous node', 'Null', 'The head node'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a doubly linked list, what does the previous pointer in the head node point to?',
  options: ['Null', 'The tail node', 'The next node', 'The middle node'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to search for an element in a doubly linked list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you traverse a doubly linked list in reverse?',
  options: ['Use the previous pointer', 'Use the next pointer', 'Start from the head', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following operations can be performed on a doubly linked list?',
  options: ['Insertion', 'Deletion', 'Traversal', 'All of the above'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'What is the space complexity of a doubly linked list with n nodes?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you insert a new node at the end of a doubly linked list?',
  options: ['Traverse to the last node and update its pointers', 'Insert at the head', 'Use the middle node', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens when you delete the tail node of a doubly linked list?',
  options: ['The second last node’s next pointer will be set to null', 'The list becomes empty', 'The head node will be removed', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you find the length of a doubly linked list?',
  options: ['Traverse the list and count nodes', 'Use the head pointer', 'All nodes have fixed sizes', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the main disadvantage of a doubly linked list?',
  options: ['More memory usage due to extra pointers', 'Slower traversal', 'More complex implementation', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following is true about the first node in a doubly linked list?',
  options: ['It has a null previous pointer', 'It has a null next pointer', 'Both A and B', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you delete a specific node in a doubly linked list?',
  options: ['Update the next and previous pointers of adjacent nodes', 'Set the node’s next pointer to null', 'Set the node’s previous pointer to null', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens if you try to access a node that is out of bounds in a doubly linked list?',
  options: ['Returns null', 'Throws an error', 'Returns the head', 'Returns the tail'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'What is a common application of doubly linked lists?',
  options: ['Undo functionality in applications', 'Implementation of stacks', 'Queue operations', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which pointer in a doubly linked list is used to traverse forward?',
  options: ['Next pointer', 'Previous pointer', 'Both pointers', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you detect a cycle in a doubly linked list?',
  options: ['Use two pointers (slow and fast)', 'Check the previous pointer', 'Use a hash table', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a doubly linked list, which pointer is updated when a new node is inserted at the beginning?',
  options: ['Both previous and next pointers of the new node', 'Only the next pointer', 'Only the previous pointer', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the result of deleting the head node in a doubly linked list?',
  options: ['The second node becomes the new head', 'The list remains unchanged', 'All nodes are deleted', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which operation is NOT efficient in a doubly linked list?',
  options: ['Accessing elements by index', 'Inserting at the beginning', 'Inserting at the end', 'Traversing the list'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Given a doubly linked list, what will be the previous node of the head in a list [10 <-> 20 <-> 30]?',
  options: ['20', '30', 'Null', 'None of the above'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'How do you implement a doubly linked list in memory?',
  options: ['Using nodes with two pointers', 'Using arrays', 'Using stacks', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of reversing a doubly linked list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What type of traversal can you perform on a doubly linked list?',
  options: ['Forward only', 'Backward only', 'Both forward and backward', 'None of the above'],
  correctAnswerIndex: 2,
),
];

//void main() => runApp(QuizApp());

class DoublylinkedlistQuiz extends StatelessWidget {
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
        title: Text('Doubly Linked List Quiz'),
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



