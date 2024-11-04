import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class BSTNotes extends StatelessWidget {
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
      const url = 'assets/notes/BST.pdf';  // Relative path to the PDF
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


void main() => runApp(BSTVisualizer());

class BSTVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary Search Tree Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: BSTScreen(),
    );
  }
}

class BSTScreen extends StatefulWidget {
  @override
  _BSTScreenState createState() => _BSTScreenState();
}

class _BSTScreenState extends State<BSTScreen> {
  BSTree? tree; // BST object
  String currentAlgorithm = ""; // Holds the current algorithm
  String currentOutput = ""; // Holds the step-by-step output
  List<int> traversalNodes = []; // Nodes to highlight during traversal

  @override
  void initState() {
    super.initState();
    tree = BSTree(); // Initialize empty tree
    currentAlgorithm = """
Binary Search Tree Operations:
1. Insertion: Insert a value in the correct position.
2. Deletion: Remove a value and re-structure the tree.
3. Search: Find if a value exists in the tree.
4. Traversal: Visit all nodes in various orders (Inorder, Preorder, Postorder).
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
                  // Right Panel: BST Visualizer
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            'Binary Search Tree Visualizer',
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
                    onPressed: _removeValue,
                    child: Text('Remove'),
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
                    onPressed: _traverseTree,
                    child: Text('Traverse'),
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
            painter: TreePainter(tree!.root!, traversalNodes),
            size: Size.infinite,
          );
  }

  // Insert value into BST
  void _insertValue() async {
    int? value = await _showInputDialog(context, 'Insert Value');
    if (value != null) {
      setState(() {
        tree!.insert(value); // Insert value
        currentOutput = "Inserted $value into the Binary Search Tree.";
      });
    }
  }

  // Remove value from BST
  void _removeValue() async {
    int? value = await _showInputDialog(context, 'Remove Value');
    if (value != null) {
      setState(() {
        if (tree!.remove(value)) {
          currentOutput = "Removed $value from the Binary Search Tree.";
        } else {
          currentOutput = "$value not found in the tree.";
        }
      });
    }
  }

  // Search for a value in BST
  void _searchValue() async {
    int? value = await _showInputDialog(context, 'Search Value');
    if (value != null) {
      setState(() {
        if (tree!.search(value)) {
          currentOutput = "$value found in the Binary Search Tree.";
        } else {
          currentOutput = "$value not found in the tree.";
        }
      });
    }
  }

  // Traverse the tree and display the result
  void _traverseTree() async {
    // Inorder Traversal
    setState(() {
      currentOutput = "Starting Inorder Traversal...";
      traversalNodes.clear();
    });
    List<int> inOrderResult = await _performTraversal(tree!.inOrderTraversal(), "Inorder Traversal");
    setState(() {
      currentOutput += "\nFinal Inorder Result: ${inOrderResult.join(', ')}";
    });
    await Future.delayed(Duration(seconds: 3)); // 3 seconds delay before next traversal

    // Postorder Traversal
    setState(() {
      currentOutput += "\n\nStarting Postorder Traversal...";
      traversalNodes.clear();
    });
    List<int> postOrderResult = await _performTraversal(tree!.postOrderTraversal(), "Postorder Traversal");
    setState(() {
      currentOutput += "\nFinal Postorder Result: ${postOrderResult.join(', ')}";
    });
    await Future.delayed(Duration(seconds: 3)); // 3 seconds delay before next traversal

    // Preorder Traversal
    setState(() {
      currentOutput += "\n\nStarting Preorder Traversal...";
      traversalNodes.clear();
    });
    List<int> preOrderResult = await _performTraversal(tree!.preOrderTraversal(), "Preorder Traversal");
    setState(() {
      currentOutput += "\nFinal Preorder Result: ${preOrderResult.join(', ')}";
    });
  }

  // Perform the specific traversal and highlight nodes
  Future<List<int>> _performTraversal(List<int> nodes, String traversalType) async {
    List<int> result = [];
    for (int value in nodes) {
      setState(() {
        traversalNodes = [value]; // Highlight current node
        currentOutput = "$traversalType: Visiting $value";
      });
      await Future.delayed(Duration(seconds: 2)); // Delay between highlighting nodes
      result.add(value); // Add to result
    }
    setState(() {
      traversalNodes.clear(); // Clear highlights after traversal
    });
    return result; // Return the result
  }

  // Clear the tree
  void _clearTree() {
    setState(() {
      tree = BSTree(); // Reset the tree
      currentOutput = "Tree has been cleared.";
      traversalNodes.clear(); // Clear any highlights
    });
  }

  // Show input dialog for value entry
  Future<int?> _showInputDialog(BuildContext context, String title) {
    TextEditingController controller = TextEditingController();
    return showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "Enter a value"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                int? value = int.tryParse(controller.text);
                Navigator.of(context).pop(value); // Return the value
              },
              child: Text('OK'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

// Binary Search Tree Class
class BSTree {
  Node? root;

  void insert(int value) {
    root = _insertRecursive(root, value);
  }

  Node _insertRecursive(Node? node, int value) {
    if (node == null) {
      return Node(value);
    }
    if (value < node.value) {
      node.left = _insertRecursive(node.left, value);
    } else {
      node.right = _insertRecursive(node.right, value);
    }
    return node;
  }

  bool remove(int value) {
    int initialSize = _getSize(root);
    root = _removeRecursive(root, value);
    return _getSize(root) < initialSize;
  }

  Node? _removeRecursive(Node? node, int value) {
    if (node == null) return null;
    if (value < node.value) {
      node.left = _removeRecursive(node.left, value);
    } else if (value > node.value) {
      node.right = _removeRecursive(node.right, value);
    } else {
      // Node to be removed found
      if (node.left == null) return node.right;
      if (node.right == null) return node.left;
      node.value = _findMin(node.right!).value; // Replace with min from right subtree
      node.right = _removeRecursive(node.right, node.value);
    }
    return node;
  }

  bool search(int value) {
    return _searchRecursive(root, value);
  }

  bool _searchRecursive(Node? node, int value) {
    if (node == null) return false;
    if (node.value == value) return true;
    return value < node.value
        ? _searchRecursive(node.left, value)
        : _searchRecursive(node.right, value);
  }

  List<int> inOrderTraversal() {
    List<int> result = [];
    _inOrderTraversal(root, result);
    return result;
  }

  void _inOrderTraversal(Node? node, List<int> result) {
    if (node != null) {
      _inOrderTraversal(node.left, result);
      result.add(node.value);
      _inOrderTraversal(node.right, result);
    }
  }

  List<int> postOrderTraversal() {
    List<int> result = [];
    _postOrderTraversal(root, result);
    return result;
  }

  void _postOrderTraversal(Node? node, List<int> result) {
    if (node != null) {
      _postOrderTraversal(node.left, result);
      _postOrderTraversal(node.right, result);
      result.add(node.value);
    }
  }

  List<int> preOrderTraversal() {
    List<int> result = [];
    _preOrderTraversal(root, result);
    return result;
  }

  void _preOrderTraversal(Node? node, List<int> result) {
    if (node != null) {
      result.add(node.value);
      _preOrderTraversal(node.left, result);
      _preOrderTraversal(node.right, result);
    }
  }

  int _getSize(Node? node) {
    if (node == null) return 0;
    return 1 + _getSize(node.left) + _getSize(node.right);
  }

  Node _findMin(Node node) {
    while (node.left != null) {
      node = node.left!;
    }
    return node;
  }
}

// Node class
class Node {
  int value;
  Node? left;
  Node? right;

  Node(this.value);
}

// TreePainter class for drawing the BST
class TreePainter extends CustomPainter {
  final Node root;
  final List<int> highlightedNodes;

  TreePainter(this.root, this.highlightedNodes);

  @override
  void paint(Canvas canvas, Size size) {
    if (root == null) return;

    double centerX = size.width / 2;
    double offsetY = 40;
    _drawNode(canvas, root, centerX, offsetY, size.width / 4);
  }

  void _drawNode(Canvas canvas, Node node, double x, double y, double offsetX) {
    Paint paint = Paint()
      ..color = highlightedNodes.contains(node.value)
          ? Colors.yellow // Highlighted color
          : Colors.blue; // Normal color

    // Draw the node
    canvas.drawCircle(Offset(x, y), 20, paint);
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${node.value}',
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - 10, y - 10));

    // Draw left and right children
    if (node.left != null) {
      canvas.drawLine(Offset(x, y + 20), Offset(x - offsetX, y + 60), Paint()..color = Colors.black);
      _drawNode(canvas, node.left!, x - offsetX, y + 60, offsetX / 2);
    }
    if (node.right != null) {
      canvas.drawLine(Offset(x, y + 20), Offset(x + offsetX, y + 60), Paint()..color = Colors.black);
      _drawNode(canvas, node.right!, x + offsetX, y + 60, offsetX / 2);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}



//Test


final List<Question> BSTQuestions= [
  Question(
    questionText: 'What is a binary search tree?',
    options: [
      'A binary tree where the left child is greater than the parent node',
      'A binary tree where the left child is less than the parent node',
      'A binary tree where all nodes have two children',
      'A binary tree that is not sorted'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which property must a binary search tree satisfy?',
    options: [
      'The left subtree must be a binary search tree, and the right subtree must be a binary search tree',
      'The height of left and right subtrees must be equal',
      'All nodes must have exactly two children',
      'The tree must be a complete binary tree'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity of searching for an element in a balanced binary search tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How do you insert an element into a binary search tree?',
    options: [
      'Insert it as a left child if it is smaller than the root, or as a right child if it is larger',
      'Always insert at the root',
      'Insert it at any available position',
      'Insert it as the last child'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity for deleting an element from a balanced binary search tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What traversal method results in sorted order for a binary search tree?',
    options: [
      'Pre-order',
      'In-order',
      'Post-order',
      'Level-order'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the height of a binary search tree with only one node?',
    options: [
      '0',
      '1',
      '2',
      'It depends on the tree structure'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following operations requires O(n) time complexity in the worst case for a binary search tree?',
    options: [
      'Insertion',
      'Searching',
      'Deletion',
      'All of the above'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What happens when you delete a node with two children in a binary search tree?',
    options: [
      'You replace it with the largest node in its left subtree',
      'You replace it with the smallest node in its right subtree',
      'You simply remove it',
      'You cannot delete it'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is a balanced binary search tree?',
    options: [
      'AVL tree',
      'Red-Black tree',
      'Both AVL tree and Red-Black tree',
      'None of the above'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the worst-case height of an unbalanced binary search tree?',
    options: [
      'O(log n)',
      'O(n)',
      'O(n log n)',
      'O(1)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which traversal method visits the nodes in the order of root, left, right for a binary search tree?',
    options: [
      'In-order',
      'Pre-order',
      'Post-order',
      'Level-order'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the successor of a node in a binary search tree?',
    options: [
      'The largest node in the left subtree',
      'The smallest node in the right subtree',
      'The parent node',
      'The node with the maximum value'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How do you find the minimum value in a binary search tree?',
    options: [
      'By traversing to the rightmost node',
      'By traversing to the leftmost node',
      'By checking the root node only',
      'By traversing all nodes'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity for searching an element in a skewed binary search tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the difference between a binary tree and a binary search tree?',
    options: [
      'A binary search tree is a binary tree that maintains a specific order',
      'A binary tree can have multiple children',
      'A binary tree does not allow duplicate values',
      'A binary search tree can have any structure'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How do you find the predecessor of a node in a binary search tree?',
    options: [
      'The largest node in the right subtree',
      'The smallest node in the left subtree',
      'The parent node',
      'The node with the minimum value'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the key operation of a binary search tree?',
    options: [
      'Insertion',
      'Deletion',
      'Searching',
      'All of the above'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the time complexity for finding the height of a binary search tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following scenarios is NOT suitable for a binary search tree?',
    options: [
      'Dynamic data insertion and deletion',
      'Searching for an element',
      'Maintaining a sorted list of elements',
      'Searching for the median of a dataset'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the time complexity for building a binary search tree from a sorted array?',
    options: [
      'O(n log n)',
      'O(n)',
      'O(n^2)',
      'O(log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is a self-balancing binary search tree?',
    options: [
      'A binary search tree that maintains its balance during insertion and deletion',
      'A binary search tree where the height is always kept at a minimum',
      'A binary search tree that allows duplicate values',
      'A binary search tree that is always complete'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity for checking if a binary search tree is balanced?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the average time complexity of searching for an element in a balanced binary search tree?',
    options: [
      'O(1)',
      'O(log n)',
      'O(n)',
      'O(n log n)'
    ],
    correctAnswerIndex: 1,
  ),
];

class BSTQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
  List<Question> randomQuestions = getRandomQuestions(BSTQuestions);
  String testId = '17_bst'; // Example test_id, modify as needed
    return QuizUI(quizQuestions: randomQuestions, testId: testId); // Use the common UI
  }
}