import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/User/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';


class CircularQNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PDF Viewer',
      home: PDFViewerScreen(),  // Directly open the PDF on load
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Automatically open the PDF when this screen is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      const url = 'assets/notes/circular_queue.pdf';  // Relative path to the PDF
      await launch(url);  // This opens the PDF in a new browser tab
    });

    return Scaffold(
      appBar: appBack(context),
      body: Center(
        child: Text('Opening PDF...'),
      ),
    );
  }
}


void main() {
  runApp(CircularQueueVisualizerApp());
}

class CircularQueueVisualizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circular Queue Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Purple theme
      ),
      home: CircularQueueScreen(),
    );
  }
}

class CircularQueueScreen extends StatefulWidget {
  @override
  _CircularQueueScreenState createState() => _CircularQueueScreenState();
}

class _CircularQueueScreenState extends State<CircularQueueScreen> {
  List<int?> queue = List.filled(7, null); // Circular Queue with 7 slots
  int front = -1; // Points to the front of the queue
  int rear = -1; // Points to the rear of the queue
  final int maxSize = 7; // Max size of the queue
  String currentAlgorithm = ""; // To display algorithm explanation
  String currentOutput = ""; // To display step-by-step output
  int? currentHighlight; // To highlight current operation element

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBack(context),
        body: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  // Left Container (Algorithm and Output sections)
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
                                      color: Colors.purple,
                                    ),
                                  ),
                                  Divider(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        currentAlgorithm,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Output section
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
                                      color: Colors.purple,
                                    ),
                                  ),
                                  Divider(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        currentOutput,
                                        style: TextStyle(fontSize: 16),
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
                  // Right Container (Queue Visualizer)
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Circular Queue Visualizer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Divider(),
                          Expanded(
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: _buildQueueBars(),
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
            // Bottom Container (Operations buttons)
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
                          MaterialStateProperty.all<Color>(Colors.purple),
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
                    onPressed: _dequeue,
                    child: Text('Dequeue'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _peek,
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
      ),
    );
  }

  // Create default circular queue
  void _createDefaultQueue() {
    setState(() {
      queue = [10, 20, 30, null, null, null, null]; // Initialize default values
      front = 0; // Set front to first element
      rear = 2; // Set rear to the last element
      currentHighlight = null; // Reset highlight
      currentAlgorithm = """
1. A circular queue is a linear data structure in which the last position is connected back to the first position.
2. The 'Enqueue' operation inserts an element in the queue. If the queue reaches the end, it wraps around to the beginning.
3. The 'Dequeue' operation removes an element from the front of the queue and updates the front pointer.
4. The 'Peek' operation returns the front element without removing it.
5. The maximum size of the queue is 7 elements.
""";
      currentOutput =
          "Default circular queue created with values 10, 20, 30."; // Initialize output
    });
  }

  // Build the queue bars for visualizing
  List<Widget> _buildQueueBars() {
    return List<Widget>.generate(queue.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: AnimatedContainer(
          height: 50,
          width: 50,
          duration: Duration(milliseconds: 300),
          color: (index == currentHighlight)
              ? Colors.green // Highlight current operation element
              : (queue[index] == null ? Colors.grey : Colors.purple),
          alignment: Alignment.center,
          child: Text(
            queue[index]?.toString() ?? '', // Show value or empty string
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

  // Show dialog to input value for enqueueing
  Future<void> _showEnqueueDialog(BuildContext context) async {
    if ((rear + 1) % maxSize == front) {
      // Check for queue overflow
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Queue overflow! Max size of $maxSize reached."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int? value = await _showInputDialog(context, 'Enqueue Value');
    if (value != null) {
      setState(() {
        if (front == -1) {
          front = rear = 0; // Queue was empty, set front and rear to 0
        } else {
          rear = (rear + 1) % maxSize; // Wrap around on enqueue
        }
        queue[rear] = value; // Insert value
        currentHighlight = rear; // Highlight the new element
        currentOutput += "Enqueued $value into the queue.\n"; // Update output
      });
    }
  }

  // Dequeue an element from the front
  void _dequeue() {
    if (front == -1) {
      // Check for queue underflow
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Queue underflow! No elements to dequeue."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int? dequeuedValue = queue[front];
    queue[front] = null; // Remove element from queue
    setState(() {
      currentHighlight = front; // Highlight the removed element
      currentOutput += "Dequeued $dequeuedValue from the queue.\n";
      if (front == rear) {
        // Queue becomes empty
        front = rear = -1;
      } else {
        front = (front + 1) % maxSize; // Wrap around on dequeue
      }
    });
  }

  // Peek the front element without removing it
  void _peek() {
    if (front == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Queue is empty! Nothing to peek."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      currentHighlight = front; // Highlight the front element
      currentOutput += "Peeked at value ${queue[front]} at the front.\n";
    });
  }

  // Clear the queue
  void _clearQueue() {
    setState(() {
      queue = List.filled(maxSize, null); // Clear all elements
      front = rear = -1; // Reset front and rear pointers
      currentHighlight = null; // Reset highlight
      currentOutput = "Queue has been cleared.\n"; // Update output
    });
  }

  // Show input dialog for enqueue operation
  Future<int?> _showInputDialog(BuildContext context, String title) async {
    int? value;
    return await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (val) {
              value = int.tryParse(val);
            },
            decoration: InputDecoration(hintText: "Enter a number"),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(value); // Return the entered value
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}


//Test

final List<Question> CircularQueueQuestions = [
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
];

class CircularqueueQuiz extends StatelessWidget {
  @override 
 Widget build(BuildContext context) {
  List<Question> randomQuestions = getRandomQuestions(CircularQueueQuestions);
  String testId = '4_circularQ'; // Example test_id, modify as needed
    return QuizUI(quizQuestions:randomQuestions, testId: testId); // Use the common UI
  }
}