import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';


class HeaptreeNotes extends StatelessWidget {
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

//visualizer

class HeapTree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Heap Tree Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HeapTreeScreen(),
    );
  }
}

class HeapTreeScreen extends StatefulWidget {
  @override
  _HeapTreeScreenState createState() => _HeapTreeScreenState();
}

class _HeapTreeScreenState extends State<HeapTreeScreen> {
  MinHeap? heap; // Min Heap object
  String currentAlgorithm = ""; // Holds the current algorithm
  String currentOutput = ""; // Holds the step-by-step output

  @override
  void initState() {
    super.initState();
    heap = MinHeap(); // Initialize empty heap
    currentAlgorithm = """
Min-Heap Insertion Algorithm:
1. Insert the value at the end of the heap.
2. "Bubble up" the new value to maintain heap property:
   a. If the new value is less than its parent, swap them.
   b. Repeat until the heap property is restored.

Min-Heap Extraction Algorithm:
1. Remove the root (minimum value).
2. Replace the root with the last element in the heap.
3. "Bubble down" the new root to restore heap property.
""";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heap Tree Visualizer'),
        backgroundColor: const Color.fromARGB(255, 214, 59, 198),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left Panel: Algorithm and Output
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
                                    color: const Color.fromARGB(255, 194, 96, 232),
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
                                    color: const Color.fromARGB(255, 208, 75, 199),
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
                // Right Panel: Heap Tree Visualizer
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Heap Tree Visualizer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 220, 79, 225),
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: Center(
                            child: _buildHeap(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Bottom Panel: Buttons
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _insertValue,
                  child: Text('Insert'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(const Color.fromARGB(255, 187, 52, 187)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _extractMinValue,
                  child: Text('Extract Min'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(const Color.fromARGB(255, 215, 77, 192)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _clearHeap,
                  child: Text('Clear'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(const Color.fromARGB(255, 228, 81, 186)),
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

  // Build heap visualization
  Widget _buildHeap() {
    return heap == null || heap!.size == 0
        ? Text(
            'Heap is empty',
            style: TextStyle(fontSize: 18, color: Colors.red),
          )
        : CustomPaint(
            painter: HeapPainter(heap!),
            size: Size.infinite,
          );
  }

  // Insert value into the heap
  void _insertValue() async {
    int? value = await _showInputDialog(context, 'Insert Value');
    if (value != null) {
      setState(() {
        heap!.insert(value); // Insert value and maintain heap property
        currentOutput = "Inserted $value into the Heap. Heap is balancing...";
      });
    }
  }

  // Extract minimum value from the heap
  void _extractMinValue() {
    setState(() {
      if (heap!.size > 0) {
        int minValue = heap!.extractMin();
        currentOutput = "Extracted minimum value: $minValue";
      } else {
        currentOutput = "Heap is empty.";
      }
    });
  }

  // Clear the heap
  void _clearHeap() {
    setState(() {
      heap = MinHeap(); // Reinitialize heap
      currentOutput = "Heap cleared.";
    });
  }

  // Generalized input dialog
  Future<int?> _showInputDialog(BuildContext context, String title) async {
    final TextEditingController controller = TextEditingController();

    return showDialog<int>(context: context, builder: (context) {
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
    });
  }
}

// Min-Heap data structure and insert logic (with balancing)
class MinHeap {
  List<int> elements = [];

  int get size => elements.length;

  void insert(int value) {
    elements.add(value);
    _bubbleUp(size - 1);
  }

  int extractMin() {
    if (size == 0) throw Exception("Heap is empty");
    int minValue = elements[0];
    elements[0] = elements[size - 1];
    elements.removeLast();
    _bubbleDown(0);
    return minValue;
  }

  void _bubbleUp(int index) {
    while (index > 0) {
      int parentIndex = (index - 1) ~/ 2;
      if (elements[index] >= elements[parentIndex]) break;
      _swap(index, parentIndex);
      index = parentIndex;
    }
  }

  void _bubbleDown(int index) {
    int leftChildIndex = 2 * index + 1;
    int rightChildIndex = 2 * index + 2;
    int smallestIndex = index;

    if (leftChildIndex < size &&
        elements[leftChildIndex] < elements[smallestIndex]) {
      smallestIndex = leftChildIndex;
    }

    if (rightChildIndex < size &&
        elements[rightChildIndex] < elements[smallestIndex]) {
      smallestIndex = rightChildIndex;
    }

    if (smallestIndex != index) {
      _swap(index, smallestIndex);
      _bubbleDown(smallestIndex);
    }
  }

  void _swap(int i, int j) {
    int temp = elements[i];
    elements[i] = elements[j];
    elements[j] = temp;
  }
}

// Painter class for drawing the Min Heap
class HeapPainter extends CustomPainter {
  final MinHeap heap;

  HeapPainter(this.heap);

  @override
  void paint(Canvas canvas, Size size) {
    // Custom heap drawing logic
    if (heap.size > 0) {
      _drawNode(canvas, 0, Offset(size.width / 2, 40), size.width / 4);
    }
  }

  void _drawNode(Canvas canvas, int index, Offset position, double offset) {
    if (index >= heap.size) return;

    Paint paint = Paint()..color = Colors.blue;
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: heap.elements[index].toString(),
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    Offset textOffset = Offset(position.dx - textPainter.width / 2,
        position.dy - textPainter.height / 2);

    canvas.drawCircle(position, 20, paint);
    textPainter.paint(canvas, textOffset);

    // Calculate child indices
    int leftChildIndex = 2 * index + 1;
    int rightChildIndex = 2 * index + 2;

    if (leftChildIndex < heap.size) {
      Offset leftPosition = Offset(position.dx - offset, position.dy + 60);
      canvas.drawLine(position, leftPosition, Paint()..color = Colors.black);
      _drawNode(canvas, leftChildIndex, leftPosition, offset / 2);
    }

    if (rightChildIndex < heap.size) {
      Offset rightPosition = Offset(position.dx + offset, position.dy + 60);
      canvas.drawLine(position, rightPosition, Paint()..color = Colors.black);
      _drawNode(canvas, rightChildIndex, rightPosition, offset / 2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//Test

final List<Question> HeapTreeQuestions= [
  Question(
    questionText: 'What is a heap tree?',
    options: [
      'A complete binary tree where each node is greater than its children',
      'A complete binary tree where each node is smaller than its children',
      'A binary tree where nodes are unsorted',
      'A binary search tree where nodes are sorted'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the main property of a max-heap?',
    options: [
      'The root node contains the minimum value',
      'Each parent node is greater than or equal to its children',
      'Each parent node is less than or equal to its children',
      'It is always a balanced tree'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the main property of a min-heap?',
    options: [
      'The root node contains the maximum value',
      'Each parent node is greater than or equal to its children',
      'Each parent node is less than or equal to its children',
      'It is always a balanced tree'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is a heap tree?',
    options: [
      'A complete binary tree',
      'A sorted binary tree',
      'A tree where each parent node is greater than its children',
      'A tree where each parent node is smaller than its children'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How do you insert an element into a heap?',
    options: [
      'Insert it at the root and then balance the tree',
      'Insert it at the last position and then heapify the tree upwards',
      'Insert it at the last position and heapify downwards',
      'Insert it at any random position'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity of inserting an element into a heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity of extracting the maximum element from a max-heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How is a heap typically implemented in a computer’s memory?',
    options: [
      'As a linked list',
      'As a binary search tree',
      'As an array',
      'As a hash table'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the time complexity of building a heap from an unordered array?',
    options: [
      'O(n log n)',
      'O(n)',
      'O(n^2)',
      'O(log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How do you delete the root of a heap?',
    options: [
      'Replace the root with the last element and heapify downwards',
      'Remove the root and heapify upwards',
      'Replace the root with its largest child and heapify downwards',
      'The root cannot be deleted'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following is NOT true about a heap?',
    options: [
      'It is a complete binary tree',
      'It satisfies the heap property',
      'The height of a heap is log(n)',
      'A heap is always sorted'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'In a max-heap, where is the maximum element stored?',
    options: [
      'In the left subtree',
      'In the right subtree',
      'At the root',
      'At any random node'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is heapify?',
    options: [
      'A process to rearrange elements to maintain the heap property',
      'A process to insert an element into a heap',
      'A process to delete an element from a heap',
      'A process to create a binary search tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity of deleting an element from a heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the minimum number of nodes in a heap of height h?',
    options: [
      '2^h - 1',
      '2h',
      'h',
      '2^(h-1)'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the maximum number of nodes in a heap of height h?',
    options: [
      '2^h - 1',
      '2h',
      'h',
      '2^(h+1) - 1'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the height of a heap with n nodes?',
    options: [
      'O(n)',
      'O(log n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following operations is typically used to maintain the heap property after an insertion?',
    options: [
      'Heapify up',
      'Heapify down',
      'Rotate the tree',
      'Balance the tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following is true about the last element in a heap?',
    options: [
      'It can be at any level of the tree',
      'It is always a leaf node',
      'It can never be a leaf node',
      'It is always at the root'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How do you build a max-heap from an unordered array?',
    options: [
      'Insert elements one by one and heapify upwards',
      'Insert elements one by one and heapify downwards',
      'Build the heap using Floyd’s algorithm',
      'Sort the array and convert it into a heap'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the worst-case time complexity for inserting an element into a heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is NOT a type of heap?',
    options: [
      'Max-heap',
      'Min-heap',
      'Ternary heap',
      'Balanced heap'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is a ternary heap?',
    options: [
      'A heap where each node has at most three children',
      'A heap where each node has at most two children',
      'A heap with three levels',
      'A heap that is not balanced'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following operations is typically used to maintain the heap property after a deletion?',
    options: [
      'Heapify up',
      'Heapify down',
      'Rotate the tree',
      'Balance the tree'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the main application of a heap in computer science?',
    options: [
      'Sorting data using heap sort',
      'Storing elements in sorted order',
      'Balancing a binary search tree',
      'Finding the depth of a binary tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How many children can each node in a binary heap have?',
    options: [
      'At most one child',
      'At most two children',
      'At most three children',
      'At most four children'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity for finding the minimum element in a max-heap?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'In a min-heap, where is the minimum element stored?',
    options: [
      'In the left subtree',
      'In the right subtree',
      'At the root',
      'At any random node'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the difference between a heap and a binary search tree?',
    options: [
      'A heap maintains the heap property, while a binary search tree maintains sorted order',
      'A heap is always balanced, while a binary search tree is not',
      'A heap is not a binary tree, but a binary search tree is',
      'There is no difference'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which algorithm is typically used to sort elements using a heap?',
    options: [
      'Quick sort',
      'Merge sort',
      'Heap sort',
      'Bubble sort'
    ],
    correctAnswerIndex: 2,
  )
];

class HeaptreeQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    return QuizUI(quizQuestions: HeapTreeQuestions); // Use the common UI
  }
}