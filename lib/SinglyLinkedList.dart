import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class linkedlistNotes extends StatelessWidget {
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
  runApp(LinkedListVisualizerApp());
}

class LinkedListVisualizerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Linked List Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LinkedListScreen(),
    );
  }
}

class Node {
  final int value;
  Node? next;

  Node(this.value);
}

class LinkedListScreen extends StatefulWidget {
  @override
  _LinkedListScreenState createState() => _LinkedListScreenState();
}

class _LinkedListScreenState extends State<LinkedListScreen>
    with SingleTickerProviderStateMixin {
  Node? head;
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
                            'Linked List Algorithm',
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
                            'Linked List Visualizer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Divider(),
                          Expanded(
                            child: Center(
                              child: _buildAnimatedLinkedList(),
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

  Widget _buildAnimatedLinkedList() {
    if (head == null) {
      return Text(
        'List is empty',
        style: TextStyle(fontSize: 18, color: Colors.grey),
      );
    }

    List<Widget> nodes = [];
    Node? currentNode = head;

    while (currentNode != null) {
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
                          currentNode.value.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Colors.white, height: 1), // Divider between value and address
                    // Address section
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Next: ${currentNode.next != null ? currentNode.next.hashCode.toString() : 'null'}',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
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

  Node? _traverseTo(int position) {
    Node? current = head;
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
    Node newNode = Node(value);

    // Start with the algorithm description
    currentOutput = "Algorithm for Add Node:\n"
        "1. Create a new node with value $value.\n"
        "2. If position is 1 or list is empty, update head.\n"
        "3. Else, traverse to position and insert node.\n\n";

    if (position <= 1 || _isListEmpty()) {
      newNode.next = head;
      head = newNode;
      currentOutput += "Added node with value $value at position 1.\n";
    } else {
      Node? current = _traverseTo(position - 1);
      if (current != null) {
        newNode.next = current.next;
        current.next = newNode;
        currentOutput += "Added node with value $value at position $position.\n";
      } else {
        currentOutput += "Position $position is out of bounds. Node not added.\n";
      }
    }

    _controller.reset();
    _controller.forward();

    setState(() {});
    isAnimating = false;
  }

  Future<void> _removeNode(int value) async {
    if (_isListEmpty()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('List is empty! Cannot remove node.'),
      ));
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
      currentOutput += "Removed node with value $value from the head.\n";
    } else {
      Node? current = head;
      while (current!.next != null && current.next!.value != value) {
        current = current.next!;
      }
      if (current.next != null) {
        current.next = current.next!.next;
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

// List of questions (Singly linked list questions in data structure)
final List<Question> allQuestions = [
Question(
  questionText: 'What is the time complexity to insert a new node at the beginning of a singly linked list?',
  options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to insert a new node at the end of a singly linked list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the structure of a node in a singly linked list?',
  options: ['Data and one pointer to the next node', 'Data and two pointers to the next and previous nodes', 'Only data', 'Only pointer'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to access an element at the nth position in a singly linked list?',
  options: ['O(n)', 'O(1)', 'O(n log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a singly linked list, how do you traverse the list?',
  options: ['Start from the head and move through each node using the next pointer', 'Start from the tail and move backwards', 'Access the middle node and move in both directions', 'All of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you check if a singly linked list is empty?',
  options: ['Check if the head is null', 'Check if the tail is null', 'Check if the next pointer is null', 'Check if all nodes have data'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of deleting the first node in a singly linked list?',
  options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which operation is not possible in a singly linked list?',
  options: ['Deleting a node', 'Traversing the list', 'Reversing the list', 'Accessing the previous node from a given node'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'How do you reverse a singly linked list?',
  options: ['By changing the next pointers of each node in the list', 'By swapping data between nodes', 'By creating a new linked list', 'By using a queue'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to reverse a singly linked list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Given a singly linked list, what is the time complexity to find the length of the list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the head of a singly linked list?',
  options: ['The first node', 'The last node', 'The middle node', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What does the next pointer in the last node of a singly linked list point to?',
  options: ['Null', 'Head', 'The second node', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens when you try to access an element beyond the length of a singly linked list?',
  options: ['Returns null', 'Throws an error', 'Returns the last element', 'Returns the first element'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'What is the space complexity of a singly linked list with n nodes?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is a common use case for a singly linked list?',
  options: ['Dynamic memory allocation', 'Binary search implementation', 'Stack implementation', 'None of the above'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'How do you add a node after a specific node in a singly linked list?',
  options: ['Update the next pointer of the specific node to point to the new node', 'Update the previous node\'s pointer', 'Swap the data', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following is NOT a valid operation in a singly linked list?',
  options: ['Insert at the beginning', 'Delete from the middle', 'Access by index in O(1)', 'Traverse through all nodes'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'In a singly linked list, what will happen if you remove the last node?',
  options: ['The second last node’s next pointer will be set to null', 'The list will break', 'The first node will be removed', 'All nodes will be deleted'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following data structures can be implemented using a singly linked list?',
  options: ['Stack', 'Queue', 'Both Stack and Queue', 'Binary Tree'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'How do you insert a new node at the end of a singly linked list?',
  options: ['Traverse the list to the last node and update its next pointer', 'Insert it at the head', 'Swap it with the middle node', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you check if a singly linked list has a cycle?',
  options: ['Use two pointers (slow and fast)', 'Check if the head is null', 'Check if all nodes have the same data', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity to search for an element in a singly linked list?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Given a singly linked list, what will be the next node after head in a list [10 -> 20 -> 30 -> 40]?',
  options: ['20', '30', '40', 'None'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens if you delete the head of a singly linked list?',
  options: ['The second node becomes the new head', 'The list is destroyed', 'All nodes are deleted', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the last node of a singly linked list typically called?',
  options: ['Tail', 'Head', 'Middle', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following operations is slow in a singly linked list compared to an array?',
  options: ['Accessing elements by index', 'Inserting at the head', 'Inserting at the tail', 'All of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'How do you detect the middle element of a singly linked list?',
  options: ['Use two pointers (slow and fast)', 'Traverse the list twice', 'Use the head pointer', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens when you try to access the tail’s next pointer in a singly linked list?',
  options: ['It points to null', 'It points to the head', 'It points to the second last node', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the advantage of a singly linked list over an array?',
  options: ['Dynamic size allocation', 'Constant time access to elements', 'Less memory usage', 'None of the above'],
  correctAnswerIndex: 0,
),
];

//void main() => runApp(QuizApp());

class SinglylinkedlistQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Singly linked list Quiz',
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBack(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isSubmitted ? buildResultScreen() : buildQuizBody(),
        ),
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
        Center(
          child: SizedBox(
            width: 600,
            height: 60,
            child: ElevatedButton(
              onPressed: selectedAnswers.length == quizQuestions.length
                  ? submitQuiz
                  : null, // Enable button only if all questions are answered
              child: Text('Submit Quiz',
              style: TextStyle(
                fontSize: 20
              ),),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0), 
                backgroundColor: Color.fromARGB(255, 105, 1, 161),
                foregroundColor: Colors.white,
              ),
            ),
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



