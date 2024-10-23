import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';



class BfsNotes extends StatelessWidget {
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
      const url = 'assets/notes/bfs.pdf';  // Relative path to the PDF
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
    List<Question> randomBfsQuestions = getRandomQuestions(BfsQuestions);
    return QuizUI(quizQuestions: randomBfsQuestions); // Use the common UI
  }
}


// Question model
