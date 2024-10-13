import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'dart:math';


class BubbleSort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bubble Sort Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BubbleSortScreen(),
    );
  }
}

class BubbleSortScreen extends StatefulWidget {
  @override
  _BubbleSortScreenState createState() => _BubbleSortScreenState();
}

class _BubbleSortScreenState extends State<BubbleSortScreen> {
  List<int> array = []; // Initially empty array
  int? currentIndex; // For visual representation of current index
  bool sorting = false; // State for sort animation
  String currentAlgorithm = ""; // Holds the current algorithm
  String currentOutput = ""; // Holds the step-by-step output

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bubble Sort Visualizer'),
        backgroundColor: Colors.purple,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Left Container (for Algorithm and Output)
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
                        // Output/Step-by-step explanation section
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
                // Right Container (for Array Visualizer)
                Expanded(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Bubble Sort Visualizer',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                        Divider(),
                        Expanded(
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: array.isEmpty
                                    ? [
                                        Text(
                                          'Array is empty',
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.red),
                                        )
                                      ]
                                    : _buildBars(),
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
          // Bottom Container (for Operation Buttons)
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            color: Colors.grey.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _createDefaultArray,
                  child: Text('Create Default'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _clearArray,
                  child: Text('Clear'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => _showInsertDialog(context),
                  child: Text('Insert'),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.purple),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: sorting ? null : () => _bubbleSort(),
                  child: Text('Sort'),
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
    );
  }

  // Create default array
  void _createDefaultArray() {
    setState(() {
      array = [40, 20, 30, 10]; // Default array
      currentIndex = null;
      currentAlgorithm = """
1. Compare the first two adjacent elements.
2. If the first element is greater than the second, swap them.
3. Move to the next pair of adjacent elements and repeat the process.
4. Continue this for each element in the array.
5. Repeat the entire process until no swaps are needed.
""";
      currentOutput = "Default array created.";
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      currentIndex = null;
      currentAlgorithm = "";
      currentOutput = "Array cleared.";
    });
  }

  // Show dialog to input value for inserting into the array
  Future<void> _showInsertDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Insert Value');
    if (value != null) {
      setState(() {
        array.add(value); // Add element to array
        currentOutput = "Inserted $value into the array.";
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
              ? Color.fromARGB(255, 85, 255, 227) // Highlight current index
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

  // Perform bubble sort with animation
  Future<void> _bubbleSort() async {
    sorting = true;
    currentOutput = ""; // Clear previous output

    for (int i = 0; i < array.length - 1; i++) {
      for (int j = 0; j < array.length - i - 1; j++) {
        setState(() {
          currentIndex = j; // Highlight current index
          currentOutput += "Step ${i * (array.length - 1) + j + 1}: Comparing index $j and index ${j + 1}\n"; // Update output
          currentOutput += "Values: ${array[j]} and ${array[j + 1]}\n"; // Show values being compared
        });
        await Future.delayed(Duration(seconds: 1)); // Pause for visual effect

        if (array[j] > array[j + 1]) {
          // Swap if the current element is greater than the next
          setState(() {
            // Perform the swap
            int temp = array[j];
            array[j] = array[j + 1];
            array[j + 1] = temp;

            currentOutput += "Swapped: ${array[j]} and ${array[j + 1]}\n"; // Update output
          });
        } else {
          currentOutput += "No swap needed.\n"; // Update output for no swap
        }
        await Future.delayed(Duration(seconds: 1)); // Pause for visual effect
      }
    }

    currentOutput += "Sorting complete! Final array: ${array.toString()}\n"; // Final output
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorting complete!'),
      ),
    );

    sorting = false;
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

// List of questions (buuble sort questions in data structure)
final List<Question> allQuestions = [
  Question(
    questionText: 'What is the time complexity of bubble sort in the worst case?',
    options: ['O(n)', 'O(n log n)', 'O(n^2)', 'O(log n)'],
    correctAnswerIndex: 2,
),//1

Question(
    questionText: 'What is the primary purpose of bubble sort?',
    options: ['To search for an element', 'To sort a list of elements', 'To merge two lists', 'To divide a list'],
    correctAnswerIndex: 1,
),//2

Question(
    questionText: 'In which of the following scenarios is bubble sort most efficient?',
    options: ['When the array is sorted', 'When the array is in reverse order', 'When the array has many duplicate elements', 'When the array is very large'],
    correctAnswerIndex: 0,
),//3

Question(
    questionText: 'Which of the following statements is true about bubble sort?',
    options: ['It is a stable sorting algorithm', 'It is not a stable sorting algorithm', 'It can sort linked lists', 'It is not an in-place sorting algorithm'],
    correctAnswerIndex: 0,
),//4

Question(
    questionText: 'What is the best-case time complexity of bubble sort?',
    options: ['O(n)', 'O(n log n)', 'O(n^2)', 'O(1)'],
    correctAnswerIndex: 0,
),//5
Question(
    questionText: 'Which of the following is a disadvantage of bubble sort?',
    options: ['It is simple to implement', 'It is inefficient for large data sets', 'It can be implemented recursively', 'It requires extra space'],
    correctAnswerIndex: 1,
),//6
Question(
    questionText: 'What does bubble sort do during each pass through the array?',
    options: ['Sorts all elements', 'Swaps adjacent elements if they are out of order', 'Finds the maximum element', 'Sorts the first half of the array'],
    correctAnswerIndex: 1,
),//7
Question(
    questionText: 'How many passes does bubble sort typically require in the worst case?',
    options: ['n', 'n-1', 'n^2', '1'],
    correctAnswerIndex: 1,
),//8
Question(
    questionText: 'Which of the following is an advantage of bubble sort?',
    options: ['It is the fastest sorting algorithm', 'It is easy to understand and implement', 'It can sort in place without additional memory', 'Both b and c'],
    correctAnswerIndex: 3,
),//9
Question(
    questionText: 'After the first complete iteration of bubble sort on the array [9, 3, 5, 1], what will be the state of the array?',
    options: ['[1, 3, 5, 9]', '[3, 5, 1, 9]', '[9, 5, 3, 1]', '[3, 1, 5, 9]'],
    correctAnswerIndex: 1,
),//10
Question(
    questionText: 'What is the average-case time complexity of bubble sort?',
    options: ['O(n)', 'O(n log n)', 'O(n^2)', 'O(n^3)'],
    correctAnswerIndex: 2,
),//11
Question(
    questionText: 'Bubble sort is classified as which type of sorting algorithm?',
    options: ['Comparison sort', 'Non-comparison sort', 'Distribution sort', 'Hybrid sort'],
    correctAnswerIndex: 0,
),//12
Question(
    questionText: 'Which type of data structure does bubble sort work on?',
    options: ['Arrays', 'Linked lists', 'Trees', 'Graphs'],
    correctAnswerIndex: 0,
),//13
Question(
    questionText: 'What is the space complexity of bubble sort?',
    options: ['O(1)', 'O(n)', 'O(n log n)', 'O(n^2)'],
    correctAnswerIndex: 0,
),//14
Question(
    questionText: 'What is the primary operation performed in bubble sort?',
    options: ['Comparison', 'Division', 'Insertion', 'Selection'],
    correctAnswerIndex: 0,
),//15
Question(
    questionText: 'Given the array [1, 4, 3, 2, 5], how many total passes will bubble sort make to sort the array completely?',
    options: ['1', '2', '4', '5'],
    correctAnswerIndex: 3,
),//16
Question(
    questionText: 'What will the array [2, 9, 5, 1, 7] look like after the first pass of bubble sort?',
    options: ['[1, 2, 5, 7, 9]', '[2, 5, 1, 7, 9]', '[2, 9, 5, 1, 7]', '[2, 5, 1, 7, 9]'],
    correctAnswerIndex: 3,
),//17
Question(
    questionText: 'Which of the following best describes the operation of bubble sort?',
    options: ['It divides the array into two halves', 'It repeatedly compares adjacent elements and swaps them if they are in the wrong order', 'It builds a sorted array by adding elements one by one', 'It selects the minimum element and places it at the beginning'],
    correctAnswerIndex: 1,
),//18
Question(
    questionText: 'For the array [8, 7, 6, 5, 4], what is the final sorted array after applying bubble sort?',
    options: ['[4, 5, 6, 7, 8]', '[8, 7, 6, 5, 4]', '[5, 6, 7, 8, 4]', '[7, 8, 6, 5, 4]'],
    correctAnswerIndex: 0,
),//19
Question(
    questionText: 'What is the main characteristic of a stable sorting algorithm?',
    options: ['It always sorts in ascending order', 'It maintains the relative order of equal elements', 'It uses more memory', 'It is faster than unstable algorithms'],
    correctAnswerIndex: 1,
),//20
Question(
    questionText: 'How does bubble sort handle an already sorted array?',
    options: ['It takes longer than unsorted arrays', 'It completes in one pass with no swaps', 'It behaves the same as an unsorted array', 'It throws an error'],
    correctAnswerIndex: 1,
),//21
Question(
    questionText: 'In bubble sort, which element is moved to its final position after each pass?',
    options: ['The smallest element', 'The largest element', 'The middle element', 'The first element'],
    correctAnswerIndex: 1,
),//22
Question(
    questionText: 'If bubble sort is applied to the array [3, 2, 1, 4], what will be the result after the second pass?',
    options: ['[1, 2, 3, 4]', '[2, 1, 3, 4]', '[3, 1, 2, 4]', '[3, 2, 1, 4]'],
    correctAnswerIndex: 1,
),//23
Question(
    questionText: 'Given the array [5, 1, 4, 2, 8], what will be the array after the first pass of bubble sort?',
    options: ['[1, 4, 2, 5, 8]', '[5, 1, 4, 2, 8]', '[1, 2, 4, 5, 8]', '[1, 4, 2, 8, 5]'],
    correctAnswerIndex: 0,
),//24
Question(
    questionText: 'What is the primary disadvantage of bubble sort when compared to more advanced sorting algorithms?',
    options: ['It is stable', 'It is inefficient on large datasets', 'It is easy to implement', 'It uses less memory'],
    correctAnswerIndex: 1,
),//25
Question(
    questionText: 'If the array [4, 2, 6, 5, 3] is sorted using bubble sort, what will be the result after the second pass?',
    options: ['[2, 3, 4, 5, 6]', '[4, 2, 5, 3, 6]', '[4, 2, 5, 6, 3]', '[2, 4, 3, 5, 6]'],
    correctAnswerIndex: 3,
),//26
Question(
    questionText: 'For the array [7, 5, 8, 6, 3], what will the array look like after the third pass of bubble sort?',
    options: ['[3, 5, 6, 7, 8]', '[5, 6, 3, 7, 8]', '[5, 7, 6, 3, 8]', '[7, 6, 5, 3, 8]'],
    correctAnswerIndex: 0,
),//27
Question(
    questionText: 'What is the main advantage of bubble sort in teaching sorting algorithms?',
    options: ['It is the most efficient', 'It is the easiest to understand', 'It can handle large datasets', 'It uses complex logic'],
    correctAnswerIndex: 1,
),//28
Question(
    questionText: 'What is the purpose of the outer loop in bubble sort?',
    options: ['To iterate through the entire array', 'To track the number of swaps', 'To ensure all elements are sorted', 'To find the maximum element'],
    correctAnswerIndex: 2,
),//29
Question(
    questionText: 'What will be the state of the array [10, 1, 2, 3, 5] after applying bubble sort for two passes?',
    options: ['[1, 2, 3, 5, 10]', '[1, 3, 2, 5, 10]', '[10, 1, 2, 3, 5]', '[1, 10, 2, 3, 5]'],
    correctAnswerIndex: 1,
),//30

];

// void main() => runApp(QuizApp());

class BubbleSortQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bubble sort Quiz',
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
            // primary: Color.fromARGB(255, 167, 69, 167),
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
              // primary: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}