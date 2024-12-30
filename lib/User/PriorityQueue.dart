import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      debugShowCheckedModeBanner: false,
      home: PriorityQueueScreen(),
    );
  }
}

class PriorityQueueScreen extends StatefulWidget {
  @override
  _PriorityQueueScreenState createState() => _PriorityQueueScreenState();
}

class _PriorityQueueScreenState extends State<PriorityQueueScreen> {
  List<QueueElement?> queue = List.filled(7, null); // Priority Queue with 7 slots
  String currentAlgorithm = ""; // To display algorithm explanation
  String currentOutput = ""; // To display step-by-step output

 
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

  // Operations buttons
  Widget _buildOperations() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      color: Colors.grey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ElevatedButton(
            onPressed: _createDefaultQueue,
            child: Text('Create Default'),
          ),
          ElevatedButton(
            onPressed: () => _showEnqueueDialog(context),
            child: Text('Enqueue'),
          ),
          ElevatedButton(
            onPressed: _dequeue,
            child: Text('Dequeue'),
          ),
          ElevatedButton(
            onPressed: _peek,
            child: Text('Peek'),
          ),
          ElevatedButton(
            onPressed: _clearQueue,
            child: Text('Clear'),
          ),
        ],
      ),
    );
  }

  // Create default priority queue
  void _createDefaultQueue() {
    setState(() {
      queue = [
        QueueElement(10, 2),
        QueueElement(20, 3),
        QueueElement(30, 1),
        null,
        null,
        null,
        null
      ];
      currentAlgorithm = """
1. A priority queue is a linear data structure where each element has a priority.
2. The element with the highest priority is dequeued first.
3. The 'Enqueue' operation inserts an element based on its priority.
4. The 'Dequeue' operation removes the element with the highest priority.
5. The 'Peek' operation returns the element with the highest priority without removing it.
6. The maximum size of the queue is 7 elements.
""";
      currentOutput = "Default priority queue created with values 10 (priority 2), 20 (priority 3), 30 (priority 1).";
    });
  }

  // Build queue visualizer bars
  List<Widget> _buildQueueBars() {
    return List<Widget>.generate(queue.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Container(
          height: 50,
          width: 50,
          color: queue[index] == null ? Colors.grey : Colors.purple,
          alignment: Alignment.center,
          child: Text(
            queue[index]?.value?.toString() ?? '',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      );
    });
  }

  // Show dialog for enqueue
  Future<void> _showEnqueueDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Enqueue Value');
    int? priority = await _showInputDialog(context, 'Enqueue Priority');
    if (value != null && priority != null) {
      setState(() {
        if (queue.every((element) => element != null)) {
          _showSnackbar(context, 'Queue overflow!');
          return;
        }
        _enqueue(QueueElement(value, priority));
        currentOutput += "Enqueued $value with priority $priority.\n";
      });
    }
  }

  // Enqueue operation for priority queue
 // Enqueue operation for priority queue
void _enqueue(QueueElement element) {
  // Find the position to insert the new element based on its priority
  int insertIndex = -1;
  for (int i = 0; i < queue.length; i++) {
    if (queue[i] == null || queue[i]!.priority > element.priority) {
      insertIndex = i;
      break;
    }
  }

  // If insertIndex is -1, it means the element has the lowest priority, so add it at the end
  if (insertIndex == -1) {
    insertIndex = queue.length - 1;
  }

  // Shift elements to the right to make space for the new element
  for (int i = queue.length - 1; i > insertIndex; i--) {
    queue[i] = queue[i - 1];
  }

  // Insert the new element at the correct position
  queue[insertIndex] = element;
}


  // Dequeue operation (removes the element with the highest priority)
  // Dequeue operation (removes the element with the highest priority)
// Dequeue operation (removes the element with the highest priority)
void _dequeue() {
  // Check if the queue is empty
  if (queue.every((element) => element == null)) {
    _showSnackbar(context, 'Queue underflow!');
    return;
  }

  // Find the element with the highest priority (smallest priority value)
  int highestPriorityIndex = -1;
  int? highestPriority = null;

  for (int i = 0; i < queue.length; i++) {
    if (queue[i] != null && (highestPriority == null || queue[i]!.priority < highestPriority!)) {
      highestPriority = queue[i]!.priority;
      highestPriorityIndex = i;
    }
  }

  // Remove the element (set it to null)
  if (highestPriorityIndex != -1) {
    setState(() {
      QueueElement? dequeuedValue = queue[highestPriorityIndex];
      queue[highestPriorityIndex] = null;
      currentOutput += "Dequeued ${dequeuedValue?.value} with priority ${dequeuedValue?.priority}.\n";
    });
  }
}



  // Peek operation
  void _peek() {
    QueueElement? peekedValue = queue.firstWhere((element) => element != null, orElse: () => null);
    if (peekedValue == null) {
      _showSnackbar(context, 'Queue is empty!');
      return;
    }
    setState(() {
      currentOutput += "Peeked ${peekedValue.value} with priority ${peekedValue.priority}.\n";
    });
  }

  // Clear queue
  void _clearQueue() {
    setState(() {
      queue = List.filled(queue.length, null);
      currentOutput = "Queue cleared.\n";
    });
  }

  // Show snackbar with red color
  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // Show input dialog
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
                Navigator.of(context).pop(value);
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}

// A class to represent each element in the priority queue
class QueueElement {
  final int value;
  final int priority;

  QueueElement(this.value, this.priority);
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
    String testId = 'Priority Queue'; // Example test_id, modify as needed
    return QuizUI(quizQuestions: randomQuestions, testId: testId); // Use the common UI
  }
}