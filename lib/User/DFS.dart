import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/User/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class DfsNotes extends StatelessWidget {
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
      const url = 'assets/notes/dfs.pdf';  // Relative path to the PDF
      await launch(url);  // This opens the PDF in a new browser tab
    });

    return Scaffold(
      appBar:appBack(context),
      body: Center(
        child: Text('Opening PDF...'),
      ),
    );
  }
}




// Test


final List<Question> DfsQuestions = [
  Question(
    questionText: 'What is Depth-First Search (DFS)?',
    options: [
      'A graph traversal algorithm that explores as far as possible along each branch before backtracking',
      'A graph traversal algorithm that explores all neighbors of a node before moving to the next level',
      'An algorithm that always finds the shortest path',
      'An algorithm that uses a queue data structure'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What data structure is typically used to implement DFS?',
    options: [
      'Queue',
      'Priority Queue',
      'Stack',
      'Array'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'How does DFS explore nodes in a graph?',
    options: [
      'Level-by-level from the starting node',
      'Explores as deep as possible along each branch before backtracking',
      'Randomly chooses nodes to visit',
      'It always selects the shortest path'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the time complexity of DFS on a graph with n vertices and e edges?',
    options: [
      'O(n)',
      'O(n + e)',
      'O(n^2)',
      'O(e^2)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How does DFS behave in the presence of cycles in a graph?',
    options: [
      'It will visit each node multiple times',
      'DFS will loop infinitely unless nodes are marked as visited',
      'It will skip nodes involved in cycles',
      'DFS cannot be applied to graphs with cycles'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How does DFS differ from BFS (Breadth-First Search)?',
    options: [
      'DFS explores neighbors first, while BFS explores depth first',
      'DFS uses a stack, while BFS uses a queue',
      'DFS guarantees the shortest path, while BFS does not',
      'Both DFS and BFS are identical algorithms'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is an application of DFS?',
    options: [
      'Finding the shortest path in an unweighted graph',
      'Detecting cycles in directed graphs',
      'Topological sorting of a directed acyclic graph (DAG)',
      'Solving puzzles like mazes'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the space complexity of DFS?',
    options: [
      'O(1)',
      'O(n)',
      'O(n + e)',
      'O(n^2)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'In DFS, how is a node marked as visited?',
    options: [
      'By removing the node from the graph',
      'By coloring the node',
      'By pushing the node into a stack',
      'By keeping a visited set or array'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What traversal order does DFS provide in a tree?',
    options: [
      'Preorder',
      'Inorder',
      'Level-order',
      'Postorder'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following graph traversal methods guarantees the shortest path in an unweighted graph?',
    options: [
      'DFS',
      'BFS',
      'Both DFS and BFS',
      'Neither DFS nor BFS'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'In DFS, when does backtracking occur?',
    options: [
      'When all neighboring nodes of a node have been visited',
      'When the target node is found',
      'When a cycle is detected',
      'When the algorithm runs out of memory'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'In DFS, what is the role of the stack data structure?',
    options: [
      'To store all the edges in the graph',
      'To track nodes that need to be visited next',
      'To track the shortest path in the graph',
      'To store visited nodes in a level-by-level fashion'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How can DFS be used to detect cycles in a directed graph?',
    options: [
      'By keeping track of the visited nodes and detecting back edges',
      'By checking if a node is visited more than twice',
      'By ensuring all nodes are visited in a topological order',
      'By removing cycles during traversal'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the advantage of DFS over BFS?',
    options: [
      'DFS always finds the shortest path',
      'DFS uses less memory for deeply nested graphs',
      'DFS works better on weighted graphs',
      'DFS is faster than BFS in all cases'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is a back edge in DFS?',
    options: [
      'An edge that connects two nodes in the same tree',
      'An edge that points from a node to one of its ancestors',
      'An edge that connects two nodes in different components',
      'An edge that skips levels in the tree'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How is DFS used to perform topological sorting?',
    options: [
      'By exploring the nodes in breadth-first order',
      'By adding nodes to the stack only after all their neighbors are visited',
      'By visiting each node exactly twice',
      'By arranging nodes in a cycle-free manner'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the worst-case time complexity of DFS in a graph with n vertices and e edges?',
    options: [
      'O(n^2)',
      'O(n + e)',
      'O(n log e)',
      'O(e^2)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which type of graphs can DFS be applied to?',
    options: [
      'Only directed graphs',
      'Only undirected graphs',
      'Both directed and undirected graphs',
      'Only trees'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is a correct application of DFS?',
    options: [
      'Finding the shortest path in a weighted graph',
      'Checking if a graph is bipartite',
      'Solving a maze or puzzle',
      'Finding the connected components of a graph'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What traversal order does DFS follow in an arbitrary graph?',
    options: [
      'Preorder',
      'Level-order',
      'Depth-first order',
      'Postorder'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'In DFS, how can we avoid revisiting nodes?',
    options: [
      'By using a priority queue',
      'By marking nodes as visited',
      'By keeping nodes in a stack',
      'By visiting nodes multiple times'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is an advantage of DFS?',
    options: [
      'It guarantees the shortest path in unweighted graphs',
      'It works efficiently with deep and sparse graphs',
      'It is less memory-intensive than BFS in all cases',
      'It is better suited for finding strongly connected components'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the purpose of the visited array in DFS?',
    options: [
      'To store nodes that need to be revisited',
      'To store all unvisited nodes',
      'To keep track of nodes that have already been processed',
      'To keep track of the shortest paths'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'How does DFS handle graphs with multiple connected components?',
    options: [
      'DFS will traverse all components by itself',
      'DFS needs to be called separately for each component',
      'DFS will ignore components disconnected from the starting node',
      'DFS cannot be used for graphs with multiple components'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What kind of tree is produced when DFS is run on a graph?',
    options: [
      'Spanning Tree',
      'Search Tree',
      'Topological Tree',
      'DFS Tree'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'How is DFS different from a recursive traversal of a binary tree?',
    options: [
      'DFS uses a stack and recursion uses a queue',
      'DFS always processes nodes in order, while recursion does not',
      'DFS is iterative while recursion is not',
      'Both follow the same concept of visiting nodes deeply'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'Which of the following is true for DFS?',
    options: [
      'DFS is guaranteed to be complete in finite graphs',
      'DFS can get stuck in loops in graphs with cycles if not handled properly',
      'DFS requires more memory than BFS in all cases',
      'DFS is suitable for graphs with cycles without any extra handling'
    ],
    correctAnswerIndex: 1,
  ),
];

class DfsQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(DfsQuestions);
    String testId = 'DFS'; // Example test_id, modify as needed
    return QuizUI(quizQuestions:randomQuestions, testId: testId ); // Use the common UI
  }
}


















// class DFSGraphVisualizer extends StatefulWidget {
//   @override
//   _GraphVisualizerState createState() => _GraphVisualizerState();
// }

// class _GraphVisualizerState extends State<DFSGraphVisualizer> {
//   Graph? graph; // Graph object
//   String currentOutput = ""; // Holds the step-by-step output
//   List<int> traversalNodes = []; // Nodes to highlight during DFS

//   @override
//   void initState() {
//     super.initState();
//     graph = Graph(); // Initialize empty graph
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("DFS Graph Visualizer")),
//       body: Column(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 // Left Panel: Output
//                 Expanded(
//                   flex: 1,
//                   child: Container(
//                     color: Colors.grey.shade300,
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Step-by-Step Output',
//                           style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                         Divider(),
//                         Expanded(
//                           child: SingleChildScrollView(
//                             child: Text(
//                               currentOutput,
//                               style: TextStyle(fontSize: 16),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 // Right Panel: Graph Visualizer
//                 Expanded(
//                   flex: 2,
//                   child: Container(
//                     color: Colors.white,
//                     padding: EdgeInsets.all(8.0),
//                     child: Center(
//                       child: _buildGraph(),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Bottom Panel: Buttons
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//             color: Colors.grey.shade100,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: _createGraph,
//                   child: Text('Create Graph'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _performDFS,
//                   child: Text('DFS Traversal'),
//                 ),
//                 ElevatedButton(
//                   onPressed: _clearGraph,
//                   child: Text('Clear'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Build graph visualization
//   Widget _buildGraph() {
//     return graph == null || graph!.nodes.isEmpty
//         ? Text('Graph is empty', style: TextStyle(fontSize: 18, color: Colors.red))
//         : CustomPaint(
//             painter: GraphPainter(graph!, traversalNodes),
//             size: Size.infinite,
//           );
//   }

//   // Create graph
//   void _createGraph() {
//     setState(() {
//       graph!.createGraph(5); // Create a graph with 5 nodes
//       currentOutput = "Graph with 5 nodes created.";
//     });
//   }

//   // Perform DFS Traversal
//   void _performDFS() async {
//     setState(() {
//       currentOutput = "Starting DFS Traversal...";
//       traversalNodes.clear();
//     });
//     List<int> dfsResult = await _performTraversal(graph!.dfsTraversal());
//     setState(() {
//       currentOutput += "\nFinal DFS Result: ${dfsResult.join(', ')}";
//     });
//   }

//   // Perform the DFS traversal and highlight nodes
//   Future<List<int>> _performTraversal(List<int> nodes) async {
//     List<int> result = [];
//     for (int value in nodes) {
//       setState(() {
//         traversalNodes = [value]; // Highlight current node
//         currentOutput = "DFS: Visiting $value";
//       });
//       await Future.delayed(Duration(seconds: 2)); // Delay between highlighting nodes
//       result.add(value); // Add to result
//     }
//     setState(() {
//       traversalNodes.clear(); // Clear highlights after traversal
//     });
//     return result; // Return the result
//   }

//   // Clear the graph
//   void _clearGraph() {
//     setState(() {
//       graph = Graph(); // Reset the graph
//       currentOutput = "Graph has been cleared.";
//       traversalNodes.clear(); // Clear any highlights
//     });
//   }
// }
  






// class Graph {
//   List<Node> nodes = [];

//   // Create a graph with a specified number of nodes and random edges
//   void createGraph(int nodeCount) {
//     nodes = List.generate(nodeCount, (index) => Node(index));
//     _createRandomEdges();
//   }

//   // Randomly create edges between nodes
//   void _createRandomEdges() {
//     Random rand = Random();
//     for (Node node in nodes) {
//       int edgeCount = rand.nextInt(nodes.length);  // Number of edges to create for each node
//       for (int i = 0; i < edgeCount; i++) {
//         Node targetNode = nodes[rand.nextInt(nodes.length)];
//         if (node != targetNode && !node.neighbors.contains(targetNode)) {
//           node.neighbors.add(targetNode);
//         }
//       }
//     }
//   }

//   // DFS Traversal
//   List<int> dfsTraversal() {
//     Set<int> visited = {};
//     List<int> result = [];
//     for (Node node in nodes) {
//       if (!visited.contains(node.value)) {
//         _dfsHelper(node, visited, result);
//       }
//     }
//     return result;
//   }

//   // DFS helper function (recursive)
//   void _dfsHelper(Node node, Set<int> visited, List<int> result) {
//     visited.add(node.value);
//     result.add(node.value);
//     for (Node neighbor in node.neighbors) {
//       if (!visited.contains(neighbor.value)) {
//         _dfsHelper(neighbor, visited, result);
//       }
//     }
//   }
// }





// class Node {
//   int value;
//   List<Node> neighbors = [];

//   Node(this.value);
// }






// class GraphPainter extends CustomPainter {
//   final Graph graph;
//   final List<int> highlightedNodes;

//   GraphPainter(this.graph, this.highlightedNodes);

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.black
//       ..strokeWidth = 2;

//     // Calculate the radius for proper positioning within the container
//     double padding = 100;  // padding from the edges of the container
//     double availableWidth = size.width - padding * 2;
//     double availableHeight = size.height - padding * 2;
//     double radius = min(availableWidth, availableHeight) / 2.5;

//     // Center for node placement
//     double centerX = size.width / 2;
//     double centerY = size.height / 2;

//     // Draw nodes and edges
//     for (int i = 0; i < graph.nodes.length; i++) {
//       double angle = (i * 2 * pi) / graph.nodes.length;  // Angle for node distribution
//       double x = centerX + radius * cos(angle);
//       double y = centerY + radius * sin(angle);

//       // Ensure the node is inside the bounds of the container
//       x = x.clamp(padding, size.width - padding); // Clamp within bounds
//       y = y.clamp(padding, size.height - padding); // Clamp within bounds

//       // Draw the edges (if any)
//       for (Node neighbor in graph.nodes[i].neighbors) {
//         // Draw line from node to its neighbors
//         double neighborX = centerX + radius * cos((graph.nodes.indexOf(neighbor) * 2 * pi) / graph.nodes.length);
//         double neighborY = centerY + radius * sin((graph.nodes.indexOf(neighbor) * 2 * pi) / graph.nodes.length);
//         canvas.drawLine(Offset(x, y), Offset(neighborX, neighborY), paint);  // Draw edge
//       }

//       // Draw the node itself
//       Paint nodePaint = Paint()
//         ..color = highlightedNodes.contains(graph.nodes[i].value) ? Colors.yellow : Colors.blue;
//       canvas.drawCircle(Offset(x, y), 20, nodePaint);

//       TextPainter textPainter = TextPainter(
//         text: TextSpan(
//           text: '${graph.nodes[i].value}',
//           style: TextStyle(color: Colors.white, fontSize: 16),
//         ),
//         textDirection: TextDirection.ltr,
//       );
//       textPainter.layout();
//       textPainter.paint(canvas, Offset(x - 10, y - 10));
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }




class DFSGraphVisualizer extends StatefulWidget {
  @override
  _GraphVisualizerState createState() => _GraphVisualizerState();
}

class _GraphVisualizerState extends State<DFSGraphVisualizer> {
  Graph? graph; // Graph object
  String currentOutput = ""; // Holds the step-by-step output
  List<int> traversalNodes = []; // Nodes to highlight during DFS

  @override
  void initState() {
    super.initState();
    graph = Graph(); // Initialize empty graph
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("DFS Graph Visualizer"), backgroundColor: Colors.purple),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left Panel: Algorithm and Output
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'DFS Algorithm:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
                        ),
                        Divider(),
                        Text(
                          '''1. Start from a node and mark it as visited.
2. Explore each unvisited neighbor recursively.
3. After visiting all neighbors, backtrack to previous node.
4. Repeat until all nodes are visited.''',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Step-by-Step Output',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
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
                SizedBox(width: 10),
                // Right Panel: Graph Visualizer
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: _buildGraph(),
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
                  onPressed: _createGraph,
                  child: Text('Create Graph'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _performDFS,
                  child: Text('DFS Traversal'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _clearGraph,
                  child: Text('Clear'),
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
    );
  }

  // Build graph visualization
  Widget _buildGraph() {
    return graph == null || graph!.nodes.isEmpty
        ? Text('Graph is empty', style: TextStyle(fontSize: 18, color: Colors.red))
        : CustomPaint(
            painter: GraphPainter(graph!, traversalNodes),
            size: Size.infinite,
          );
  }

  // Create graph
  void _createGraph() {
    setState(() {
      graph!.createGraph(5); // Create a graph with 5 nodes
      currentOutput = "Graph with 5 nodes created.";
    });
  }

  // Perform DFS Traversal
  void _performDFS() async {
    setState(() {
      currentOutput = "Starting DFS Traversal...";
      traversalNodes.clear();
    });
    List<int> dfsResult = await _performTraversal(graph!.dfsTraversal());
    setState(() {
      currentOutput += "\nFinal DFS Result: ${dfsResult.join(', ')}";
    });
  }

  // Perform the DFS traversal and highlight nodes
  Future<List<int>> _performTraversal(List<int> nodes) async {
    List<int> result = [];
    for (int value in nodes) {
      setState(() {
        traversalNodes = [value]; // Highlight current node
        currentOutput = "DFS: Visiting $value";
      });
      await Future.delayed(Duration(seconds: 2)); // Delay between highlighting nodes
      result.add(value); // Add to result
    }
    setState(() {
      traversalNodes.clear(); // Clear highlights after traversal
    });
    return result; // Return the result
  }

  // Clear the graph
  void _clearGraph() {
    setState(() {
      graph = Graph(); // Reset the graph
      currentOutput = "Graph has been cleared.";
      traversalNodes.clear(); // Clear any highlights
    });
  }
}

class Graph {
  List<Node> nodes = [];

  // Create a graph with a specified number of nodes and random edges
  void createGraph(int nodeCount) {
    nodes = List.generate(nodeCount, (index) => Node(index));
    _createRandomEdges();
  }

  // Randomly create edges between nodes
  void _createRandomEdges() {
    Random rand = Random();
    for (Node node in nodes) {
      int edgeCount = rand.nextInt(nodes.length);  // Number of edges to create for each node
      for (int i = 0; i < edgeCount; i++) {
        Node targetNode = nodes[rand.nextInt(nodes.length)];
        if (node != targetNode && !node.neighbors.contains(targetNode)) {
          node.neighbors.add(targetNode);
        }
      }
    }
  }

  // DFS Traversal
  List<int> dfsTraversal() {
    Set<int> visited = {};
    List<int> result = [];
    for (Node node in nodes) {
      if (!visited.contains(node.value)) {
        _dfsHelper(node, visited, result);
      }
    }
    return result;
  }

  // DFS helper function (recursive)
  void _dfsHelper(Node node, Set<int> visited, List<int> result) {
    visited.add(node.value);
    result.add(node.value);
    for (Node neighbor in node.neighbors) {
      if (!visited.contains(neighbor.value)) {
        _dfsHelper(neighbor, visited, result);
      }
    }
  }
}

class Node {
  int value;
  List<Node> neighbors = [];

  Node(this.value);
}

class GraphPainter extends CustomPainter {
  final Graph graph;
  final List<int> highlightedNodes;

  GraphPainter(this.graph, this.highlightedNodes);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    // Calculate the radius for proper positioning within the container
    double padding = 100;  // padding from the edges of the container
    double availableWidth = size.width - padding * 2;
    double availableHeight = size.height - padding * 2;
    double radius = min(availableWidth, availableHeight) / 2.5;

    // Center for node placement
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    // Draw nodes and edges
    for (int i = 0; i < graph.nodes.length; i++) {
      double angle = (i * 2 * pi) / graph.nodes.length;  // Angle for node distribution
      double x = centerX + radius * cos(angle);
      double y = centerY + radius * sin(angle);

      // Ensure the node is inside the bounds of the container
      x = x.clamp(padding, size.width - padding); // Clamp within bounds
      y = y.clamp(padding, size.height - padding); // Clamp within bounds

      // Draw the edges (if any)
      for (Node neighbor in graph.nodes[i].neighbors) {
        // Draw line from node to its neighbors
        double neighborX = centerX + radius * cos((graph.nodes.indexOf(neighbor) * 2 * pi) / graph.nodes.length);
        double neighborY = centerY + radius * sin((graph.nodes.indexOf(neighbor) * 2 * pi) / graph.nodes.length);
        canvas.drawLine(Offset(x, y), Offset(neighborX, neighborY), paint);  // Draw edge
      }

      // Draw the node itself
      Paint nodePaint = Paint()
        ..color = highlightedNodes.contains(graph.nodes[i].value) ? Colors.yellow : Colors.purple; // Purple node
      canvas.drawCircle(Offset(x, y), 20, nodePaint);

      TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: '${graph.nodes[i].value}',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(x - 10, y - 10));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

