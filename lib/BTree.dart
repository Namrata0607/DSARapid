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
    questionText: 'What is a B-Tree in data structures?',
    options: [
      'A self-balancing binary search tree with sorted order of elements',
      'A binary tree with exactly two children for every node',
      'A self-balancing tree data structure that maintains sorted data and allows searches, insertions, deletions, and sequential access in logarithmic time',
      'A tree structure used primarily for representing graphs'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the primary application of B-Trees?',
    options: [
      'Implementing priority queues',
      'Handling large data sets in databases and file systems',
      'Sorting algorithms',
      'Representing graphs'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the minimum degree of a B-Tree?',
    options: [
      'The maximum number of children each node can have',
      'The minimum number of children each internal node must have',
      'The number of elements each node must have at least',
      'The maximum depth of the tree'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity of searching in a B-Tree?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What property makes a B-Tree balanced?',
    options: [
      'All leaves are at the same level',
      'Each node has the same number of children',
      'Each path from the root to a leaf has the same number of nodes',
      'Each node stores the same number of elements'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the order of a B-Tree?',
    options: [
      'The number of elements each node can store',
      'The maximum number of children a node can have',
      'The number of nodes in the tree',
      'The depth of the tree'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is a leaf node in a B-Tree?',
    options: [
      'A node with no children',
      'A node with no elements',
      'A node that contains exactly two children',
      'A node that has a single parent'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following is a characteristic of B-Trees?',
    options: [
      'All keys are stored in leaf nodes',
      'Every node has at least two children',
      'Internal nodes store keys and have child pointers',
      'Every node contains exactly one key'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'How are insertions handled in B-Trees when a node becomes full?',
    options: [
      'The tree is rebalanced by shifting elements to other nodes',
      'The node is split, and the middle key is promoted to the parent node',
      'The node is deleted and its keys are redistributed',
      'The tree height is increased by adding new levels'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What happens during a split operation in a B-Tree?',
    options: [
      'The elements of the full node are redistributed evenly across its children',
      'The middle key of a full node is promoted, and the node is split into two halves',
      'The entire subtree is restructured to maintain balance',
      'All keys are rearranged in ascending order'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity for insertion in a B-Tree?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What condition must be met before deleting a key from a B-Tree?',
    options: [
      'The node must be a leaf node',
      'The tree must be balanced',
      'The node must have at least the minimum number of keys',
      'The key must be larger than all other keys in the node'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What happens when a key is deleted from a B-Tree?',
    options: [
      'The tree is restructured to maintain balance',
      'The keys are redistributed among the nodes',
      'The node is split into two halves',
      'The parent node becomes the new root'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How is the minimum number of children a node must have in a B-Tree determined?',
    options: [
      'By the degree of the B-Tree',
      'By the depth of the node',
      'By the height of the tree',
      'By the number of elements in the tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the primary advantage of using a B-Tree?',
    options: [
      'Efficient space utilization and reduced disk I/O',
      'Faster insertion than binary search trees',
      'Ability to store multiple keys in each node',
      'Simpler implementation compared to other trees'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'In a B-Tree, how are the elements within a node typically arranged?',
    options: [
      'In ascending order',
      'In descending order',
      'In random order',
      'By their insertion sequence'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the relationship between the height of a B-Tree and its performance?',
    options: [
      'The height has no impact on performance',
      'The shorter the height, the better the performance',
      'The taller the tree, the better the performance',
      'Height only affects deletion performance'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which operation may cause a node in a B-Tree to be merged?',
    options: [
      'Insertion',
      'Search',
      'Deletion',
      'Traversal'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What condition triggers a merge in a B-Tree?',
    options: [
      'When a node has fewer than the minimum number of keys after a deletion',
      'When a node becomes too large after an insertion',
      'When the root has no children',
      'When a leaf node is full'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity for deletion in a B-Tree?',
    options: [
      'O(n)',
      'O(log n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What does “balanced” mean in the context of B-Trees?',
    options: [
      'All nodes have the same number of keys',
      'All leaves are at the same level',
      'The height of the tree is minimized',
      'All keys are evenly distributed'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Why are B-Trees especially useful for databases?',
    options: [
      'They allow efficient searching and sequential access',
      'They are faster than other tree structures for all operations',
      'They can store large amounts of data in memory',
      'They are easier to implement than binary trees'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What happens if a B-Tree becomes unbalanced?',
    options: [
      'It remains functional but loses its efficiency',
      'It must be restructured or rebalanced',
      'It automatically reorganizes its nodes',
      'It cannot perform any further operations'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following can be stored in a B-Tree?',
    options: [
      'Only integers',
      'Any comparable elements',
      'Only strings',
      'Only binary data'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the order of a B-Tree determined by?',
    options: [
      'The number of children each node can have',
      'The number of elements in the entire tree',
      'The total depth of the tree',
      'The size of the keys being stored'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the difference between a B-Tree and a Binary Search Tree?',
    options: [
      'B-Trees store multiple keys per node, while binary search trees store only one',
      'Binary search trees have more efficient search operations',
      'B-Trees are used for smaller datasets',
      'Binary search trees balance themselves automatically'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the maximum number of children a B-Tree node can have if its order is "m"?',
    options: [
      'm',
      'm + 1',
      'm - 1',
      '2m'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the maximum number of keys a B-Tree node of order "m" can store?',
    options: [
      'm - 1',
      'm',
      'm + 1',
      '2m'
    ],
    correctAnswerIndex: 0,
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



