import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';



class AVLNotes extends StatelessWidget {
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
      const url = 'assets/notes/avl_tree.pdf';  // Relative path to the PDF
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

//void main() => runApp(AVLTreeVisualizer());

class AVLTreeVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AVL Tree Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Set theme to purple
      ),
      home: AVLTreeScreen(),
    );
  }
}

class AVLTreeScreen extends StatefulWidget {
  @override
  _AVLTreeScreenState createState() => _AVLTreeScreenState();
}

class _AVLTreeScreenState extends State<AVLTreeScreen> {
  AVLTree? tree; // AVL Tree object
  String currentAlgorithm = ""; // Holds the current algorithm
  String currentOutput = ""; // Holds the step-by-step output
  String rotationMessage = ""; // Message to show the rotation type

  @override
  void initState() {
    super.initState();
    tree = AVLTree(); // Initialize empty tree
    currentAlgorithm = """
AVL Tree Insertion Algorithm:
1. Insert the value in the correct position (BST property).
2. Update the heights of the nodes.
3. Check the balance factor (difference between left and right subtree heights).
4. If balance factor is -2 or +2, rotate:
   a. Left-Left case: Perform Right Rotation.
   b. Right-Right case: Perform Left Rotation.
   c. Left-Right case: Perform Left Rotation, then Right Rotation.
   d. Right-Left case: Perform Right Rotation, then Left Rotation.
""";
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
                                      color: Colors.purple,
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
                                      color: Colors.purple,
                                    ),
                                  ),
                                  Divider(),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Text(
                                        currentOutput + rotationMessage,
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
                  // Right Panel: AVL Tree Visualizer
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'AVL Tree Visualizer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple,
                            ),
                          ),
                          Divider(),
                          Expanded(
                            child: Center(
                              child: _buildTree(),
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
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _leftBalance,
                    child: Text('Left Balance'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _rightBalance,
                    child: Text('Right Balance'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _searchValue,
                    child: Text('Search'),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.purple),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _clearTree,
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

  // Build tree visualization
  Widget _buildTree() {
    return tree == null || tree!.root == null
        ? Text(
            'Tree is empty',
            style: TextStyle(fontSize: 18, color: Colors.red),
          )
        : CustomPaint(
            painter: TreePainter(tree!.root!, tree!.highlightNode),
            size: Size.infinite,
          );
  }

  // Insert value into AVL Tree
  void _insertValue() async {
    int? value = await _showInputDialog(context, 'Insert Value');
    if (value != null) {
      setState(() {
        rotationMessage = ""; // Reset rotation message
        tree!.insert(value); // Insert value and balance the tree
        currentOutput = "Inserted $value into the AVL Tree.";
        rotationMessage = tree!.rotationMessage; // Get the rotation message
      });
    }
  }

  // Manual Left Balancing (Right Rotation)
  void _leftBalance() {
    setState(() {
      tree!.root = tree!._rightRotate(tree!.root!);
      currentOutput = "Performed manual Left Balancing (Right Rotation).";
    });
  }

  // Manual Right Balancing (Left Rotation)
  void _rightBalance() {
    setState(() {
      tree!.root = tree!._leftRotate(tree!.root!);
      currentOutput = "Performed manual Right Balancing (Left Rotation).";
    });
  }

  // Search for a value in the AVL Tree
  void _searchValue() async {
    int? value = await _showInputDialog(context, 'Search Value');
    if (value != null) {
      setState(() {
        bool found = tree!.search(value); // Search value in the tree
        if (found) {
          currentOutput = "Value $value found in the AVL Tree.";
        } else {
          currentOutput = "Value $value not found in the AVL Tree.";
        }
      });
    }
  }

  // Clear the AVL tree
  void _clearTree() {
    setState(() {
      tree = AVLTree(); // Reinitialize tree
      currentOutput = "Tree cleared.";
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
              int? value = int.tryParse(controller.text);
              Navigator.of(context).pop(value); // Return value
            },
            child: Text('OK'),
          ),
        ],
      );
    });
  }
}

// AVL Node class
class AVLNode {
  int value;
  AVLNode? left;
  AVLNode? right;
  int height;

  AVLNode(this.value) : height = 1;
}

// AVL Tree class
class AVLTree {
  AVLNode? root; // Root of the AVL tree
  AVLNode? highlightNode; // Node to highlight
  String rotationMessage = ""; // Message to show rotation info

  // Insert value into AVL Tree
  void insert(int value) {
    root = _insertNode(root, value);
  }

  // Search for a value in AVL Tree
  bool search(int value) {
    AVLNode? result = _searchNode(root, value);
    if (result != null) {
      highlightNode = result; // Highlight found node
      return true;
    }
    return false;
  }

  // Recursive search
  AVLNode? _searchNode(AVLNode? node, int value) {
    if (node == null) return null;
    if (value == node.value) return node;
    if (value < node.value) return _searchNode(node.left, value);
    return _searchNode(node.right, value);
  }

  // Insert node recursively and balance AVL Tree
  AVLNode _insertNode(AVLNode? node, int value) {
    if (node == null) return AVLNode(value); // New node

    if (value < node.value) {
      node.left = _insertNode(node.left, value);
    } else if (value > node.value) {
      node.right = _insertNode(node.right, value);
    } else {
      return node; // No duplicates allowed
    }

    // Update height
    node.height = 1 + _max(_getHeight(node.left), _getHeight(node.right));

    // Balance tree
    int balance = _getBalance(node);
    rotationMessage = ""; // Reset rotation message

    if (balance > 1 && value < node.left!.value) {
      rotationMessage = "Left-Left case: Performing Right Rotation.";
      return _rightRotate(node);
    }

    if (balance < -1 && value > node.right!.value) {
      rotationMessage = "Right-Right case: Performing Left Rotation.";
      return _leftRotate(node);
    }

    if (balance > 1 && value > node.left!.value) {
      rotationMessage = "Left-Right case: Performing Left Rotation, then Right Rotation.";
      node.left = _leftRotate(node.left!);
      return _rightRotate(node);
    }

    if (balance < -1 && value < node.right!.value) {
      rotationMessage = "Right-Left case: Performing Right Rotation, then Left Rotation.";
      node.right = _rightRotate(node.right!);
      return _leftRotate(node);
    }

    return node; // Return unchanged node
  }

  // Get height of node
  int _getHeight(AVLNode? node) {
    return node?.height ?? 0; // Return 0 if node is null
  }

  // Get balance factor of node
  int _getBalance(AVLNode? node) {
    return node == null ? 0 : _getHeight(node.left) - _getHeight(node.right);
  }

  // Right Rotation
  AVLNode _rightRotate(AVLNode y) {
    AVLNode x = y.left!;
    AVLNode T2 = x.right!;

    x.right = y; // Perform rotation
    y.left = T2; // Update left subtree

    // Update heights
    y.height = _max(_getHeight(y.left), _getHeight(y.right)) + 1;
    x.height = _max(_getHeight(x.left), _getHeight(x.right)) + 1;

    return x; // Return new root
  }

  // Left Rotation
  AVLNode _leftRotate(AVLNode x) {
    AVLNode y = x.right!;
    AVLNode T2 = y.left!;

    y.left = x; // Perform rotation
    x.right = T2; // Update right subtree

    // Update heights
    x.height = _max(_getHeight(x.left), _getHeight(x.right)) + 1;
    y.height = _max(_getHeight(y.left), _getHeight(y.right)) + 1;

    return y; // Return new root
  }

  // Return max of two values
  int _max(int a, int b) => (a > b) ? a : b;
}

// Painter class for drawing the AVL tree with purple theme and rotation highlighting
class TreePainter extends CustomPainter {
  final AVLNode root;
  final AVLNode? highlightNode; // Node involved in rotation or search

  TreePainter(this.root, this.highlightNode);

  @override
  void paint(Canvas canvas, Size size) {
    _drawNode(canvas, root, Offset(size.width / 2, 40), size.width / 4);
  }

  // Draw node recursively
  void _drawNode(Canvas canvas, AVLNode node, Offset position, double offset) {
    Paint paint = Paint()
      ..color = (node == highlightNode) ? Colors.red : Colors.purple; // Highlight for search
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: node.value.toString(),
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    Offset textOffset = Offset(position.dx - textPainter.width / 2,
        position.dy - textPainter.height / 2);

    canvas.drawCircle(position, 20, paint);
    textPainter.paint(canvas, textOffset);

    // Draw left child
    if (node.left != null) {
      Offset leftPosition = Offset(position.dx - offset, position.dy + 60);
      canvas.drawLine(position, leftPosition, Paint()..color = Colors.black);
      _drawNode(canvas, node.left!, leftPosition, offset / 2);
    }

    // Draw right child
    if (node.right != null) {
      Offset rightPosition = Offset(position.dx + offset, position.dy + 60);
      canvas.drawLine(position, rightPosition, Paint()..color = Colors.black);
      _drawNode(canvas, node.right!, rightPosition, offset / 2);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//Test

// List of AVL Tree Questions
final List<Question> avlTreeQuestions = [
 Question(
    questionText: 'What is an AVL tree?',
    options: [
      'A binary tree where each node has at most two children',
      'A binary search tree where the height of two subtrees of any node differ by at most one',
      'A binary search tree where the root is always balanced',
      'A tree where the nodes are sorted in ascending order'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Who invented the AVL tree?',
    options: [
      'Donald Knuth',
      'Robert Tarjan',
      'Georgy Adelson-Velsky and Evgenii Landis',
      'Charles Babbage'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the balance factor in an AVL tree?',
    options: [
      'The difference between the depths of the left and right subtrees',
      'The sum of the depths of the left and right subtrees',
      'The number of nodes in the left and right subtrees',
      'The ratio of the left and right subtree heights'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the allowed range for the balance factor in an AVL tree?',
    options: [
      '-2 to +2',
      '-1 to +1',
      '-3 to +3',
      '0 to +1'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity of searching for an element in an AVL tree?',
    options: [
      'O(n)',
      'O(log n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the height of an AVL tree with n nodes?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How does an AVL tree maintain balance?',
    options: [
      'By performing rotations on nodes',
      'By swapping nodes',
      'By rearranging all nodes after every insertion or deletion',
      'By storing extra information in each node'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is a single rotation in an AVL tree?',
    options: [
      'A process to swap the root node',
      'A technique to fix the balance factor by rotating a subtree once',
      'A process to delete a node from the tree',
      'A technique to reorder the tree without changing its shape'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is a double rotation in an AVL tree?',
    options: [
      'A combination of two single rotations to balance the tree',
      'A rotation that swaps two nodes twice',
      'A process that involves balancing two subtrees independently',
      'A method of rotating two different levels of the tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'When does a right rotation occur in an AVL tree?',
    options: [
      'When the left subtree is too tall',
      'When the right subtree is too tall',
      'When the tree becomes unbalanced after an insertion in the right subtree',
      'When the tree is perfectly balanced'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'When does a left rotation occur in an AVL tree?',
    options: [
      'When the right subtree is too tall',
      'When the left subtree is too tall',
      'When the tree becomes unbalanced after an insertion in the left subtree',
      'When the tree is perfectly balanced'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following rotations is performed when the balance factor is +2 and the imbalance is in the right subtree?',
    options: [
      'Right rotation',
      'Left rotation',
      'Left-right rotation',
      'Right-left rotation'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which rotation is performed when the balance factor is -2 and the imbalance is in the left subtree?',
    options: [
      'Right rotation',
      'Left rotation',
      'Left-right rotation',
      'Right-left rotation'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which rotation is performed when a node in the left subtree of a right subtree causes imbalance?',
    options: [
      'Left rotation',
      'Right rotation',
      'Left-right rotation',
      'Right-left rotation'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the time complexity for inserting an element into an AVL tree?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity for deleting an element from an AVL tree?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the worst-case time complexity of searching in an AVL tree?',
    options: [
      'O(1)',
      'O(n)',
      'O(log n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following statements is true about AVL trees?',
    options: [
      'Every AVL tree is a binary search tree',
      'Every binary search tree is an AVL tree',
      'AVL trees cannot have duplicate keys',
      'AVL trees have a balance factor greater than 2'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How do you check if a binary search tree is also an AVL tree?',
    options: [
      'Check if it is balanced and all nodes satisfy the AVL property',
      'Check if all left subtrees have larger values than the root',
      'Check if all right subtrees have smaller values than the root',
      'Check if all nodes are arranged in a complete binary tree structure'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following operations can cause an imbalance in an AVL tree?',
    options: [
      'Inserting an element',
      'Deleting an element',
      'Both inserting and deleting elements',
      'Rebalancing the tree'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which rotation fixes an imbalance caused by a right subtree of a left subtree?',
    options: [
      'Left rotation',
      'Right rotation',
      'Left-right rotation',
      'Right-left rotation'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the height of an AVL tree with one node?',
    options: [
      '1',
      '0',
      '2',
      '-1'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the height of an empty AVL tree?',
    options: [
      '1',
      '0',
      '-1',
      '2'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is NOT a property of an AVL tree?',
    options: [
      'It is a binary search tree',
      'It is a balanced tree',
      'It has a balance factor of -2 or +2',
      'It allows O(log n) search, insert, and delete operations'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is true about AVL trees?',
    options: [
      'They require constant rebalancing',
      'They guarantee a balance factor between -1 and +1',
      'They do not allow duplicate elements',
      'They have O(n^2) worst-case time complexity'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is the primary benefit of using an AVL tree?',
    options: [
      'It is always perfectly balanced',
      'It guarantees O(log n) operations for search, insert, and delete',
      'It is faster than other balanced binary trees',
      'It requires no extra space for balancing'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity for balancing an AVL tree after an insertion?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How many types of rotations are there in an AVL tree?',
    options: [
      'Two: left and right rotations',
      'Three: left, right, and double rotations',
      'Four: left, right, left-right, and right-left rotations',
      'Five: left, right, and three types of double rotations'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following sequences of insertions causes a left-right rotation?',
    options: [
      'Inserting 10, then 20, then 30',
      'Inserting 30, then 20, then 10',
      'Inserting 30, then 10, then 20',
      'Inserting 10, then 30, then 20'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What kind of tree is an AVL tree, aside from being balanced?',
    options: [
      'A complete binary tree',
      'A full binary tree',
      'A binary search tree',
      'A threaded binary tree'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following trees will not require rebalancing in an AVL tree after insertion?',
    options: [
      'A tree with balance factors of -1 or 0',
      'A tree with balance factors of +1 and +2',
      'A tree with balance factors of -2 and 0',
      'A tree with balance factors of +2 or -2'
    ],
    correctAnswerIndex: 0,
  ),
];

// Create a widget for the AVL Tree Quiz
class AvlTreeQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    return QuizUI(quizQuestions: avlTreeQuestions); // Use the common UI
  }
}


// Question model
