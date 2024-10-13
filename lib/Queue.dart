import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'dart:math';


class QueueVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Queue Visualizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QueueScreen(),
    );
  }
}

class QueueScreen extends StatefulWidget {
  @override
  _QueueScreenState createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  List<int> queue = []; // Queue to hold elements
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queue Visualizer'),
        backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: queue.isEmpty
                      ? [
                          Text(
                            'Queue is empty',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          )
                        ]
                      : _buildQueueBars(),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _createDefaultQueue, // Create Default Button
                child: Text('Create Default'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: _clearQueue, // Clear Button
                child: Text('Clear'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () => _showEnqueueDialog(context), // Enqueue Button
                child: Text('Enqueue'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: queue.isEmpty ? null : _dequeueElement, // Dequeue Button
                child: Text('Dequeue'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: queue.isEmpty ? null : _peekElement, // Peek Button
                child: Text('Peek'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // Build the visual representation of the queue
  List<Widget> _buildQueueBars() {
    return List<Widget>.generate(queue.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: AnimatedContainer(
          height: 100, // Fixed height for all bars
          width: 60,
          duration: Duration(milliseconds: 300),
          color: Colors.purple, // No top element highlight for queue
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Text(
              queue[index].toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

  // Enqueue element into the queue
  Future<void> _showEnqueueDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Enqueue Value');
    if (value != null) {
      setState(() {
        queue.add(value); // Add element to the end of the queue
      });
    }
  }

  // Dequeue element from the queue
  void _dequeueElement() {
    setState(() {
      if (queue.isNotEmpty) {
        queue.removeAt(0); // Remove front element from the queue
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Front element dequeued'),
      ),
    );
  }

  // Peek at the front element of the queue
  void _peekElement() {
    if (queue.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Front element: ${queue.first}'),
        ),
      );
    }
  }

  // Create a default queue with some values
  void _createDefaultQueue() {
    setState(() {
      queue = [10, 20, 30, 40, 50]; // Default queue values
    });
  }

  // Clear the queue
  void _clearQueue() {
    setState(() {
      queue = []; // Clear the queue
    });
  }

  // Generalized input dialog to get user input
  Future<int?> _showInputDialog(BuildContext context, String title) async {
    final TextEditingController controller = TextEditingController();

    return showDialog<int>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Enter a number'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Dismiss dialog
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final value = int.tryParse(controller.text);
                Navigator.of(context).pop(value); // Return value
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

//Test

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

// List of questions (Queue questions in data structure)
final List<Question> allQuestions = [
 Question(
    questionText: 'What is the primary data structure used to implement a queue?',
    options: ['Stack', 'Linked List', 'Array', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'Which of the following operations is not a valid queue operation?',
    options: ['Enqueue', 'Dequeue', 'Peek', 'Push'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'What does the enqueue operation do in a queue?',
    options: ['Removes an element from the front', 'Adds an element to the rear', 'Returns the front element', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which of the following is true about a queue?',
    options: ['It is a LIFO structure', 'It is a FIFO structure', 'It can grow in any direction', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'If a queue is implemented using an array, what happens if you try to enqueue an element onto a full queue?',
    options: ['Underflow', 'Overflow', 'Queue is unchanged', 'Program crash'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What will happen if you call dequeue on an empty queue?',
    options: ['Returns null', 'Throws an exception', 'Returns 0', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'For an array-based implementation of a queue, which variable typically indicates the current front of the queue?',
    options: ['Size', 'Front', 'Count', 'Length'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which operation is used to view the front element of a queue without removing it?',
    options: ['Dequeue', 'Peek', 'Enqueue', 'Front'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What type of problems can be solved using queues?',
    options: ['Scheduling processes', 'Breadth-first search', 'Buffering data', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'What is the time complexity for the enqueue operation in a queue?',
    options: ['O(n)', 'O(log n)', 'O(1)', 'O(n log n)'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'Given the queue operations: Enqueue(1), Enqueue(2), Dequeue(), Enqueue(3), what will the front element be?',
    options: ['1', '2', '3', 'Empty'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What is the maximum number of elements in a queue of size n?',
    options: ['n', 'n-1', 'n+1', '2n'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'If you have the following operations on an empty queue: Enqueue(5), Enqueue(10), Dequeue(), Enqueue(20), what will the front element be?',
    options: ['5', '10', '20', 'Empty'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'In a queue, which of the following statements is true?',
    options: ['Elements are removed from the front', 'Elements are added to the back', 'Both A and B', 'None of the above'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'How would you check if a queue is empty?',
    options: ['Check if the front is null', 'Check if the size is 0', 'Both A and B', 'None of the above'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'For a queue with elements [A, B, C, D] (with A at the front), what will be the state of the queue after performing a dequeue operation?',
    options: ['[A, B, C]', '[B, C, D]', '[C, D]', '[]'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What is the space complexity of a queue implemented using a linked list?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which of the following can be used to implement a queue?',
    options: ['Stack', 'Array', 'Linked List', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'What will be the contents of a queue after performing Enqueue(5), Enqueue(10), Enqueue(15), Dequeue()?',
    options: ['[5, 10]', '[10, 15]', '[5, 15]', '[5, 10, 15]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'Which of the following can cause queue overflow?',
    options: ['Infinite enqueue operations', 'Excessive queue size', 'Large data structures', 'All of the above'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'In a circular queue, when the last position is reached and the queue is not empty, where should the next element be added?',
    options: ['At the end', 'At the front', 'At the back', 'Circularly at the beginning'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'Which data structure is best for implementing a priority queue?',
    options: ['Array', 'Linked List', 'Heap', 'Stack'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What is the result of performing these operations: Enqueue(1), Enqueue(2), Enqueue(3), Dequeue(), Dequeue() on an empty queue?',
    options: ['1', '2', '3', '0'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What is the best use case for a queue?',
    options: ['Task scheduling', 'Undo functionality in text editors', 'Storing history', 'None of the above'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'How would you implement a queue using two stacks?',
    options: ['Using one stack for enqueue and another for dequeue', 'Using one stack for dequeue and another for enqueue', 'Using both stacks for both enqueue and dequeue', 'Not possible'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'Which of the following is true about a double-ended queue (Deque)?',
    options: ['Elements can be added/removed from both ends', 'It is a LIFO structure', 'It can only hold unique elements', 'None of the above'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'What will be the output after performing these operations: Enqueue(1), Enqueue(2), Dequeue(), Enqueue(3) on an empty queue?',
    options: ['1', '2', '3', '0'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'In which scenario would you use a queue data structure?',
    options: ['Processing requests in order', 'Finding shortest paths', 'Sorting data', 'None of the above'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'If a queue contains elements [1, 2, 3] (with 1 at the front), what will be the state of the queue after performing two dequeue operations?',
    options: ['[1, 2]', '[2, 3]', '[3]', '[]'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What is the average time complexity for dequeue operations in a queue?',
    options: ['O(n)', 'O(log n)', 'O(1)', 'O(n log n)'],
    correctAnswerIndex: 2,
),

];

// void main() => runApp(QuizApp());

class QueueQuiz extends StatelessWidget {
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
            padding: EdgeInsets.all(16.0),
            primary: Color.fromARGB(255, 167, 69, 167),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Score: $score / ${quizQuestions.length}',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: restartQuiz,
            child: Text('Restart Quiz'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16.0),
              primary: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}