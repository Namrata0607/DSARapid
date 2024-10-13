import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'dart:math';

class InsertionSort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insertion Sort Visualizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InsertionSortScreen(),
    );
  }
}

class InsertionSortScreen extends StatefulWidget {
  @override
  _InsertionSortScreenState createState() => _InsertionSortScreenState();
}

class _InsertionSortScreenState extends State<InsertionSortScreen> {
  List<int> array = []; // Initially empty array
  int? currentIndex; // For visual representation of current index
  int? sortedIndex; // To show the sorted part
  bool sorting = false; // State for sort animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Insertion Sort Visualizer'),
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
                onPressed: sorting ? null : _startInsertionSort,
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
      currentIndex = null;
      sortedIndex = null;
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      currentIndex = null;
      sortedIndex = null;
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
          color: (index == currentIndex)
              ? Colors.red // Highlight current index
              : (index <= (sortedIndex ?? -1))
                  ? Colors.green // Sorted part
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

  // Perform insertion sort with animation
  Future<void> _startInsertionSort() async {
    setState(() {
      sorting = true;
    });

    for (int i = 1; i < array.length; i++) {
      int key = array[i];
      int j = i - 1;

      while (j >= 0 && array[j] > key) {
        setState(() {
          currentIndex = j; // Highlight current comparison
        });
        await Future.delayed(Duration(milliseconds: 500)); // Delay for animation

        setState(() {
          array[j + 1] = array[j]; // Move the greater element one position up
        });
        j = j - 1;
      }
      
      setState(() {
        array[j + 1] = key;
        sortedIndex = i; // Update sorted part of the array
        currentIndex = null;
      });
      await Future.delayed(Duration(milliseconds: 500)); // Delay for animation
    }

    setState(() {
      sorting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Array sorted successfully!'),
      ),
    );
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

// List of questions (Insertion sort questions in data structure)
final List<Question> allQuestions = [
 Question(
    questionText: 'What is the time complexity of insertion sort in the worst case?',
    options: ['O(n)', 'O(n log n)', 'O(n^2)', 'O(log n)'],
    correctAnswerIndex: 2,
),//1
Question(
    questionText: 'What is the primary operation performed in insertion sort?',
    options: ['Finding the maximum element', 'Inserting elements in the correct position', 'Swapping adjacent elements', 'Dividing the array'],
    correctAnswerIndex: 1,
),//2
Question(
    questionText: 'What is the best-case time complexity of insertion sort?',
    options: ['O(n)', 'O(n log n)', 'O(n^2)', 'O(1)'],
    correctAnswerIndex: 0,
),//3
Question(
    questionText: 'Which of the following statements is true about insertion sort?',
    options: ['It is a stable sorting algorithm', 'It is not a stable sorting algorithm', 'It is an in-place sorting algorithm', 'Both a and c'],
    correctAnswerIndex: 3,
),//4
Question(
    questionText: 'In insertion sort, how many passes are required to sort an array of n elements?',
    options: ['n', 'n-1', 'n/2', '1'],
    correctAnswerIndex: 0,
),//5
Question(
    questionText: 'In insertion sort, how many passes are required to sort an array of n elements?',
    options: ['n', 'n-1', 'n/2', '1'],
    correctAnswerIndex: 0,
),//6
Question(
    questionText: 'What is the space complexity of insertion sort?',
    options: ['O(1)', 'O(n)', 'O(n log n)', 'O(n^2)'],
    correctAnswerIndex: 0,
),//7
Question(
    questionText: 'Which of the following is a characteristic of insertion sort?',
    options: ['It performs better on small datasets', 'It is adaptive', 'It is recursive', 'Both a and b'],
    correctAnswerIndex: 3,
),//8
Question(
    questionText: 'Which sorting algorithm is often compared to insertion sort due to its simplicity?',
    options: ['Bubble sort', 'Selection sort', 'Merge sort', 'Quick sort'],
    correctAnswerIndex: 0,
),//9
Question(
    questionText: 'What does insertion sort do during each pass through the array?',
    options: ['Selects the smallest element and moves it to the front', 'Swaps adjacent elements if they are out of order', 'Inserts the next element into the correct position in the sorted portion', 'Sorts the entire array in one pass'],
    correctAnswerIndex: 2,
),//10
Question(
    questionText: 'What happens to the relative order of equal elements in insertion sort?',
    options: ['It is preserved', 'It is not preserved', 'It is random', 'It cannot be determined'],
    correctAnswerIndex: 0,
),//11
Question(
    questionText: 'Given the array [5, 2, 4, 6, 1, 3], what will be the array after the first pass of insertion sort?',
    options: ['[2, 5, 4, 6, 1, 3]', '[5, 2, 4, 6, 1, 3]', '[2, 4, 5, 6, 1, 3]', '[5, 4, 6, 2, 1, 3]'],
    correctAnswerIndex: 0,
),//12
Question(
    questionText: 'If insertion sort is applied to the array [8, 3, 5, 4, 6], what is the result after the second pass?',
    options: ['[3, 8, 5, 4, 6]', '[3, 5, 8, 4, 6]', '[3, 4, 5, 8, 6]', '[8, 3, 5, 4, 6]'],
    correctAnswerIndex: 1,
),//13
Question(
    questionText: 'Consider the array [7, 2, 9, 1, 5]. After the third pass of insertion sort, what will the array look like?',
    options: ['[1, 2, 7, 9, 5]', '[1, 2, 7, 5, 9]', '[1, 2, 5, 7, 9]', '[7, 2, 1, 5, 9]'],
    correctAnswerIndex: 2,
),//14
Question(
    questionText: 'For the array [12, 11, 13, 5, 6], what is the final sorted array after applying insertion sort?',
    options: ['[5, 6, 11, 12, 13]', '[12, 11, 13, 5, 6]', '[11, 12, 5, 6, 13]', '[6, 5, 11, 12, 13]'],
    correctAnswerIndex: 0,
),//15
Question(
    questionText: 'After applying insertion sort on the array [4, 3, 2, 1], what will be the array after the first complete iteration?',
    options: ['[1, 2, 3, 4]', '[4, 3, 2, 1]', '[3, 4, 2, 1]', '[4, 2, 3, 1]'],
    correctAnswerIndex: 3,
),//16
Question(
    questionText: 'What is the primary use case for insertion sort?',
    options: ['Sorting small datasets', 'Sorting large datasets', 'Searching for an element', 'Merging two arrays'],
    correctAnswerIndex: 0,
),//17
Question(
    questionText: 'How does insertion sort handle an already sorted array?',
    options: ['It takes longer than unsorted arrays', 'It completes in the same time as for an unsorted array', 'It behaves differently', 'It throws an error'],
    correctAnswerIndex: 1,
),//18
Question(
    questionText: 'What is the main advantage of insertion sort over other sorting algorithms?',
    options: ['It is the fastest', 'It is easy to understand and implement', 'It uses less memory', 'It is stable'],
    correctAnswerIndex: 1,
),//19
Question(
    questionText: 'Which sorting algorithm is generally more efficient for larger datasets than insertion sort?',
    options: ['Bubble sort', 'Selection sort', 'Merge sort', 'Insertion sort'],
    correctAnswerIndex: 2,
),//20
Question(
    questionText: 'What is the main characteristic of a stable sorting algorithm?',
    options: ['It sorts in ascending order', 'It preserves the relative order of equal elements', 'It uses more memory', 'It can sort both ascending and descending'],
    correctAnswerIndex: 1,
),//21
Question(
    questionText: 'Which of the following is an advantage of insertion sort?',
    options: ['It is faster for small lists', 'It can handle large lists', 'It requires extra memory', 'It is complex to implement'],
    correctAnswerIndex: 0,
),//22
Question(
    questionText: 'If the array [10, 20, 30, 5] is sorted using insertion sort, what will be the position of the number 5 after the first iteration?',
    options: ['1', '2', '3', '4'],
    correctAnswerIndex: 3,
),//23
Question(
    questionText: 'Given the array [5, 4, 3, 2, 1], how many comparisons will insertion sort make during the sorting process?',
    options: ['10', '15', '5', '0'],
    correctAnswerIndex: 1,
),//24
Question(
    questionText: 'For the array [2, 8, 5, 3, 7], what will be the result after the first pass of insertion sort?',
    options: ['[2, 5, 3, 7, 8]', '[2, 8, 5, 3, 7]', '[2, 3, 5, 7, 8]', '[2, 5, 8, 3, 7]'],
    correctAnswerIndex: 0,
),//25
Question(
    questionText: 'What will the array [1, 4, 3, 2, 5] look like after applying insertion sort for two passes?',
    options: ['[1, 2, 3, 4, 5]', '[1, 3, 4, 2, 5]', '[1, 2, 3, 4, 5]', '[1, 4, 3, 2, 5]'],
    correctAnswerIndex: 1,
),//26
Question(
    questionText: 'When sorting the array [6, 5, 4, 3, 2, 1] using insertion sort, how does it compare to sorting an already sorted array?',
    options: ['It is faster', 'It is slower', 'It is the same', 'It cannot be compared'],
    correctAnswerIndex: 1,
),//27
Question(
    questionText: 'What is the primary reason for using insertion sort in practice?',
    options: ['It is the fastest sorting algorithm', 'It is simple to implement and efficient for small datasets', 'It can sort large datasets efficiently', 'It is a non-comparison sort'],
    correctAnswerIndex: 1,
),//28
Question(
    questionText: 'What is the main characteristic of insertion sort regarding memory usage?',
    options: ['It is memory-intensive', 'It is an in-place sorting algorithm', 'It requires auxiliary data structures', 'It needs a lot of temporary storage'],
    correctAnswerIndex: 1,
),//29
Question(
    questionText: 'What is the main drawback of insertion sort?',
    options: ['It is slow for large datasets', 'It is not adaptive', 'It cannot sort strings', 'It requires additional memory'],
    correctAnswerIndex: 0,
),//30
];

// void main() => runApp(QuizApp());

class InsertionSortQuiz extends StatelessWidget {
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
        title: Text('Insertion Sort Quiz'),
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