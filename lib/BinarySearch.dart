import 'package:flutter/material.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'dart:math';


// void main() {
//   runApp(BinarySearchVisualizerApp());
// }

class BinarySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary Search Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BinarySearchScreen(),
    );
  }
}

class BinarySearchScreen extends StatefulWidget {
  @override
  _BinarySearchScreenState createState() => _BinarySearchScreenState();
}

class _BinarySearchScreenState extends State<BinarySearchScreen> {
  List<int> array = []; // Initially empty array
  int? left, right; // For visual representation of search bounds
  bool searching = false; // State for search animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Binary Search Visualizer'),
        backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: array.isEmpty
                      ? [
                          Text(
                            'Array is empty',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          )
                        ]
                      : _buildBars(),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _createDefaultArray, // Create Default Button
                child: Text('Create Default'),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.purple),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: _clearArray,
                child: Text('Clear'),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.purple),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () => _showInsertDialog(context),
                child: Text('Insert'),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.purple),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: searching ? null : () => _showFindIndexDialog(context),
                child: Text('Search'),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.purple),
                  foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // Create default array
  void _createDefaultArray() {
    setState(() {
      array = [10, 20, 30, 40, 50,60,70,80,90,100]; // Default array
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      left = null;
      right = null;
    });
  }

  // Show dialog to input value for inserting into the array
  Future<void> _showInsertDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Insert Value');
    if (value != null) {
      setState(() {
        array.add(value); // Add element to array
        array.sort(); // Sort the array after insertion for binary search
      });
    }
  }

  // Show dialog to find the index of an element using binary search
  Future<void> _showFindIndexDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Find Index of Value');
    if (value != null) {
      await _binarySearch(value); // Perform binary search with animation
    }
  }

  // Build the visual bars for the array
  List<Widget> _buildBars() {
    return List<Widget>.generate(array.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: AnimatedContainer(
          height: 100, // Fixed height for all bars
          width: 60,
          duration: Duration(milliseconds: 300),
          color: (index == left || index == right)
              ? Colors.red // Highlight search bounds
              : Colors.purple, // Default bar color
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Text(
              array[index].toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    });
  }

  // Perform binary search with animation
  Future<void> _binarySearch(int value) async {
    searching = true;
    left = 0;
    right = array.length - 1;

    while (left! <= right!) {
      setState(() {});
      await Future.delayed(Duration(seconds: 2)); // Pause for visual effect

      int mid = left! + (right! - left!) ~/ 2;
      if (array[mid] == value) {
        setState(() {
          left = mid; // Highlight found index
          right = mid; // Highlight found index
        });
        await Future.delayed(Duration(seconds: 1));
        break;
      } else if (array[mid] < value) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
      setState(() {
        // Optional: Add a small visual effect (e.g., change mid bar color momentarily)
      });
    }

    // Show result in a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value.toString() + ' found at index: ${left!}'),
      ),
    );

    searching = false;
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

// List of questions (binary questions in data structure)
final List<Question> allQuestions = [
  Question(
  questionText: 'What is the time complexity of the binary search algorithm in the best case?',
  options: ['O(1)', 'O(log n)', 'O(n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of binary search in the average case?',
  options: ['O(log n)', 'O(n)', 'O(n log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of binary search in the worst case?',
  options: ['O(1)', 'O(log n)', 'O(n)', 'O(n log n)'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'Binary search requires the array to be:',
  options: ['Unsorted', 'Sorted', 'Random', 'Reverse Sorted'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'Binary search requires the array to be:',
  options: ['Unsorted', 'Sorted', 'Random', 'Reverse Sorted'],
  correctAnswerIndex: 1,
),
  Question(
  questionText: 'Which of the following is a valid example of using binary search?',
  options: ['Searching in a sorted array', 'Searching in a linked list', 'Searching in an unsorted array', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Given a sorted array [10, 20, 30, 40, 50], what will be the mid index when performing binary search for 30?',
  options: ['2', '1', '3', '0'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following conditions is used to check if the search element is in the left half during binary search?',
  options: ['element < mid', 'element > mid', 'element == mid', 'element >= mid'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a sorted array [5, 15, 25, 35, 45], what would be the first mid element if we search for 35?',
  options: ['25', '35', '15', '45'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What happens if the element is not found in binary search?',
  options: ['The algorithm returns -1', 'The algorithm throws an error', 'It enters an infinite loop', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Binary search is most efficient when the array size is:',
  options: ['Large', 'Small', 'One element', 'Unsorted'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which data structure is most suitable for binary search?',
  options: ['Array', 'Linked List', 'Queue', 'Stack'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the space complexity of binary search?',
  options: ['O(1)', 'O(log n)', 'O(n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following is a correct recursive implementation of binary search?',
  options: ['Divide the array into halves', 'Iterate over the array linearly', 'Randomly select mid-point', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'In a binary search tree (BST), what is the time complexity of searching for an element in the average case?',
  options: ['O(log n)', 'O(n)', 'O(n^2)', 'O(1)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the main advantage of binary search over linear search?',
  options: ['It works faster on large data sets', 'It works on unsorted arrays', 'It uses more space', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which condition terminates the binary search algorithm?',
  options: ['left > right', 'mid == element', 'left == mid', 'right < element'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Binary search is an example of which type of algorithm?',
  options: ['Divide and conquer', 'Greedy', 'Dynamic programming', 'Backtracking'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following does binary search NOT work on?',
  options: ['Sorted arrays', 'Arrays with duplicate elements', 'Unsorted arrays', 'None of the above'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'In binary search, how many comparisons are made in the worst case for an array of size 16?',
  options: ['4', '16', '8', '5'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'Which of the following algorithms has a time complexity similar to binary search?',
  options: ['Quick sort', 'Merge sort', 'Linear search', 'Selection sort'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'Binary search can also be implemented iteratively. True or false?',
  options: ['True', 'False'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'If binary search fails to find an element, it returns:',
  options: ['-1', '0', 'None', 'The closest value'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Binary search is optimal when searching for an element in which data structure?',
  options: ['Sorted array', 'Linked list', 'Hash map', 'Tree'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the maximum depth of a binary search for an array of size 64?',
  options: ['6', '64', '5', '7'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'Which of the following is true about binary search?',
  options: ['It works faster than linear search for small datasets', 'It works on linked lists', 'It works on sorted arrays', 'It requires O(n) space'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'What is the major drawback of binary search?',
  options: ['Array must be sorted', 'It requires a lot of memory', 'It has O(n) time complexity', 'It only works for large datasets'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Binary search is applicable in searching through which of the following?',
  options: ['Sorted linked list', 'Hash tables', 'Sorted arrays', 'Unsorted stacks'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'Binary search compares the target element with:',
  options: ['Middle element', 'First element', 'Last element', 'Random element'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Binary search can be applied to which of the following data structures?',
  options: ['Array', 'Hash table', 'Linked list', 'Queue'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'If you perform binary search on a sorted array of size 1000, how many comparisons will be needed in the worst case?',
  options: ['10', '9', '11', '100'],
  correctAnswerIndex: 2,
),

];

// void main() => runApp(QuizApp());

class BinarySearchQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary Search Quiz',
      debugShowCheckedModeBanner: false,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Array Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isSubmitted ? buildResultScreen() : buildQuizBody(),
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
        ElevatedButton(
          onPressed: selectedAnswers.length == quizQuestions.length
              ? submitQuiz
              : null, // Enable button only if all questions are answered
          child: Text('Submit Quiz'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(16.0), 
            backgroundColor: Color.fromARGB(255, 167, 69, 167),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Your Score: $score / ${quizQuestions.length}',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: restartQuiz,
            child: Text('Restart Quiz'),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(16.0), 
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}