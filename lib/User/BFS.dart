import 'dart:collection';
import 'dart:math';

import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class BfsNotes extends StatelessWidget {
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
      const url = 'assets/notes/bfs.pdf';  // Relative path to the PDF
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

final List<Question> BfsQuestions = [
 Question(
    questionText: 'What is Breadth-First Search (BFS)?',
    options: [
      'A search algorithm that explores as far as possible along each branch before backtracking',
      'A search algorithm that explores all neighbors of a node before moving to the next level',
      'A search algorithm that always chooses the shortest path',
      'A search algorithm that uses a stack data structure'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What data structure is used to implement BFS?',
    options: [
      'Stack',
      'Queue',
      'Priority Queue',
      'Linked List'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'In BFS, how are the nodes visited?',
    options: [
      'Depth-first, then breadth-wise',
      'By random selection of nodes',
      'Level by level from the starting node',
      'All nodes are visited simultaneously'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the time complexity of BFS on a graph with n vertices and e edges?',
    options: [
      'O(n)',
      'O(e)',
      'O(n + e)',
      'O(n * e)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'In BFS, what happens if a graph has cycles?',
    options: [
      'The algorithm may go into an infinite loop unless nodes are marked as visited',
      'The algorithm will always terminate correctly without visiting nodes more than once',
      'The algorithm will skip over cycles',
      'BFS cannot handle graphs with cycles'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How does BFS differ from DFS (Depth-First Search)?',
    options: [
      'BFS uses a stack, while DFS uses a queue',
      'BFS explores neighbors first, while DFS explores farthest nodes first',
      'BFS guarantees the shortest path, while DFS does not',
      'Both BFS and DFS use the same approach for exploring nodes'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is NOT an application of BFS?',
    options: [
      'Finding the shortest path in an unweighted graph',
      'Solving puzzles like mazes',
      'Detecting cycles in an undirected graph',
      'Finding strongly connected components in a directed graph'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the space complexity of BFS?',
    options: [
      'O(1)',
      'O(n)',
      'O(n + e)',
      'O(n^2)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'How is BFS initialized?',
    options: [
      'By adding the first node to the stack',
      'By marking all nodes as visited',
      'By adding the first node to the queue and marking it as visited',
      'By setting all distances to infinity'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the shortest path from the source node to other nodes in an unweighted graph using BFS?',
    options: [
      'It is always the path with the fewest edges',
      'It is the path with the smallest sum of edge weights',
      'It is the path with the highest number of edges',
      'BFS cannot find the shortest path'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'In BFS, how do you ensure that a node is not visited more than once?',
    options: [
      'By adding nodes to a stack',
      'By keeping a visited array or set',
      'By backtracking and rechecking nodes',
      'By removing nodes from the queue once they are visited'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following statements is true about BFS?',
    options: [
      'It is not suitable for disconnected graphs',
      'It works only for trees and cannot handle general graphs',
      'It visits each vertex and edge once in a connected graph',
      'It can only be used to traverse directed graphs'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What kind of graphs can BFS be applied to?',
    options: [
      'Only trees',
      'Only directed graphs',
      'Only undirected graphs',
      'Both directed and undirected graphs'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'Which problem can BFS solve efficiently?',
    options: [
      'Finding the shortest path in a weighted graph',
      'Finding the minimum spanning tree',
      'Finding all reachable nodes from a source node in an unweighted graph',
      'Topological sorting of a directed acyclic graph'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'When performing BFS, what does the queue represent?',
    options: [
      'Nodes that have been visited and processed',
      'Nodes that are yet to be processed but have been discovered',
      'Nodes that are unreachable from the starting node',
      'Nodes that have cycles'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What happens in BFS if the graph is disconnected?',
    options: [
      'BFS will terminate as soon as it reaches an unconnected node',
      'BFS will traverse all the nodes of the graph regardless',
      'BFS will only visit the connected component of the starting node',
      'BFS cannot be applied to disconnected graphs'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the output of BFS when applied to a graph?',
    options: [
      'A spanning tree of the graph',
      'A sorted list of all the nodes',
      'A single path from the source to a target node',
      'All paths from the source to every other node'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How is BFS used to detect a cycle in an undirected graph?',
    options: [
      'By backtracking whenever a node is revisited',
      'By checking if a node is visited again through a different path',
      'By ensuring all nodes are visited at least twice',
      'By finding the shortest path between all nodes'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What happens to BFS if the graph contains edges with weights?',
    options: [
      'BFS ignores the weights and explores all nodes level by level',
      'BFS will find the shortest path using weights',
      'BFS will explore nodes with the smallest weights first',
      'BFS will fail to traverse the graph'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following is an application of BFS?',
    options: [
      'Finding the shortest path in a weighted graph',
      'Checking if a graph is bipartite',
      'Detecting strongly connected components',
      'Implementing depth-first traversal'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is a bipartite graph, and how does BFS help in identifying it?',
    options: [
      'A graph where every node has two children, and BFS is used to check connectivity',
      'A graph that can be colored using two colors, and BFS helps to detect such colorings',
      'A graph where each node has two edges, and BFS checks for cycles',
      'A graph with two disconnected components, and BFS helps to find all nodes'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'In which order does BFS explore nodes?',
    options: [
      'Left to right',
      'Depth-first order',
      'Level-by-level from the starting node',
      'Randomly based on the queue structure'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What condition must be satisfied for BFS to visit every node in a graph?',
    options: [
      'The graph must be connected',
      'The graph must have cycles',
      'The graph must be weighted',
      'The graph must be directed'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What happens if BFS is applied to a graph with multiple components?',
    options: [
      'BFS will only traverse the first component it encounters',
      'BFS will traverse all components in parallel',
      'BFS will only traverse the nodes in the component containing the starting node',
      'BFS will fail to handle multiple components'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which traversal order does BFS provide in a tree?',
    options: [
      'Preorder',
      'Inorder',
      'Level order',
      'Postorder'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'How does BFS handle duplicate nodes in the graph?',
    options: [
      'By visiting each node exactly once',
      'By visiting each node multiple times',
      'By storing duplicates in a separate list',
      'By removing duplicates from the graph'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'In BFS, when are nodes added to the queue?',
    options: [
      'When they are visited',
      'When they are processed',
      'When they are discovered for the first time',
      'When they are fully explored'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is an advantage of BFS over DFS?',
    options: [
      'BFS is faster in all cases',
      'BFS is better for finding the shortest path in unweighted graphs',
      'BFS requires less memory than DFS',
      'BFS can handle weighted graphs'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the primary goal of BFS when used in pathfinding?',
    options: [
      'To explore all nodes in the graph',
      'To find the longest path between two nodes',
      'To find the shortest path between the source and target node in an unweighted graph',
      'To detect cycles in the graph'
    ],
    correctAnswerIndex: 2,
  ),
];

// Create a widget for the AVL Tree Quiz
class BfsQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(BfsQuestions);
    String testId = 'BFS'; // Example test_id, modify as needed
    return QuizUI(quizQuestions: randomQuestions, testId: testId); // Use the common UI
  }
}


// Question model









class BFSGraphVisualizer extends StatefulWidget {
  @override
  _GraphVisualizerState createState() => _GraphVisualizerState();
}

class _GraphVisualizerState extends State<BFSGraphVisualizer> {
  Graph? graph; // Graph object
  String currentOutput = ""; // Holds the step-by-step output
  List<int> traversalNodes = []; // Nodes to highlight during BFS

  @override
  void initState() {
    super.initState();
    graph = Graph(); // Initialize empty graph
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'BFS Algorithm:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.purple),
                        ),
                        Divider(),
                        Text(
                          '''1. Start from a node and enqueue it.
2. Dequeue a node and visit it.
3. Enqueue all unvisited neighbors.
4. Repeat until the queue is empty.''',
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
                  onPressed: _performBFS,
                  child: Text('BFS Traversal'),
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

  // Perform BFS Traversal
  void _performBFS() async {
    setState(() {
      currentOutput = "Starting BFS Traversal...";
      traversalNodes.clear();
    });
    List<int> bfsResult = await _performTraversal(graph!.bfsTraversal());
    setState(() {
      currentOutput += "\nFinal BFS Result: ${bfsResult.join(', ')}";
    });
  }

  // Perform the BFS traversal and highlight nodes
  Future<List<int>> _performTraversal(List<int> nodes) async {
    List<int> result = [];
    for (int value in nodes) {
      setState(() {
        traversalNodes = [value]; // Highlight current node
        currentOutput = "BFS: Visiting $value";
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

  // BFS Traversal
  List<int> bfsTraversal() {
    if (nodes.isEmpty) return [];
    Set<int> visited = {};
    List<int> result = [];
    Queue<Node> queue = Queue();

    // Start with the first node
    queue.add(nodes.first);
    visited.add(nodes.first.value);

    while (queue.isNotEmpty) {
      Node current = queue.removeFirst();
      result.add(current.value);

      for (Node neighbor in current.neighbors) {
        if (!visited.contains(neighbor.value)) {
          queue.add(neighbor);
          visited.add(neighbor.value);
        }
      }
    }

    return result;
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
        ..color = highlightedNodes.contains(graph.nodes[i].value) ? Colors.yellow : Colors.purple; // purple node
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
