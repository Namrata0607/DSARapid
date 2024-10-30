import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PriorityQNotes extends StatelessWidget {
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
      const url = 'assets/notes/array.pdf';  // Relative path to the PDF
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
  runApp(PriorityQueueVisualizerApp());
}

class PriorityQueueVisualizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Priority Queue Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: PriorityQueueScreen(),
    );
  }
}

// Class representing a queue element with value and priority
class QueueElement {
  final int value;
  final int priority;

  QueueElement(this.value, this.priority);
}

class PriorityQueueScreen extends StatefulWidget {
  @override
  _PriorityQueueScreenState createState() => _PriorityQueueScreenState();
}

class _PriorityQueueScreenState extends State<PriorityQueueScreen> {
  List<QueueElement?> queue = List.filled(7, null); // Priority Queue with 7 slots
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
                            'Priority Queue Visualizer',
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

  // Create default priority queue
  void _createDefaultQueue() {
    setState(() {
      queue = [
        QueueElement(10, 1),
        QueueElement(20, 2),
        QueueElement(30, 3),
        null,
        null,
        null,
        null
      ]; // Initialize default values with priority
      front = 0;
      rear = 2;
      currentHighlight = null;
      currentAlgorithm = """
1. A priority queue is a data structure where each element has a priority.
2. The element with the highest priority is served before the others.
3. In this visualizer, lower numbers represent higher priority (1 is the highest).
4. Elements are inserted in priority order, with the highest priority at the front.
5. Dequeue removes the element with the highest priority (lowest number).
6. Peek shows the element with the highest priority.
""";
      currentOutput =
          "Default priority queue created with values 10 (priority 1), 20 (priority 2), 30 (priority 3).\n";
    });
  }

  // Build the queue bars for visualizing
  List<Widget> _buildQueueBars() {
    return List<Widget>.generate(queue.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: AnimatedContainer(
          height: 70,
          width: 50,
          duration: Duration(milliseconds: 300),
          color: (index == currentHighlight)
              ? Colors.green
              : (queue[index] == null ? Colors.grey : Colors.purple),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                queue[index]?.value.toString() ?? '',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (queue[index] != null)
                Text(
                  "P${queue[index]?.priority.toString() ?? ''}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  // Show dialog to input value and priority for enqueueing
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
    int? priority = await _showInputDialog(context, 'Enqueue Priority');
    if (value != null && priority != null) {
      setState(() {
        _insertInPriorityOrder(QueueElement(value, priority));
      });
    }
  }

  // Insert a new element in the queue based on its priority
  Future<void> _insertInPriorityOrder(QueueElement newElement) async {
    if (front == -1) {
      // First element in an empty queue
      front = rear = 0;
      queue[rear] = newElement;
      currentHighlight = rear;
      currentOutput +=
          "Enqueued ${newElement.value} with priority ${newElement.priority} as the first element.\n";
      await Future.delayed(Duration(seconds: 1)); // Delay for visibility
    } else {
      // Inserting in a non-empty queue
      int i = rear; // Start from the current rear position
      while (i != (front - 1 + maxSize) % maxSize &&
          queue[i]!.priority > newElement.priority) {
        queue[(i + 1) % maxSize] = queue[i]; // Shift element right
        i = (i - 1 + maxSize) % maxSize; // Move left in circular queue

        // Add delay to show shifting process
        await Future.delayed(Duration(seconds: 1)); // Delay for visibility
      }

      // Check for queue overflow (after incrementing rear)
      if ((rear + 1) % maxSize == front) {
        // Revert rear pointer if overflow happens
        rear = (rear - 1 + maxSize) % maxSize;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Queue overflow! Max size of $maxSize reached."),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Insert the new element at the correct position
      queue[(i + 1) % maxSize] = newElement;
      currentHighlight = (i + 1) % maxSize;

      // Adjust rear pointer
      rear = (rear + 1) % maxSize;

      currentOutput +=
          "Enqueued ${newElement.value} with priority ${newElement.priority}.\n";
      await Future.delayed(Duration(seconds: 1)); // Delay after insertion
    }
  }

  // Dequeue operation
  void _dequeue() {
    if (front == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Queue underflow! No elements to dequeue."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      currentOutput +=
          "Dequeued ${queue[front]?.value} with priority ${queue[front]?.priority}.\n";
      queue[front] = null; // Remove the front element
      if (front == rear) {
        // Queue becomes empty
        front = rear = -1;
      } else {
        front = (front + 1) % maxSize; // Move front pointer forward
      }
      currentHighlight = front;
    });
  }

  // Peek operation
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
      currentOutput +=
          "Peeked at ${queue[front]?.value} with priority ${queue[front]?.priority}.\n";
      currentHighlight = front;
    });
  }

  // Clear the queue
  void _clearQueue() {
    setState(() {
      queue = List.filled(maxSize, null);
      front = rear = -1;
      currentHighlight = null;
      currentOutput += "Cleared the queue.\n";
    });
  }

  // Helper function to show input dialog for value/priority
  Future<int?> _showInputDialog(BuildContext context, String title) async {
    int? result;
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter $title"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                result = int.tryParse(controller.text);
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
    return result;
  }
}

//Test

final List<Question> PriorityQueueQuestions = [
  Question(
    questionText: 'What is a priority queue?',
    options: [
      'A queue where elements are processed in the order they arrive',
      'A queue where each element has a priority, and higher priority elements are dequeued first',
      'A queue where elements can only be dequeued in reverse order',
      'A queue where elements are processed alphabetically'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which data structure is commonly used to implement a priority queue?',
    options: [
      'Array',
      'Linked list',
      'Heap',
      'Stack'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the time complexity of insertion in a priority queue using a binary heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'In a priority queue, which element is dequeued first?',
    options: [
      'The element with the highest priority',
      'The element with the lowest priority',
      'The element that was added last',
      'The element with the middle priority'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity of deleting the maximum (or minimum) element in a priority queue implemented with a heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  
  Question(
    questionText: 'What is the best data structure for implementing a priority queue when frequent access to the highest-priority element is required?',
    options: [
      'Stack',
      'Binary heap',
      'Queue',
      'Linked list'
    ],
    correctAnswerIndex: 1,
  ),

  Question(
    questionText: 'Which of the following is an application of priority queues?',
    options: [
      'Job scheduling in operating systems',
      'Breadth-first search',
      'Quick sort',
      'Depth-first search'
    ],
    correctAnswerIndex: 0,
  ),
  

  Question(
    questionText: 'How is the priority determined in a priority queue?',
    options: [
      'By the order of insertion',
      'By a predefined comparison of elements',
      'By the user input during insertion',
      'Randomly'
    ],
    correctAnswerIndex: 1,
  ),

  Question(
    questionText: 'What is a major advantage of a priority queue over a regular queue?',
    options: [
      'It is faster for enqueuing operations',
      'It allows elements to be dequeued based on their priority rather than their order of arrival',
      'It can store more elements',
      'It requires less memory'
    ],
    correctAnswerIndex: 1,
  ),

  Question(
    questionText: 'Which operation is faster in a binary heap compared to a sorted array?',
    options: [
      'Insert',
      'Find max',
      'Delete max',
      'Traversal'
    ],
    correctAnswerIndex: 0,
  ),

  Question(
    questionText: 'Which operation is used to remove the highest-priority element from a priority queue?',
    options: [
      'Delete',
      'Dequeue',
      'Extract',
      'Pop'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is the most efficient way to implement a priority queue with frequent insertions?',
    options: [
      'Sorted array',
      'Unsorted array',
      'Binary heap',
      'Linked list'
    ],
    correctAnswerIndex: 2,
  ),
  
  Question(
    questionText: 'In which of the following scenarios is a priority queue most useful?',
    options: [
      'Sorting data in ascending order',
      'Finding the median of a set of elements',
      'Managing job scheduling tasks',
      'Performing depth-first search'
    ],
    correctAnswerIndex: 2,
  ),
  
  Question(
    questionText: 'In a priority queue, what is the time complexity of inserting an element when implemented using an unsorted array?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the primary difference between a regular queue and a priority queue?',
    options: [
      'Regular queues are faster than priority queues',
      'Priority queues process elements based on priority rather than order of insertion',
      'Regular queues can only store integers',
      'Priority queues allow duplicates while regular queues do not'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What happens if two elements have the same priority in a priority queue?',
    options: [
      'One element is discarded',
      'Both elements are removed at once',
      'The order of insertion is preserved (FIFO)',
      'They cannot be inserted into the queue'
    ],
    correctAnswerIndex: 2,
  ),

  Question(
    questionText: 'Which of the following can be used to implement a priority queue with a time complexity of O(1) for insertion?',
    options: [
      'Binary heap',
      'Fibonacci heap',
      'Sorted array',
      'Unsorted linked list'
    ],
    correctAnswerIndex: 3,
  ),
];

class PriorityqueueQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(PriorityQueueQuestions);
    return QuizUI(quizQuestions: randomQuestions); // Use the common UI
  }
}