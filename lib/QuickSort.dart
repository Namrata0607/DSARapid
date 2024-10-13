import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'dart:math';

class QuickSort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Sort Visualizer',
      debugShowCheckedModeBanner: false, // Disable the debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuickSortScreen(),
    );
  }
}

class QuickSortScreen extends StatefulWidget {
  @override
  _QuickSortScreenState createState() => _QuickSortScreenState();
}

class _QuickSortScreenState extends State<QuickSortScreen> {
  List<int> array = []; // Initially empty array
  int? pivotIndex; // Pivot element during the sort
  int? leftIndex; // Left partition pointer
  int? rightIndex; // Right partition pointer
  bool sorting = false; // State for sort animation
  List<int> sortedIndex = []; // Track sorted indexes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Sort Visualizer'),
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
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: _clearArray,
                child: Text('Clear'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () => _showInsertDialog(context),
                child: Text('Insert'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: sorting ? null : _startQuickSort,
                child: Text('Sort'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
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
      array = [35, 12, 99, 24, 50, 1, 89, 63, 16]; // Default array
      pivotIndex = null;
      leftIndex = null;
      rightIndex = null;
      sortedIndex = [];
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      pivotIndex = null;
      leftIndex = null;
      rightIndex = null;
      sortedIndex = [];
    });
  }

  // Show dialog to input value for inserting into the array
  Future<void> _showInsertDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Insert Value');
    if (value != null) {
      setState(() {
        array.add(value); // Add element to array
      });
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
          color: (index == pivotIndex)
              ? Colors.red // Highlight pivot
              : (index == leftIndex || index == rightIndex)
                  ? Colors.orange // Highlight left and right partitions
                  : (sortedIndex.contains(index))
                      ? Colors.green // Highlight sorted part
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

  // Start quick sort with animation
  Future<void> _startQuickSort() async {
    setState(() {
      sorting = true;
    });

    await _quickSort(0, array.length - 1);

    setState(() {
      sorting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Array sorted successfully!'),
      ),
    );
  }

  // Quick sort algorithm with animation
  Future<void> _quickSort(int low, int high) async {
    if (low < high) {
      int p = await _partition(low, high); // Partitioning index

      await Future.wait([
        _quickSort(low, p - 1), // Sort the left side
        _quickSort(p + 1, high), // Sort the right side
      ]);
    } else {
      setState(() {
        if (!sortedIndex.contains(low)) sortedIndex.add(low); // Mark as sorted
      });
    }
  }

  // Partition function for quick sort with visual feedback
  Future<int> _partition(int low, int high) async {
    int pivot = array[high];
    int i = low - 1;

    setState(() {
      pivotIndex = high; // Highlight pivot
    });

    for (int j = low; j < high; j++) {
      setState(() {
        leftIndex = i;
        rightIndex = j;
      });

      await Future.delayed(Duration(milliseconds: 500)); // Delay for animation

      if (array[j] <= pivot) {
        i++;
        setState(() {
          int temp = array[i];
          array[i] = array[j];
          array[j] = temp;
        });

        await Future.delayed(Duration(milliseconds: 500)); // Delay for animation
      }
    }

    setState(() {
      int temp = array[i + 1];
      array[i + 1] = array[high];
      array[high] = temp;
    });

    await Future.delayed(Duration(milliseconds: 500)); // Delay for animation

    setState(() {
      sortedIndex.add(i + 1); // Mark the pivot as sorted
      pivotIndex = null;
      leftIndex = null;
      rightIndex = null;
    });

    return i + 1;
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

// List of questions (Quick sort questions in data structure)
final List<Question> allQuestions = [
 Question(
    questionText: 'What is the average time complexity of the Quick Sort algorithm?',
    options: ['O(n^2)', 'O(n log n)', 'O(log n)', 'O(n)'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'In Quick Sort, what is the purpose of the pivot element?',
    options: ['To sort the array', 'To divide the array', 'To find the minimum element', 'To find the maximum element'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which of the following is a valid partitioning scheme in Quick Sort?',
    options: ['Hoare Partitioning', 'Lomuto Partitioning', 'Both A and B', 'None of the above'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What is the worst-case time complexity of Quick Sort?',
    options: ['O(n)', 'O(n log n)', 'O(n^2)', 'O(log n)'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'In Quick Sort, if the pivot is always the smallest or largest element, what will be the time complexity?',
    options: ['O(n)', 'O(n^2)', 'O(n log n)', 'O(log n)'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What is the space complexity of Quick Sort in the average case?',
    options: ['O(n)', 'O(log n)', 'O(1)', 'O(n log n)'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What happens to the elements equal to the pivot during partitioning?',
    options: ['They are ignored', 'They are moved to the left', 'They can go to either side', 'They are sorted separately'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'For the array [3, 6, 8, 10, 1, 2, 1], what will be the array look like after the first partition using 3 as the pivot?',
    options: ['[1, 1, 2, 3, 6, 8, 10]', '[2, 1, 3, 10, 8, 6, 1]', '[3, 6, 8, 10, 1, 2, 1]', '[3, 1, 2, 10, 8, 6, 1]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'After the first partition of the array [8, 7, 6, 1, 0, 5, 4] with 5 as the pivot, what will be the state of the array?',
    options: ['[1, 0, 4, 5, 8, 7, 6]', '[5, 4, 1, 0, 6, 7, 8]', '[8, 7, 6, 1, 0, 4, 5]', '[4, 5, 1, 0, 8, 7, 6]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'What is the initial step of Quick Sort?',
    options: ['Choosing a pivot', 'Dividing the array', 'Sorting the array', 'Merging the arrays'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'If Quick Sort is implemented with the first element as the pivot, which of the following is the best case scenario?',
    options: ['Sorted array', 'Reverse sorted array', 'Random array', 'All elements are the same'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'After applying Quick Sort on the array [12, 11, 13, 5, 6], what will be the final sorted array?',
    options: ['[5, 6, 11, 12, 13]', '[11, 5, 6, 12, 13]', '[12, 11, 5, 6, 13]', '[13, 12, 11, 6, 5]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'Given the array [10, 7, 8, 9, 1, 5], what will the array look like after partitioning around the pivot 9?',
    options: ['[1, 5, 7, 8, 9, 10]', '[7, 8, 9, 10, 5, 1]', '[10, 9, 8, 7, 5, 1]', '[10, 1, 5, 7, 8, 9]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'In the array [20, 18, 12, 8, 5, 2], if 12 is chosen as the pivot, what will be the result of the partition step?',
    options: ['[5, 2, 8, 12, 20, 18]', '[12, 18, 20, 5, 8, 2]', '[20, 18, 12, 8, 5, 2]', '[12, 5, 2, 8, 18, 20]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'What type of sorting algorithm is Quick Sort?',
    options: ['Stable', 'In-Place', 'Non-Recursive', 'All of the above'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'How many times is the pivot element selected during the sorting process?',
    options: ['Once', 'Twice', 'Multiple times', 'Zero times'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'If the array is [4, 3, 7, 1, 5] and 3 is chosen as the pivot, what will be the partitioned array?',
    options: ['[1, 3, 4, 7, 5]', '[4, 1, 3, 5, 7]', '[1, 4, 3, 5, 7]', '[1, 5, 4, 7, 3]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'After applying Quick Sort on the array [9, 7, 8, 5, 6], what will be the array after the first partitioning with 8 as the pivot?',
    options: ['[5, 6, 7, 8, 9]', '[8, 7, 5, 6, 9]', '[9, 8, 7, 5, 6]', '[5, 7, 9, 8, 6]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'In Quick Sort, what does the recursion do after partitioning the array?',
    options: ['Sorts the left and right subarrays', 'Sorts the entire array', 'Ends the sorting process', 'None of the above'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'What will be the result of sorting the array [10, 80, 30, 90, 40, 50, 70] using Quick Sort with 40 as the pivot?',
    options: ['[10, 30, 40, 50, 70, 80, 90]', '[30, 10, 40, 70, 80, 90, 50]', '[40, 30, 10, 50, 70, 80, 90]', '[10, 30, 40, 90, 80, 70, 50]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'In the Quick Sort algorithm, which partitioning method is preferred for its efficiency?',
    options: ['Hoare partitioning', 'Lomuto partitioning', 'Both A and B', 'None of the above'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What is the main disadvantage of Quick Sort compared to Merge Sort?',
    options: ['Quick Sort is not stable', 'Quick Sort has a worse average case', 'Quick Sort is not in-place', 'None of the above'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'Given the array [5, 3, 8, 4, 6] with 4 as the pivot, what will be the result of the partitioning step?',
    options: ['[3, 4, 5, 6, 8]', '[5, 3, 4, 6, 8]', '[4, 3, 5, 8, 6]', '[6, 4, 5, 3, 8]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'After partitioning the array [7, 2, 1, 6, 8, 5, 3, 4] with 4 as the pivot, what will the array look like?',
    options: ['[1, 2, 3, 4, 8, 5, 6, 7]', '[7, 2, 1, 6, 4, 8, 5, 3]', '[4, 3, 5, 2, 1, 6, 8, 7]', '[2, 1, 3, 4, 5, 6, 7, 8]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'For the array [9, 4, 6, 2, 5] after one complete pass of Quick Sort with 5 as the pivot, what will the state of the array be?',
    options: ['[2, 4, 5, 6, 9]', '[5, 4, 2, 6, 9]', '[9, 6, 5, 4, 2]', '[4, 2, 5, 9, 6]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'What is the best-case time complexity for Quick Sort?',
    options: ['O(n log n)', 'O(n)', 'O(n^2)', 'O(log n)'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'If you have an array [1, 5, 4, 3, 2], and you pick 3 as the pivot, what will the partitioned result be?',
    options: ['[1, 2, 3, 5, 4]', '[4, 5, 3, 1, 2]', '[1, 3, 4, 5, 2]', '[1, 2, 4, 3, 5]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'In Quick Sort, when is the base case of recursion reached?',
    options: ['When the array has one element', 'When the array is empty', 'When the array is sorted', 'All of the above'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'What will the final sorted array be for [7, 2, 1, 6, 8, 5] after applying Quick Sort?',
    options: ['[1, 2, 5, 6, 7, 8]', '[2, 5, 1, 6, 8, 7]', '[7, 6, 5, 2, 1, 8]', '[1, 2, 6, 7, 8, 5]'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'When implementing Quick Sort, what technique is often used to avoid the worst-case scenario?',
    options: ['Randomized pivot selection', 'Fixed pivot selection', 'In-place sorting', 'Merging sorted arrays'],
    correctAnswerIndex: 0,
),

];

// void main() => runApp(QuizApp());

class QuickSortQuiz extends StatelessWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Sort Quiz'),
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
            primary: Color.fromARGB(255, 167, 69, 167),
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
              primary: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}