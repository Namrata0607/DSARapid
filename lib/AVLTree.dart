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

//AVL tree Questions 
final List<Question> allQuestions = [
  Question(
    questionText: 'What is an AVL tree?',
    options: [
      'A binary tree where each node has at most two children',
      'A binary search tree where the height of two subtrees of any node differ by at most one',
      'A binary search tree where the root is always balanced',
      'A tree where the nodes are sorted in ascending order'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Who invented the AVL tree?',
    options: [
      'Donald Knuth',
      'Robert Tarjan',
      'Georgy Adelson-Velsky and Evgenii Landis',
      'Charles Babbage'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the balance factor in an AVL tree?',
    options: [
      'The difference between the depths of the left and right subtrees',
      'The sum of the depths of the left and right subtrees',
      'The number of nodes in the left and right subtrees',
      'The ratio of the left and right subtree heights'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the allowed range for the balance factor in an AVL tree?',
    options: [
      '-2 to +2',
      '-1 to +1',
      '-3 to +3',
      '0 to +1'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity of searching for an element in an AVL tree?',
    options: [
      'O(n)',
      'O(log n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the height of an AVL tree with n nodes?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How does an AVL tree maintain balance?',
    options: [
      'By performing rotations on nodes',
      'By swapping nodes',
      'By rearranging all nodes after every insertion or deletion',
      'By storing extra information in each node'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is a single rotation in an AVL tree?',
    options: [
      'A process to swap the root node',
      'A technique to fix the balance factor by rotating a subtree once',
      'A process to delete a node from the tree',
      'A technique to reorder the tree without changing its shape'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is a double rotation in an AVL tree?',
    options: [
      'A combination of two single rotations to balance the tree',
      'A rotation that swaps two nodes twice',
      'A process that involves balancing two subtrees independently',
      'A method of rotating two different levels of the tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'When does a right rotation occur in an AVL tree?',
    options: [
      'When the left subtree is too tall',
      'When the right subtree is too tall',
      'When the tree becomes unbalanced after an insertion in the right subtree',
      'When the tree is perfectly balanced'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'When does a left rotation occur in an AVL tree?',
    options: [
      'When the right subtree is too tall',
      'When the left subtree is too tall',
      'When the tree becomes unbalanced after an insertion in the left subtree',
      'When the tree is perfectly balanced'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following rotations is performed when the balance factor is +2 and the imbalance is in the right subtree?',
    options: [
      'Right rotation',
      'Left rotation',
      'Left-right rotation',
      'Right-left rotation'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which rotation is performed when the balance factor is -2 and the imbalance is in the left subtree?',
    options: [
      'Right rotation',
      'Left rotation',
      'Left-right rotation',
      'Right-left rotation'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which rotation is performed when a node in the left subtree of a right subtree causes imbalance?',
    options: [
      'Left rotation',
      'Right rotation',
      'Left-right rotation',
      'Right-left rotation'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the time complexity for inserting an element into an AVL tree?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity for deleting an element from an AVL tree?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the worst-case time complexity of searching in an AVL tree?',
    options: [
      'O(1)',
      'O(n)',
      'O(log n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following statements is true about AVL trees?',
    options: [
      'Every AVL tree is a binary search tree',
      'Every binary search tree is an AVL tree',
      'AVL trees cannot have duplicate keys',
      'AVL trees have a balance factor greater than 2'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How do you check if a binary search tree is also an AVL tree?',
    options: [
      'Check if it is balanced and all nodes satisfy the AVL property',
      'Check if all left subtrees have larger values than the root',
      'Check if all right subtrees have smaller values than the root',
      'Check if all nodes are arranged in a complete binary tree structure'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following operations can cause an imbalance in an AVL tree?',
    options: [
      'Inserting an element',
      'Deleting an element',
      'Both inserting and deleting elements',
      'Rebalancing the tree'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which rotation fixes an imbalance caused by a right subtree of a left subtree?',
    options: [
      'Left rotation',
      'Right rotation',
      'Left-right rotation',
      'Right-left rotation'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the height of an AVL tree with one node?',
    options: [
      '1',
      '0',
      '2',
      '-1'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the height of an empty AVL tree?',
    options: [
      '1',
      '0',
      '-1',
      '2'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is NOT a property of an AVL tree?',
    options: [
      'It is a binary search tree',
      'It is a balanced tree',
      'It has a balance factor of -2 or +2',
      'It allows O(log n) search, insert, and delete operations'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is true about AVL trees?',
    options: [
      'They require constant rebalancing',
      'They guarantee a balance factor between -1 and +1',
      'They do not allow duplicate elements',
      'They have O(n^2) worst-case time complexity'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is the primary benefit of using an AVL tree?',
    options: [
      'It is always perfectly balanced',
      'It guarantees O(log n) operations for search, insert, and delete',
      'It is faster than other balanced binary trees',
      'It requires no extra space for balancing'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity for balancing an AVL tree after an insertion?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How many types of rotations are there in an AVL tree?',
    options: [
      'Two: left and right rotations',
      'Three: left, right, and double rotations',
      'Four: left, right, left-right, and right-left rotations',
      'Five: left, right, and three types of double rotations'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following sequences of insertions causes a left-right rotation?',
    options: [
      'Inserting 10, then 20, then 30',
      'Inserting 30, then 20, then 10',
      'Inserting 30, then 10, then 20',
      'Inserting 10, then 30, then 20'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What kind of tree is an AVL tree, aside from being balanced?',
    options: [
      'A complete binary tree',
      'A full binary tree',
      'A binary search tree',
      'A threaded binary tree'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following trees will not require rebalancing in an AVL tree after insertion?',
    options: [
      'A tree with balance factors of -1 or 0',
      'A tree with balance factors of +1 and +2',
      'A tree with balance factors of -2 and 0',
      'A tree with balance factors of +2 or -2'
    ],
    correctAnswerIndex: 0,
  ),
];


//void main() => runApp(QuizApp());

class AvltreeQuiz extends StatelessWidget {
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



