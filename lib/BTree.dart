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

// List of questions (Binary Tree questions in data structure)
final List<Question> allQuestions = [
  Question(
    questionText: 'What is a binary tree?',
    options: [
      'A tree data structure where each node has at most two children',
      'A tree where every node has exactly two children',
      'A tree where nodes are arranged in a linear fashion',
      'A tree structure with no nodes'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the maximum number of nodes in a binary tree of height h?',
    options: [
      '2^h - 1',
      '2h - 1',
      'h^2',
      '2h'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'In a binary tree, what is the height of a tree with a single node?',
    options: [
      '0',
      '1',
      '2',
      'It depends on the tree structure'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the depth of the root node in a binary tree?',
    options: [
      '0',
      '1',
      '2',
      'It depends on the number of nodes'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What traversal method visits nodes in the order of root, left, right?',
    options: [
      'In-order',
      'Pre-order',
      'Post-order',
      'Level-order'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What traversal method visits nodes in the order of left, root, right?',
    options: [
      'In-order',
      'Pre-order',
      'Post-order',
      'Level-order'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is a complete binary tree?',
    options: [
      'A binary tree where all levels are fully filled except possibly for the last',
      'A binary tree where all nodes have two children',
      'A binary tree where every level is filled from left to right',
      'A binary tree that is balanced'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is a full binary tree?',
    options: [
      'A binary tree where every node has zero or two children',
      'A binary tree where every node has exactly one child',
      'A binary tree that is completely filled',
      'A binary tree with an arbitrary number of children'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity for searching an element in a binary tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the time complexity for inserting an element in a binary tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the post-order traversal of a binary tree?',
    options: [
      'Visit left, visit right, visit root',
      'Visit root, visit left, visit right',
      'Visit root, visit right, visit left',
      'Visit right, visit left, visit root'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following is a characteristic of a balanced binary tree?',
    options: [
      'The height of the left and right subtrees of any node differ by at most one',
      'All nodes have two children',
      'It is always a complete binary tree',
      'It can only have a maximum height of 2'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the level-order traversal of a binary tree?',
    options: [
      'Visiting nodes level by level from top to bottom',
      'Visiting nodes from left to right',
      'Visiting nodes in pre-order',
      'Visiting nodes in post-order'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following trees is not a binary tree?',
    options: [
      'Binary tree',
      'Complete binary tree',
      'Full binary tree',
      'Ternary tree'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is a degenerate (or pathological) tree?',
    options: [
      'A tree where each parent node has only one child',
      'A tree that is perfectly balanced',
      'A tree where all nodes are leaf nodes',
      'A tree that is completely filled'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the purpose of a tree’s height?',
    options: [
      'To determine the number of nodes in the tree',
      'To evaluate the efficiency of operations like insertion and search',
      'To find the minimum and maximum values',
      'To count the number of leaf nodes'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How do you find the maximum value in a binary tree?',
    options: [
      'By traversing all nodes',
      'By checking the root node only',
      'By comparing left and right child nodes',
      'By traversing to the rightmost node'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the main difference between a binary tree and a binary heap?',
    options: [
      'A binary heap is a complete binary tree, while a binary tree is not',
      'A binary tree can have more than two children',
      'A binary heap is always balanced',
      'A binary tree does not allow duplicate values'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is a leaf node in a binary tree?',
    options: [
      'A node that has two children',
      'A node that has one child',
      'A node that has no children',
      'A node that is the root'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the time complexity for deleting a node from a binary tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the in-order traversal of a binary tree?',
    options: [
      'Visit left, visit root, visit right',
      'Visit root, visit left, visit right',
      'Visit right, visit left, visit root',
      'Visit level by level'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How do you identify a non-full binary tree?',
    options: [
      'It has at least one node with one child',
      'All nodes have two children',
      'All leaf nodes are at the same level',
      'All nodes are filled completely'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What happens if you remove the root of a binary tree?',
    options: [
      'The tree becomes empty',
      'The left or right child becomes the new root',
      'The tree remains unchanged',
      'The tree becomes a full binary tree'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is NOT a type of binary tree?',
    options: [
      'Binary tree',
      'Complete binary tree',
      'Balanced binary tree',
      'Quad tree'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the depth of a leaf node in a binary tree?',
    options: [
      '0',
      '1',
      'The same as the tree height',
      'The number of edges from the root to the node'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'How many leaf nodes can a complete binary tree with n levels have?',
    options: [
      '1',
      '2^(n-1)',
      '2^n - 1',
      '2^n'
    ],
    correctAnswerIndex: 1,
  ),
];

//void main() => runApp(QuizApp());

class BtreeQuiz extends StatelessWidget {
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



