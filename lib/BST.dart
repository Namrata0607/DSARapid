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

// List of questions (Binary Tree questions in data structure)
final List<Question> allQuestions = [
  Question(
    questionText: 'What is a binary search tree?',
    options: [
      'A binary tree where the left child is greater than the parent node',
      'A binary tree where the left child is less than the parent node',
      'A binary tree where all nodes have two children',
      'A binary tree that is not sorted'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which property must a binary search tree satisfy?',
    options: [
      'The left subtree must be a binary search tree, and the right subtree must be a binary search tree',
      'The height of left and right subtrees must be equal',
      'All nodes must have exactly two children',
      'The tree must be a complete binary tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity of searching for an element in a balanced binary search tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How do you insert an element into a binary search tree?',
    options: [
      'Insert it as a left child if it is smaller than the root, or as a right child if it is larger',
      'Always insert at the root',
      'Insert it at any available position',
      'Insert it as the last child'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity for deleting an element from a balanced binary search tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What traversal method results in sorted order for a binary search tree?',
    options: [
      'Pre-order',
      'In-order',
      'Post-order',
      'Level-order'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the height of a binary search tree with only one node?',
    options: [
      '0',
      '1',
      '2',
      'It depends on the tree structure'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following operations requires O(n) time complexity in the worst case for a binary search tree?',
    options: [
      'Insertion',
      'Searching',
      'Deletion',
      'All of the above'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What happens when you delete a node with two children in a binary search tree?',
    options: [
      'You replace it with the largest node in its left subtree',
      'You replace it with the smallest node in its right subtree',
      'You simply remove it',
      'You cannot delete it'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is a balanced binary search tree?',
    options: [
      'AVL tree',
      'Red-Black tree',
      'Both AVL tree and Red-Black tree',
      'None of the above'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the worst-case height of an unbalanced binary search tree?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which traversal method visits the nodes in the order of root, left, right for a binary search tree?',
    options: [
      'In-order',
      'Pre-order',
      'Post-order',
      'Level-order'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the successor of a node in a binary search tree?',
    options: [
      'The largest node in the left subtree',
      'The smallest node in the right subtree',
      'The parent node',
      'The node with the maximum value'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How do you find the minimum value in a binary search tree?',
    options: [
      'By traversing to the rightmost node',
      'By traversing to the leftmost node',
      'By checking the root node only',
      'By traversing all nodes'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity for searching an element in a skewed binary search tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the difference between a binary tree and a binary search tree?',
    options: [
      'A binary search tree is a binary tree that maintains a specific order',
      'A binary tree can have multiple children',
      'A binary tree does not allow duplicate values',
      'A binary search tree can have any structure'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How do you find the predecessor of a node in a binary search tree?',
    options: [
      'The largest node in the right subtree',
      'The smallest node in the left subtree',
      'The parent node',
      'The node with the minimum value'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the key operation of a binary search tree?',
    options: [
      'Insertion',
      'Deletion',
      'Searching',
      'All of the above'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the time complexity for finding the height of a binary search tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following scenarios is NOT suitable for a binary search tree?',
    options: [
      'Dynamic data insertion and deletion',
      'Searching for an element',
      'Maintaining a sorted list of elements',
      'Searching for the median of a dataset'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the time complexity for building a binary search tree from a sorted array?',
    options: [
      'O(n log n)',
      'O(n)',
      'O(n^2)',
      'O(log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is a self-balancing binary search tree?',
    options: [
      'A binary search tree that maintains its balance during insertion and deletion',
      'A binary search tree where the height is always kept at a minimum',
      'A binary search tree that allows duplicate values',
      'A binary search tree that is always complete'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity for checking if a binary search tree is balanced?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the average time complexity of searching for an element in a balanced binary search tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
];


//void main() => runApp(QuizApp());

class BinarySearchTreeQuiz extends StatelessWidget {
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
        title: Text('Tree Quiz'),
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



