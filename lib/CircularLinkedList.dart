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

// List of 30 questions (Circular queue questions in data structure)
final List<Question> allQuestions = [
  Question(
    questionText: 'What is a circular queue?',
    options: [
      'A queue where elements are arranged in a circle',
      'A queue with no front or rear',
      'A queue that allows elements to be added from both ends',
      'A queue where the last position is connected to the first'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What happens when the rear reaches the end of a circular queue?',
    options: [
      'Queue overflows',
      'Rear moves to the front of the queue',
      'Queue underflows',
      'Queue resets'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How is the front element of a circular queue updated during dequeue operation?',
    options: [
      'It is reset to 0',
      'It is moved circularly to the next element',
      'It stays in place',
      'It moves to the previous element'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is a major advantage of a circular queue over a linear queue?',
    options: [
      'Better performance for large queues',
      'More efficient use of memory',
      'Faster enqueue operations',
      'Supports multiple types of elements'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What condition signifies that a circular queue is empty?',
    options: [
      'Front is equal to rear',
      'Front is one position ahead of rear',
      'Rear is at the last position',
      'Both front and rear are at the same position and point to -1'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How do you avoid confusion between a full and an empty state in a circular queue?',
    options: [
      'By using a counter to track the number of elements',
      'By resetting the front to 0 after each dequeue',
      'By using a sentinel value in the queue',
      'By checking the front pointer only'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'In a circular queue, when the last position is reached and the queue is not empty, where should the next element be added?',
    options: [
      'At the end',
      'At the front',
      'At the back',
      'Circularly at the beginning'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'Which of the following operations is unique to a circular queue?',
    options: [
      'Peek',
      'Enqueue',
      'Wrap-around',
      'Dequeue'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'How do you calculate the next position in a circular queue during an enqueue operation?',
    options: [
      '(rear + 1) % capacity',
      'rear + 1',
      'front + 1',
      '(front + 1) % capacity'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What condition signifies that a circular queue is full?',
    options: [
      'When front is ahead of rear by one position',
      'When rear is at the last position and the front is at the first',
      'When (rear + 1) % capacity == front',
      'When rear is equal to front'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the maximum number of elements in a circular queue with capacity N?',
    options: [
      'N - 1',
      'N',
      'N + 1',
      '2N'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How do you initialize the front and rear in an empty circular queue?',
    options: [
      'Both front and rear are initialized to -1',
      'Both front and rear are initialized to 0',
      'Front is -1, rear is 0',
      'Front is 0, rear is -1'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity of the enqueue operation in a circular queue?',
    options: [
      'O(1)',
      'O(n)',
      'O(log n)',
      'O(n^2)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity of the dequeue operation in a circular queue?',
    options: [
      'O(1)',
      'O(n)',
      'O(log n)',
      'O(n^2)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Why is a circular queue more memory efficient than a linear queue?',
    options: [
      'It does not leave unused space in memory',
      'It stores data in a compact format',
      'It allows elements to be reused',
      'It automatically resizes'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following applications is most suited for a circular queue?',
    options: [
      'Job scheduling in a round-robin fashion',
      'Depth-first search in graphs',
      'Managing a call stack',
      'Binary search'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What happens to the front when the first element is dequeued from a circular queue?',
    options: [
      'It stays the same',
      'It moves to the next position circularly',
      'It is reset to the rear',
      'It becomes null'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What condition causes the queue to overflow in a circular queue?',
    options: [
      'When front == rear',
      'When (rear + 1) % capacity == front',
      'When front == rear - 1',
      'When rear == front + 1'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the initial value of rear in a circular queue with size N?',
    options: [
      'N - 1',
      'N + 1',
      '-1',
      '0'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'When implementing a circular queue, why do we use modulo arithmetic?',
    options: [
      'To prevent overflow',
      'To ensure wrapping around when the end of the queue is reached',
      'To manage memory more efficiently',
      'To handle negative indices'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'In a circular queue, what is the purpose of the front pointer?',
    options: [
      'To keep track of the first element',
      'To point to the last element',
      'To manage queue underflow',
      'To find the middle of the queue'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is a real-world example of a circular queue?',
    options: [
      'CPU scheduling in operating systems',
      'Sorting algorithms',
      'Recursive function calls',
      'Graph traversal'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following is a disadvantage of a circular queue?',
    options: [
      'Limited capacity',
      'Slower dequeue operations',
      'Higher memory usage',
      'Difficult to implement'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'When using a circular queue, which value is commonly returned to signify an empty queue?',
    options: [
      '0',
      '-1',
      'null',
      'N'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Why is a circular queue better suited for task scheduling than a linear queue?',
    options: [
      'It avoids memory fragmentation',
      'It keeps the processor busy',
      'It allows tasks to be processed in a circular order without gaps',
      'It handles more tasks simultaneously'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'How can we differentiate between a full queue and an empty queue in a circular queue?',
    options: [
      'Use a counter to track the number of elements',
      'Use a special flag',
      'Use a front pointer only',
      'There is no way to differentiate'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'When is the circular queue said to be in an overflow condition?',
    options: [
      'When rear == front - 1',
      'When front == rear',
      'When rear + 1 == front',
      'When rear == front + 1'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'In a circular queue, how do we check if the queue is empty?',
    options: [
      'When front == rear',
      'When rear + 1 == front',
      'When front + 1 == rear',
      'When front is greater than rear'
    ],
    correctAnswerIndex: 0,
  ),
];



//void main() => runApp(QuizApp());

class CircularlinkedlistQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Linked List Quiz',
      debugShowCheckedModeBanner: false,
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
        title: Text('Circular Linked List Quiz'),
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



