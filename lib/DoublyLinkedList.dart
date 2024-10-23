import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';


class DoublylinkedlistNotes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: Text('Opening PDF...'),
      ),
    );
  }
}


void main() {
  runApp(DoublyLinkedListVisualizerApp());
}

class DoublyNode {
  final int value;
  DoublyNode? next;
  DoublyNode? prev;

  DoublyNode(this.value);
}

class DoublyLinkedListVisualizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Doubly Linked List Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: DoublyLinkedListScreen(),
    );
  }
}

class DoublyLinkedListScreen extends StatefulWidget {
  @override
  _DoublyLinkedListScreenState createState() => _DoublyLinkedListScreenState();
}

class _DoublyLinkedListScreenState extends State<DoublyLinkedListScreen>
    with SingleTickerProviderStateMixin {
  DoublyNode? head;
  String currentOutput = "";
  bool isAnimating = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                          // Container for Algorithm Description
                          Text(
                            'Doubly Linked List Algorithm',
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
                            'Doubly Linked List Visualizer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Divider(),
                          Expanded(
                            child: Center(
                              child: _buildAnimatedDoublyLinkedList(),
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
                    onPressed: isAnimating ? null : () => _showAddNodeDialog(context),
                    child: Text('Add Node'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isAnimating ? null : _showRemoveNodeDialog,
                    child: Text('Remove Node'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isAnimating ? null : _clearList,
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
    return "1. **Add Node**:\n"
        "   - Create a new node with the specified value.\n"
        "   - If the position is 1 or the list is empty, set the new node as the head.\n"
        "   - Otherwise, traverse the list to the specified position and insert the node.\n\n"
        "2. **Remove Node**:\n"
        "   - Check if the list is empty.\n"
        "   - If the head contains the specified value, update the head.\n"
        "   - Otherwise, traverse the list to find the node with the specified value and remove it.\n";
  }

  Widget _buildAnimatedDoublyLinkedList() {
    if (head == null) {
      return Text(
        'List is empty',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      );
    }

    List<Widget> nodes = [];
    DoublyNode? currentNode = head;

    while (currentNode != null) {
      nodes.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              Container(
                height: 80,
                width: 120,
                color: Colors.purple,
                child: Column(
                  children: [
                    // Value section
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          currentNode.value.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.white, height: 1), // Divider between value and addresses
                  ],
                ),
              ),
              // Previous Address section
              Container(
                height: 30,
                width: 120,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  'Prev: ${currentNode.prev != null ? currentNode.prev.hashCode.toString() : 'null'}',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              // Next Address section
              Container(
                height: 30,
                width: 120,
                color: Colors.green,
                alignment: Alignment.center,
                child: Text(
                  'Next: ${currentNode.next != null ? currentNode.next.hashCode.toString() : 'null'}',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
              if (currentNode.next != null)
                Icon(
                  Icons.arrow_forward,
                  size: 40,
                  color: Colors.purple,
                ),
            ],
          ),
        ),
      );
      currentNode = currentNode.next;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: nodes,
      ),
    );
  }

  Future<void> _showAddNodeDialog(BuildContext context) async {
    Map<String, dynamic>? result = await _showInputDialog(context, 'Add Node Value', true);
    if (result != null) {
      setState(() {
        int value = result['value'];
        int position = result['position'];
        _addNode(value, position);
      });
    }
  }

  Future<void> _showRemoveNodeDialog() async {
    int? value = await _showInputDialogForValue(context, 'Remove Node by Value');
    if (value != null) {
      setState(() {
        _removeNode(value);
      });
    }
  }

  bool _isListEmpty() {
    return head == null;
  }

  DoublyNode? _traverseTo(int position) {
    DoublyNode? current = head;
    for (int i = 1; i < position; i++) {
      if (current == null) {
        return null;
      }
      current = current.next;
    }
    return current;
  }

  Future<void> _addNode(int value, int position) async {
    if (isAnimating) return;

    isAnimating = true;
    DoublyNode newNode = DoublyNode(value);

    // Start with the algorithm description
    currentOutput = "Algorithm for Add Node:\n"
        "1. Create a new node with value $value.\n"
        "2. If position is 1 or list is empty, update head.\n"
        "3. Else, traverse to position and insert node.\n\n";

    if (position <= 1 || _isListEmpty()) {
      newNode.next = head;
      if (head != null) {
        head!.prev = newNode;
      }
      head = newNode;
      currentOutput += "Added node with value $value at position 1 (as head).\n";
    } else {
      DoublyNode? current = _traverseTo(position - 1);
      if (current != null) {
        newNode.next = current.next;
        newNode.prev = current;
        current.next = newNode;
        if (newNode.next != null) {
          newNode.next!.prev = newNode;
        }
        currentOutput += "Added node with value $value at position $position.\n";
      } else {
        currentOutput += "Position $position is out of bounds.\n";
      }
    }

    _controller.reset();
    _controller.forward();

    setState(() {});
    isAnimating = false;
  }

  Future<void> _removeNode(int value) async {
    if (isAnimating) return;

    if (_isListEmpty()) {
      setState(() {
        currentOutput = "List is empty! Cannot remove node.";
      });
      return;
    }

    isAnimating = true;
    currentOutput = "Algorithm for Remove Node:\n"
        "1. Check if the list is empty.\n"
        "2. If head contains value $value, update head.\n"
        "3. Otherwise, traverse the list to find the node.\n\n";

    // Handle removal
    if (head!.value == value) {
      head = head!.next;
      if (head != null) {
        head!.prev = null;
      }
      currentOutput += "Removed node with value $value from the head.\n";
    } else {
      DoublyNode? current = head;
      while (current != null && current.value != value) {
        current = current.next;
      }
      if (current != null) {
        if (current.next != null) {
          current.next!.prev = current.prev;
        }
        if (current.prev != null) {
          current.prev!.next = current.next;
        }
        currentOutput += "Removed node with value $value from the list.\n";
      } else {
        currentOutput += "Node with value $value not found.\n";
      }
    }

    _controller.reset();
    _controller.forward();

    setState(() {});
    isAnimating = false;
  }

  Future<Map<String, dynamic>?> _showInputDialog(
      BuildContext context, String title, bool forAdd) {
    TextEditingController valueController = TextEditingController();
    TextEditingController positionController = TextEditingController();

    return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: valueController,
                  decoration: InputDecoration(hintText: 'Node Value'),
                  keyboardType: TextInputType.number,
                ),
                if (forAdd)
                  TextField(
                    controller: positionController,
                    decoration: InputDecoration(hintText: 'Position (1-based)'),
                    keyboardType: TextInputType.number,
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
              child: Text('Add'),
              onPressed: () {
                int value = int.parse(valueController.text);
                int position = forAdd ? int.parse(positionController.text) : 1;
                Navigator.of(context).pop({'value': value, 'position': position});
              },
            ),
          ],
        );
      },
    );
  }

  Future<int?> _showInputDialogForValue(BuildContext context, String title) {
    TextEditingController valueController = TextEditingController();

    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                  controller: valueController,
                  decoration: InputDecoration(hintText: 'Node Value'),
                  keyboardType: TextInputType.number,
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
              child: Text('Remove'),
              onPressed: () {
                int value = int.parse(valueController.text);
                Navigator.of(context).pop(value);
              },
            ),
          ],
        );
      },
    );
  }

  void _clearList() {
    setState(() {
      head = null;
      currentOutput = "Cleared the list.\n";
    });
  }
}



// Test


final List<Question> DoublyLinkedListQuestions = [
Question(
  questionText: 'What is a doubly linked list?',
  options: ['A list where each node has two pointers', 'A list with one pointer per node', 'A circular list', 'A list with no pointers'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What are the advantages of using a doubly linked list over a singly linked list?',
  options: ['Easier to traverse backwards', 'Easier to insert and delete nodes', 'Both A and B', 'None of the above'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'What is the time complexity to insert a new node at the beginning of a doubly linked list?',
  options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to delete a node from a doubly linked list?',
  options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a doubly linked list, what does the next pointer in a node point to?',
  options: ['The next node in the list', 'The previous node', 'Null', 'The head node'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a doubly linked list, what does the previous pointer in the head node point to?',
  options: ['Null', 'The tail node', 'The next node', 'The middle node'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to search for an element in a doubly linked list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you traverse a doubly linked list in reverse?',
  options: ['Use the previous pointer', 'Use the next pointer', 'Start from the head', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following operations can be performed on a doubly linked list?',
  options: ['Insertion', 'Deletion', 'Traversal', 'All of the above'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'What is the space complexity of a doubly linked list with n nodes?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you insert a new node at the end of a doubly linked list?',
  options: ['Traverse to the last node and update its pointers', 'Insert at the head', 'Use the middle node', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens when you delete the tail node of a doubly linked list?',
  options: ['The second last node’s next pointer will be set to null', 'The list becomes empty', 'The head node will be removed', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you find the length of a doubly linked list?',
  options: ['Traverse the list and count nodes', 'Use the head pointer', 'All nodes have fixed sizes', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the main disadvantage of a doubly linked list?',
  options: ['More memory usage due to extra pointers', 'Slower traversal', 'More complex implementation', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following is true about the first node in a doubly linked list?',
  options: ['It has a null previous pointer', 'It has a null next pointer', 'Both A and B', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you delete a specific node in a doubly linked list?',
  options: ['Update the next and previous pointers of adjacent nodes', 'Set the node’s next pointer to null', 'Set the node’s previous pointer to null', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens if you try to access a node that is out of bounds in a doubly linked list?',
  options: ['Returns null', 'Throws an error', 'Returns the head', 'Returns the tail'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'What is a common application of doubly linked lists?',
  options: ['Undo functionality in applications', 'Implementation of stacks', 'Queue operations', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which pointer in a doubly linked list is used to traverse forward?',
  options: ['Next pointer', 'Previous pointer', 'Both pointers', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you detect a cycle in a doubly linked list?',
  options: ['Use two pointers (slow and fast)', 'Check the previous pointer', 'Use a hash table', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a doubly linked list, which pointer is updated when a new node is inserted at the beginning?',
  options: ['Both previous and next pointers of the new node', 'Only the next pointer', 'Only the previous pointer', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the result of deleting the head node in a doubly linked list?',
  options: ['The second node becomes the new head', 'The list remains unchanged', 'All nodes are deleted', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which operation is NOT efficient in a doubly linked list?',
  options: ['Accessing elements by index', 'Inserting at the beginning', 'Inserting at the end', 'Traversing the list'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Given a doubly linked list, what will be the previous node of the head in a list [10 <-> 20 <-> 30]?',
  options: ['20', '30', 'Null', 'None of the above'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'How do you implement a doubly linked list in memory?',
  options: ['Using nodes with two pointers', 'Using arrays', 'Using stacks', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of reversing a doubly linked list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What type of traversal can you perform on a doubly linked list?',
  options: ['Forward only', 'Backward only', 'Both forward and backward', 'None of the above'],
  correctAnswerIndex: 2,
),
];

class DoublylinkedlistQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(DoublyLinkedListQuestions);
    return QuizUI(quizQuestions: randomQuestions); // Use the common UI
  }
}