import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class StackNotes extends StatelessWidget {
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
      const url = 'assets/notes/stack.pdf';  // Relative path to the PDF
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


class StackVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Purple theme
      ),
      home: StackScreen(),
    );
  }
}

class StackScreen extends StatefulWidget {
  @override
  _StackScreenState createState() => _StackScreenState();
}

class _StackScreenState extends State<StackScreen> {
  List<int?> stack = List.filled(7, null); // Stack initialized with null placeholders
  String currentAlgorithm = ""; // Holds the algorithm description
  String currentOutput = ""; // Holds the step-by-step output
  int topIndex = -1; // Keeps track of the current top index of the stack
  final int maxStackSize = 7; // Maximum stack size
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
                  // Right Container (for Stack Visualizer)
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Stack Visualizer',
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
                                scrollDirection: Axis.vertical,
                                child: Column(
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
                    onPressed: _createDefaultStack,
                    child: Text('Create Default'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple), // Purple buttons
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _showPushDialog(context),
                    child: Text('Push'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _popFromStack,
                    child: Text('Pop'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _peekStack,
                    child: Text('Peek'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _clearStack,
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

  // Create default stack
  void _createDefaultStack() {
    setState(() {
      stack = [10, 20, 30, null, null, null, null]; // Default stack with 3 elements
      topIndex = 2; // Set top index to 2
      currentHighlight = null;
      currentAlgorithm = """
1. A stack is a linear data structure that follows the LIFO (Last In First Out) principle.
2. 'Push' operation adds an element to the top of the stack.
3. 'Pop' operation removes the top element of the stack, leaving a placeholder.
4. 'Peek' operation returns the top element without removing it.
5. The maximum size of this stack is 7 elements.
6. 'Clear' operation removes all elements from the stack.
""";
      currentOutput = "Default stack created with values 10, 20, 30.";
    });
  }

  // Build the visual bars for the stack
  List<Widget> _buildBars() {
    return List<Widget>.generate(stack.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: AnimatedContainer(
          height: 50,
          width: 100,
          duration: Duration(milliseconds: 300),
          color: (index == currentHighlight)
              ? Colors.green // Highlight current operation element
              : (stack[index] == null ? Colors.grey : Colors.purple), // Purple for valid elements, grey for empty
          alignment: Alignment.center,
          child: Text(
            stack[index]?.toString() ?? '',
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

  // Show dialog to input value for pushing into the stack
  Future<void> _showPushDialog(BuildContext context) async {
    if (topIndex >= maxStackSize - 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Stack overflow! Max size of $maxStackSize reached."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    int? value = await _showInputDialog(context, 'Push Value');
    if (value != null) {
      setState(() {
        topIndex++; // Move the top index up
        stack[topIndex] = value; // Add element to the top of the stack
        currentHighlight = topIndex; // Highlight newly pushed element
        currentOutput += "Pushed $value onto the stack.\n";
      });
    }
  }

  // Pop an element from the stack (leave placeholder)
  void _popFromStack() {
    if (topIndex >= 0 && stack[topIndex] != null) {
      setState(() {
        int poppedValue = stack[topIndex]!; // Get the top element
        stack[topIndex] = null; // Leave placeholder
        currentHighlight = topIndex; // Highlight popped position
        topIndex--; // Move the top index down
        currentOutput += "Popped $poppedValue from the stack.\n";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Popped element: $poppedValue"),
            backgroundColor: Colors.green,
          ),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Stack underflow! Cannot pop from an empty stack."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Peek the top element of the stack
  void _peekStack() {
    if (topIndex >= 0 && stack[topIndex] != null) {
      int topValue = stack[topIndex]!; // Get the top element
      setState(() {
        currentHighlight = topIndex; // Highlight the top element
        currentOutput += "Top element is $topValue (peeked).\n";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Top element: $topValue"),
          backgroundColor: Colors.blue,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Stack is empty! No elements to peek."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Clear the stack
  void _clearStack() {
    setState(() {
      stack = List.filled(maxStackSize, null); // Clear all elements from the stack
      topIndex = -1; // Reset top index
      currentHighlight = null;
      currentOutput = "Stack cleared.";
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

final List<Question> StackQuestions = [
 Question(
    questionText: 'What is the time complexity for pushing an element onto a stack?',
    options: ['O(n)', 'O(log n)', 'O(1)', 'O(n log n)'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What is the primary data structure used to implement a stack?',
    options: ['Queue', 'Linked List', 'Array', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'Which of the following operations is not a valid stack operation?',
    options: ['Push', 'Pop', 'Peek', 'Insert'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'What is the last element that can be accessed in a stack data structure?',
    options: ['First element', 'Middle element', 'Last element', 'Top element'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'If a stack is implemented using an array, what happens if you try to push an element onto a full stack?',
    options: ['Underflow', 'Overflow', 'Stack is unchanged', 'Program crash'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which of the following is true about a stack?',
    options: ['It is a FIFO structure', 'It is a LIFO structure', 'It can grow in any direction', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What does the pop operation do in a stack?',
    options: ['Adds an element to the stack', 'Removes the top element', 'Returns the top element', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which operation is used to view the top element of a stack without removing it?',
    options: ['Pop', 'Peek', 'Push', 'Top'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'For an array-based implementation of a stack, which variable typically indicates the current top of the stack?',
    options: ['Size', 'Top', 'Count', 'Length'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What will happen if you call pop on an empty stack?',
    options: ['Returns null', 'Throws an exception', 'Returns 0', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Given the stack operations: Push(1), Push(2), Pop(), Push(3), what will the top element be?',
    options: ['1', '2', '3', 'Empty'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What is the maximum number of elements in a stack of size n?',
    options: ['n', 'n-1', 'n+1', '2n'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'If you have the following operations on an empty stack: Push(5), Push(10), Pop(), Push(20), what will the top element be?',
    options: ['5', '10', '20', 'Empty'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What type of problems can be solved using stacks?',
    options: ['Expression evaluation', 'Backtracking algorithms', 'Parenthesis matching', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'In which scenario would you use a stack data structure?',
    options: ['Undo functionality in text editors', 'Storing a list of items', 'Priority scheduling', 'None of the above'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'How would you check if a stack is empty?',
    options: ['Check if the top is null', 'Check if the size is 0', 'Both A and B', 'None of the above'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'For a stack with elements [1, 2, 3], what will be the state of the stack after performing a pop operation?',
    options: ['[1, 2, 3]', '[2, 3]', '[3]', '[]'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What is the result of performing Push(10), Push(20), Pop(), Push(30) on an empty stack?',
    options: ['10', '20', '30', '10, 30'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'If the stack is implemented using a linked list, how are the elements stored?',
    options: ['In contiguous memory locations', 'In non-contiguous memory locations', 'In a fixed size array', 'None of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What will be the contents of a stack after performing Push(5), Push(10), Push(15), Pop()?',
    options: ['[5, 10]', '[5, 10, 15]', '[10, 15]', '[15, 10, 5]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'In a stack, which of the following is not a method that is typically implemented?',
    options: ['Push', 'Pop', 'Peek', 'Merge'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'Which of the following statements is true about stacks?',
    options: ['Stacks are dynamic in size', 'Stacks can be implemented using arrays only', 'Stacks can hold duplicate elements', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'For a stack that can hold a maximum of 5 elements, what happens if you try to push the 6th element?',
    options: ['The 6th element is added', 'The stack will grow in size', 'Overflow error occurs', 'None of the above'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'How is the stack data structure categorized?',
    options: ['Linear', 'Non-linear', 'Both A and B', 'None of the above'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'What is the space complexity of a stack implemented using a linked list?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What data structure can be used to reverse a string?',
    options: ['Queue', 'Stack', 'Array', 'Tree'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What will be the output after performing these operations: Push(1), Push(2), Push(3), Pop(), Pop() on an empty stack?',
    options: ['1', '2', '3', '0'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which of the following can cause stack overflow?',
    options: ['Infinite recursion', 'Excessive stack push operations', 'Large data structures', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'If a stack contains elements [A, B, C, D] (with D at the top), what will be the result of performing two pops?',
    options: ['[A, B, C]', '[B, C, D]', '[A, B, C, D]', '[C, D]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'How would you implement a stack using two queues?',
    options: ['Using one queue for push and another for pop', 'Using one queue for pop and another for push', 'Using both queues for both push and pop', 'Not possible'],
    correctAnswerIndex: 0,
),
];
class StackQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(StackQuestions);
    String testId = '2'; // Example test_id, modify as needed
    return QuizUI(quizQuestions: randomQuestions, testId: testId); // Use the common UI
  }
}