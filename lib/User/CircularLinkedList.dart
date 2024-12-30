import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class CircularlinkedlistNotes extends StatelessWidget {
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
  runApp(CircularLinkedListVisualizerApp());
}

class Node {
  int value;
  Node? next;

  Node(this.value);
}

class CircularLinkedList {
  Node? head;

  void insert(int value, int index) {
    Node newNode = Node(value);
    if (head == null) {
      if (index == 0) {
        head = newNode;
        newNode.next = head;
      }
    } else {
      if (index == 0) {
        Node? current = head;
        while (current?.next != head) {
          current = current?.next!;
        }
        current?.next = newNode;
        newNode.next = head;
        head = newNode; // Update head if inserting at index 0
      } else {
        Node? current = head;
        int currentIndex = 0;

        while (currentIndex < index - 1 && current?.next != head) {
          current = current?.next!;
          currentIndex++;
        }

        newNode.next = current?.next;
        current?.next = newNode;
      }
    }
  }

  int? delete(int value) {
    if (head == null) return null;

    Node current = head!;
    Node? previous;

    // Check if the head needs to be deleted
    if (current.value == value) {
      if (current.next == head) {
        head = null; // List becomes empty
      } else {
        while (current.next != head) {
          current = current.next!;
        }
        current.next = head!.next; // Remove head
        head = head!.next; // Update head
      }
      return value;
    }

    do {
      previous = current;
      current = current.next!;
    } while (current != head && current.value != value);

    if (current.value == value) {
      previous!.next = current.next; // Remove the node
      return value;
    }

    return null; // Value not found
  }

  List<int> getElements() {
    List<int> elements = [];
    if (head == null) return elements;

    Node current = head!;
    do {
      elements.add(current.value);
      current = current.next!;
    } while (current != head);

    return elements;
  }

  void clear() {
    head = null;
  }
}

class CircularLinkedListVisualizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircularLinkedListScreen(),
    );
  }
}

class CircularLinkedListScreen extends StatefulWidget {
  @override
  _CircularLinkedListScreenState createState() =>
      _CircularLinkedListScreenState();
}

class _CircularLinkedListScreenState extends State<CircularLinkedListScreen> {
  late CircularLinkedList linkedList;
  String currentOutput = "";

  @override
  void initState() {
    super.initState();
    linkedList = CircularLinkedList();
  }

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
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.grey.shade300,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Circular Linked List Algorithm',
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
                                _getAlgorithmDescription(),
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          SizedBox(height: 20), // Spacing between sections
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
                            child: Container(
                              constraints: BoxConstraints(
                                minHeight: 100, // Minimum height
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  currentOutput,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Circular Linked List Visualizer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Divider(),
                          Expanded(
                            child: Center(
                              child: _buildLinkedListVisualization(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              color: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => _showInsertDialog(context),
                    child: Text('Insert'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _showDeleteDialog(context),
                    child: Text('Delete'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _clearList,
                    child: Text('Clear List'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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

  String _getAlgorithmDescription() {
    return "1. **Insert**:\n"
        "   - Add a new node to the circular linked list at a specified index.\n"
        "   - If the list is empty, set the head to the new node.\n"
        "   - Otherwise, traverse to the specified index and link it to the new node.\n\n"
        "2. **Delete**:\n"
        "   - Remove a node with the specified value from the circular linked list.\n"
        "   - If the node is the head, update the head to the next node.\n\n"
        "3. **Clear List**:\n"
        "   - Remove all nodes from the list and set head to null.\n";
  }

  Widget _buildLinkedListVisualization() {
    List<int> elements = linkedList.getElements();

    if (elements.isEmpty) {
      return Text(
        'List is empty',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      );
    }

    List<Widget> nodes = [];
    for (int i = 0; i < elements.length; i++) {
      int value = elements[i];
      nodes.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              Container(
                height: 80,
                width: 120, // Width adjusted to fit both parts
                color: Colors.purple,
                child: Column(
                  children: [
                    // Value section
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.white, height: 1), // Divider between value and address
                    // Display the memory address of the next node
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Next: ${linkedList.getNodeAddress(elements[(i + 1) % elements.length])}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 40,
                color: Colors.purple,
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: nodes,
      ),
    );
  }

  Future<void> _showInsertDialog(BuildContext context) async {
    int? value = await _showInputDialogForValue(context, 'Insert Value');
    int? index = await _showInputDialogForIndex(context, 'Insert Index');
    if (value != null && index != null) {
      setState(() {
        linkedList.insert(value, index);
        currentOutput += "Inserted $value at index $index.\n";
      });
    }
  }

  Future<void> _showDeleteDialog(BuildContext context) async {
    int? value = await _showInputDialogForValue(context, 'Delete Value');
    if (value != null) {
      setState(() {
        var deletedValue = linkedList.delete(value);
        if (deletedValue != null) {
          currentOutput += "Deleted $deletedValue from the list.\n";
        } else {
          currentOutput += "$value not found in the list.\n";
        }
      });
    }
  }

  Future<int?> _showInputDialogForValue(BuildContext context, String title) {
    TextEditingController valueController = TextEditingController();
    return showDialog<int?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: valueController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Enter value'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                int? value = int.tryParse(valueController.text);
                Navigator.of(context).pop(value);
              },
            ),
          ],
        );
      },
    );
  }

  Future<int?> _showInputDialogForIndex(BuildContext context, String title) {
    TextEditingController indexController = TextEditingController();
    return showDialog<int?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: indexController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Enter index'),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                int? index = int.tryParse(indexController.text);
                Navigator.of(context).pop(index);
              },
            ),
          ],
        );
      },
    );
  }

  void _clearList() {
    setState(() {
      linkedList.clear();
      currentOutput += "Cleared the list.\n";
    });
  }
}

extension on CircularLinkedList {
  String getNodeAddress(int value) {
    Node? current = head;
    if (current == null) return "null";

    do {
      if (current?.value == value) {
        return current?.next?.hashCode.toString() ?? "null"; // Return address of the next node
      }
      current = current?.next;
    } while (current != head);

    return "not found";
  }
}



//Test


final List<Question> CircularLinkedListQuestions = [
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

class CircularlinkedlistQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(CircularLinkedListQuestions);
    String testId = 'Circular Linked List'; // Example test_id, modify as needed
    return QuizUI(quizQuestions:randomQuestions, testId: testId); // Use the common UI
  }
}