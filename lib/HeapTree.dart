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

final List<Question> allQuestions = [
  Question(
    questionText: 'What is a heap tree?',
    options: [
      'A complete binary tree where each node is greater than its children',
      'A complete binary tree where each node is smaller than its children',
      'A binary tree where nodes are unsorted',
      'A binary search tree where nodes are sorted'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the main property of a max-heap?',
    options: [
      'The root node contains the minimum value',
      'Each parent node is greater than or equal to its children',
      'Each parent node is less than or equal to its children',
      'It is always a balanced tree'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the main property of a min-heap?',
    options: [
      'The root node contains the maximum value',
      'Each parent node is greater than or equal to its children',
      'Each parent node is less than or equal to its children',
      'It is always a balanced tree'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is a heap tree?',
    options: [
      'A complete binary tree',
      'A sorted binary tree',
      'A tree where each parent node is greater than its children',
      'A tree where each parent node is smaller than its children'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How do you insert an element into a heap?',
    options: [
      'Insert it at the root and then balance the tree',
      'Insert it at the last position and then heapify the tree upwards',
      'Insert it at the last position and heapify downwards',
      'Insert it at any random position'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity of inserting an element into a heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity of extracting the maximum element from a max-heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How is a heap typically implemented in a computer’s memory?',
    options: [
      'As a linked list',
      'As a binary search tree',
      'As an array',
      'As a hash table'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the time complexity of building a heap from an unordered array?',
    options: [
      'O(n log n)',
      'O(n)',
      'O(n^2)',
      'O(log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How do you delete the root of a heap?',
    options: [
      'Replace the root with the last element and heapify downwards',
      'Remove the root and heapify upwards',
      'Replace the root with its largest child and heapify downwards',
      'The root cannot be deleted'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following is NOT true about a heap?',
    options: [
      'It is a complete binary tree',
      'It satisfies the heap property',
      'The height of a heap is log(n)',
      'A heap is always sorted'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'In a max-heap, where is the maximum element stored?',
    options: [
      'In the left subtree',
      'In the right subtree',
      'At the root',
      'At any random node'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is heapify?',
    options: [
      'A process to rearrange elements to maintain the heap property',
      'A process to insert an element into a heap',
      'A process to delete an element from a heap',
      'A process to create a binary search tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity of deleting an element from a heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the minimum number of nodes in a heap of height h?',
    options: [
      '2^h - 1',
      '2h',
      'h',
      '2^(h-1)'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the maximum number of nodes in a heap of height h?',
    options: [
      '2^h - 1',
      '2h',
      'h',
      '2^(h+1) - 1'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the height of a heap with n nodes?',
    options: [
      'O(n)',
      'O(log n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following operations is typically used to maintain the heap property after an insertion?',
    options: [
      'Heapify up',
      'Heapify down',
      'Rotate the tree',
      'Balance the tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following is true about the last element in a heap?',
    options: [
      'It can be at any level of the tree',
      'It is always a leaf node',
      'It can never be a leaf node',
      'It is always at the root'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How do you build a max-heap from an unordered array?',
    options: [
      'Insert elements one by one and heapify upwards',
      'Insert elements one by one and heapify downwards',
      'Build the heap using Floyd’s algorithm',
      'Sort the array and convert it into a heap'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the worst-case time complexity for inserting an element into a heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is NOT a type of heap?',
    options: [
      'Max-heap',
      'Min-heap',
      'Ternary heap',
      'Balanced heap'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is a ternary heap?',
    options: [
      'A heap where each node has at most three children',
      'A heap where each node has at most two children',
      'A heap with three levels',
      'A heap that is not balanced'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following operations is typically used to maintain the heap property after a deletion?',
    options: [
      'Heapify up',
      'Heapify down',
      'Rotate the tree',
      'Balance the tree'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the main application of a heap in computer science?',
    options: [
      'Sorting data using heap sort',
      'Storing elements in sorted order',
      'Balancing a binary search tree',
      'Finding the depth of a binary tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How many children can each node in a binary heap have?',
    options: [
      'At most one child',
      'At most two children',
      'At most three children',
      'At most four children'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity for finding the minimum element in a max-heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'In a min-heap, where is the minimum element stored?',
    options: [
      'In the left subtree',
      'In the right subtree',
      'At the root',
      'At any random node'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the difference between a heap and a binary search tree?',
    options: [
      'A heap maintains the heap property, while a binary search tree maintains sorted order',
      'A heap is always balanced, while a binary search tree is not',
      'A heap is not a binary tree, but a binary search tree is',
      'There is no difference'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which algorithm is typically used to sort elements using a heap?',
    options: [
      'Quick sort',
      'Merge sort',
      'Heap sort',
      'Bubble sort'
    ],
    correctAnswerIndex: 2,
  )
];


//void main() => runApp(QuizApp());

class HeaptreeQuiz extends StatelessWidget {
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



