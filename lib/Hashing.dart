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

//Hashing Questions 
final List<Question> allQuestions = [
  Question(
    questionText: 'What is hashing in data structures?',
    options: [
      'A technique for finding the shortest path in a graph',
      'A technique to map data to a fixed size value',
      'A method to search through a linked list',
      'A process to sort data using comparisons'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the main purpose of a hash function?',
    options: [
      'To generate a unique identifier for each element in a set',
      'To compress data for storage',
      'To map keys to positions in a hash table',
      'To find the shortest path between nodes'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is a collision in hashing?',
    options: [
      'When two different keys hash to the same index',
      'When two hash functions are applied to the same key',
      'When all keys map to the same index',
      'When the hash table becomes full'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following is a desirable property of a good hash function?',
    options: [
      'It should map similar keys to the same index',
      'It should generate the same output for all inputs',
      'It should minimize collisions',
      'It should run in quadratic time complexity'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the time complexity of inserting a key into a hash table (without collisions)?',
    options: [
      'O(n)',
      'O(1)',
      'O(log n)',
      'O(n^2)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following techniques is used to resolve collisions in hashing?',
    options: [
      'Binary Search',
      'Chaining',
      'Recursion',
      'Merge Sort'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is open addressing in the context of hashing?',
    options: [
      'A collision resolution technique where all elements are stored in linked lists',
      'A method for accessing elements directly by key',
      'A collision resolution technique where collisions are resolved within the hash table by probing',
      'A method to store elements based on priority'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is a hash table?',
    options: [
      'A dynamic data structure used for efficient data retrieval',
      'A table used for sorting data in decreasing order',
      'A data structure that maps keys to values using a hash function',
      'A data structure that stores elements in a tree-like form'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is not a collision resolution technique?',
    options: [
      'Chaining',
      'Linear Probing',
      'Quadratic Probing',
      'Binary Search'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the primary disadvantage of using chaining for collision resolution?',
    options: [
      'It uses additional memory for pointers',
      'It cannot handle large hash tables',
      'It is slower than linear probing',
      'It is not a valid collision resolution technique'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is linear probing in open addressing?',
    options: [
      'A technique to hash all keys to the first available slot',
      'A technique to hash all keys into linked lists',
      'A technique where the next empty slot is found by checking subsequent positions in the hash table',
      'A method to hash similar keys to the same position'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'In quadratic probing, how is the next slot calculated when a collision occurs?',
    options: [
      'By jumping one slot at a time',
      'By adding the square of the probe number to the hash value',
      'By moving in a random direction',
      'By dividing the hash value by the number of keys'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is double hashing?',
    options: [
      'A collision resolution technique that uses a second hash function to determine the probe sequence',
      'A method of hashing a key twice for better performance',
      'A hashing technique that requires two hash tables',
      'A method where two keys are hashed together'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the load factor in a hash table?',
    options: [
      'The ratio of the number of elements to the total number of slots',
      'The number of elements hashed in one operation',
      'The maximum number of collisions allowed',
      'The total memory usage by the hash table'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What happens when the load factor of a hash table exceeds 1?',
    options: [
      'The hash table becomes full and cannot accept more elements',
      'The performance of the hash table improves',
      'The hash table must be rehashed or resized',
      'The hash function must be recalculated'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following hash functions is most effective for uniformly distributing keys?',
    options: [
      'Multiplicative Hashing',
      'Division Hashing',
      'Mid-Square Hashing',
      'Modulo Hashing'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the purpose of rehashing in a hash table?',
    options: [
      'To resolve collisions by using a different hash function',
      'To recalculate hash values for all keys to a larger table',
      'To move keys that are no longer needed',
      'To optimize the search operation'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following situations would require rehashing?',
    options: [
      'When the load factor becomes too low',
      'When the load factor exceeds a certain threshold',
      'When the number of collisions exceeds the number of keys',
      'When the hash function does not work properly'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is a perfect hash function?',
    options: [
      'A hash function that minimizes the number of collisions',
      'A hash function that maps each key to a unique index with no collisions',
      'A hash function that only works on sorted data',
      'A hash function that always maps keys to the same index'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is an advantage of hashing over binary search trees?',
    options: [
      'Hashing provides faster access on average',
      'Hashing guarantees balanced trees',
      'Hashing requires less space',
      'Hashing is always more efficient in space and time'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity of searching for an element in a hash table with proper collision handling?',
    options: [
      'O(log n)',
      'O(n)',
      'O(1)',
      'O(n^2)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the primary disadvantage of using open addressing?',
    options: [
      'It requires linked lists for each entry',
      'It suffers from clustering of keys',
      'It requires too much memory for small datasets',
      'It increases the complexity of hash function computation'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the difference between chaining and open addressing?',
    options: [
      'Chaining stores multiple elements in the same slot using a list, while open addressing searches for the next available slot',
      'Chaining uses a single hash function while open addressing uses two',
      'Open addressing is used for large datasets while chaining is for small datasets',
      'Chaining results in fewer collisions than open addressing'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How can clustering be reduced in open addressing?',
    options: [
      'By using double hashing',
      'By reducing the size of the hash table',
      'By using binary search instead of hashing',
      'By increasing the load factor'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is primary clustering?',
    options: [
      'When multiple elements hash to the same index and subsequent probes form a contiguous block',
      'When all hash values cluster around a particular key',
      'When too many keys hash to the same linked list in chaining',
      'When the hash function becomes too complex'
    ],
    correctAnswerIndex: 0,
  ),
    Question(
    questionText: 'Which hash function method involves multiplying the key by a constant and taking the fractional part?',
    options: [
      'Division Method',
      'Multiplicative Hashing',
      'Mid-Square Method',
      'Quadratic Probing'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is a hash code?',
    options: [
      'A code used to identify the location of an element in a hash table',
      'A unique representation of an object’s data in a hash function',
      'A code that describes how data is compressed',
      'A method of encrypting data'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following statements is true about a hash table?',
    options: [
      'All keys must be unique, but values can be duplicated',
      'Values must be unique, but keys can be duplicated',
      'Both keys and values can be duplicated',
      'Neither keys nor values can be duplicated'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the typical method to handle dynamic resizing of a hash table?',
    options: [
      'Doubling the size of the table and rehashing all entries',
      'Reducing the size of the table by half',
      'Creating a new hash table with the same size',
      'Only adding new keys when space is available'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'When is the best time to use hashing?',
    options: [
      'When the data set is sorted',
      'When fast access and retrieval of data is required',
      'When the data set is small',
      'When there is a strict ordering of keys'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What would happen if a hash table is not resized when the load factor exceeds 1?',
    options: [
      'The performance remains optimal',
      'The hash table will start losing elements',
      'The hash table will become inefficient with increased collisions',
      'All of the above'
    ],
    correctAnswerIndex: 3,
  ),
];




//void main() => runApp(QuizApp());

class HashingQuiz extends StatelessWidget {
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



