import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class DfsNotes extends StatelessWidget {
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
      const url = 'assets/notes/dfs.pdf';  // Relative path to the PDF
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

// List of questions (DFS)
final List<Question> allQuestions = [
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


//void main() => runApp(QuizApp());

class DfsQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Array Quiz',
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



