import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'dart:math';



class QueueVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Queue Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Purple theme
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
  List<int?> queue = List.filled(7, null); // Queue initialized with null placeholders
  String currentAlgorithm = ""; // Holds the algorithm description
  String currentOutput = ""; // Holds the step-by-step output
  int enqueueIndex = 0; // Keeps track of the next enqueue index
  int dequeueIndex = 0; // Keeps track of the next dequeue index
  int size = 0; // Keeps track of the number of valid elements
  final int maxQueueSize = 7; // Maximum queue size
  int? currentHighlight; // To highlight current operation element

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queue Visualizer'),
        backgroundColor: Colors.purple, // Purple AppBar
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left Container (for Algorithm and Output)
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.grey.shade300,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Algorithm section
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Algorithm',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple, // Purple heading
                                  ),
                                ),
                                Divider(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      currentAlgorithm,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        // Output/Step-by-step explanation section
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: Colors.white,
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Step-by-Step Output',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.purple, // Purple heading
                                  ),
                                ),
                                Divider(),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Text(
                                      currentOutput,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                // Right Container (for Queue Visualizer)
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Queue Visualizer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple, // Purple heading
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: _buildBars(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Container (for Operation Buttons)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _createDefaultQueue,
                  child: Text('Create Default'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple), // Purple buttons
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showEnqueueDialog(context),
                  child: Text('Enqueue'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _dequeueFromQueue,
                  child: Text('Dequeue'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _peekQueue,
                  child: Text('Peek'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _clearQueue,
                  child: Text('Clear'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Create default queue
  void _createDefaultQueue() {
    setState(() {
      queue = [10, 20, 30, null, null, null, null]; // Default queue with 3 elements
      enqueueIndex = 3; // Set next enqueue index
      dequeueIndex = 0; // Reset dequeue index
      size = 3; // Set size to 3
      currentHighlight = null;
      currentAlgorithm = """
1. A queue is a linear data structure that follows the FIFO (First In First Out) principle.
2. 'Enqueue' operation adds an element to the end of the queue.
3. 'Dequeue' operation removes the element from the front of the queue, leaving a placeholder.
4. 'Peek' operation returns the front element without removing it.
5. The maximum size of this queue is 7 elements.
6. 'Clear' operation removes all elements from the queue.
""";
      currentOutput = "Default queue created with values 10, 20, 30.";
    });
  }

  // Build the visual bars for the queue
  List<Widget> _buildBars() {
    return List<Widget>.generate(queue.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: AnimatedContainer(
          height: 50,
          width: 100,
          duration: Duration(milliseconds: 300),
          color: (index == currentHighlight)
              ? Colors.green // Highlight current operation element
              : (queue[index] == null ? Colors.grey : Colors.purple), // Purple for valid elements, grey for empty
          alignment: Alignment.center,
          child: Text(
            queue[index]?.toString() ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }

  // Show dialog to input value for enqueuing into the queue
  Future<void> _showEnqueueDialog(BuildContext context) async {
    if (size >= maxQueueSize) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Queue overflow! Max size of $maxQueueSize reached."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int? value = await _showInputDialog(context, 'Enqueue Value');
    if (value != null) {
      setState(() {
        queue[enqueueIndex] = value; // Add element to the queue
        currentHighlight = enqueueIndex; // Highlight newly enqueued element
        enqueueIndex = (enqueueIndex + 1) % maxQueueSize; // Increment enqueue index
        size++; // Increase size
        currentOutput += "Enqueued $value into the queue.\n";
      });
    }
  }

  // Dequeue an element from the queue (leave placeholder)
  void _dequeueFromQueue() {
    if (size > 0 && queue[dequeueIndex] != null) {
      setState(() {
        int dequeuedValue = queue[dequeueIndex]!; // Remove first element
        queue[dequeueIndex] = null; // Leave placeholder
        currentHighlight = dequeueIndex; // Highlight dequeued position
        dequeueIndex = (dequeueIndex + 1) % maxQueueSize; // Increment dequeue index
        currentOutput += "Dequeued $dequeuedValue from the queue.\n";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Dequeued element: $dequeuedValue"),
            backgroundColor: Colors.green,
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Queue underflow! Cannot dequeue from an empty queue."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Peek the front element of the queue
  void _peekQueue() {
    if (size > 0 && queue[dequeueIndex] != null) {
      int frontValue = queue[dequeueIndex]!; // Get front element
      setState(() {
        currentHighlight = dequeueIndex; // Highlight front element
        currentOutput += "Front element is $frontValue (peeked).\n";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Front element: $frontValue"),
          backgroundColor: Colors.blue,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Queue is empty! No elements to peek."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Clear the queue
  void _clearQueue() {
    setState(() {
      queue = List.filled(maxQueueSize, null); // Clear all elements from queue
      enqueueIndex = 0;
      dequeueIndex = 0;
      size = 0;
      currentHighlight = null;
      currentOutput = "Queue cleared.";
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
            backgroundColor: Color.fromARGB(255, 167, 69, 167),
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
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}