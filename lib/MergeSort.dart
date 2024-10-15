import 'package:flutter/material.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'dart:math';

class MergeSort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merge Sort Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MergeSortScreen(),
    );
  }
}

class MergeSortScreen extends StatefulWidget {
  @override
  _MergeSortScreenState createState() => _MergeSortScreenState();
}

class _MergeSortScreenState extends State<MergeSortScreen> {
  List<int> array = []; // Initially empty array
  int? currentLeft; // Left index for visual representation
  int? currentRight; // Right index for visual representation
  bool sorting = false; // State for sort animation
  String currentAlgorithm = ""; // Holds the current algorithm
  String currentOutput = ""; // Holds the step-by-step output

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Merge Sort Visualizer'),
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
                          'Merge Sort Visualizer',
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
                  onPressed: sorting ? null : _startMergeSort,
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
      currentLeft = null;
      currentRight = null;
      currentAlgorithm = """
1. Split the array into two halves.
2. Recursively split each half until each subarray contains a single element.
3. Merge the sorted subarrays by comparing the smallest elements.
4. Repeat until the entire array is merged and sorted.
""";
      currentOutput = "Default array created.";
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      currentLeft = null;
      currentRight = null;
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
          color: (index == currentLeft || index == currentRight)
              ? Color.fromARGB(255, 85, 255, 227) // Highlight current comparison
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

  // Perform merge sort with animation
  Future<void> _startMergeSort() async {
    sorting = true;
    currentOutput = ""; // Clear previous output

    await _mergeSort(0, array.length - 1); // Start merge sort

    currentOutput += "Sorting complete! Final array: ${array.toString()}\n"; // Final output
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorting complete!'),
      ),
    );

    sorting = false;
  }

  Future<void> _mergeSort(int left, int right) async {
    if (left < right) {
      int mid = (left + right) ~/ 2;

      currentOutput += "Splitting array from index $left to $mid and $mid to $right\n";
      await Future.delayed(Duration(seconds: 1)); // Pause for visual effect

      await _mergeSort(left, mid);
      await _mergeSort(mid + 1, right);
      await _merge(left, mid, right);
    }
  }

  Future<void> _merge(int left, int mid, int right) async {
    int i = left, j = mid + 1;
    List<int> temp = [];

    while (i <= mid && j <= right) {
      setState(() {
        currentLeft = i;
        currentRight = j;
        currentOutput += "Comparing index $i and index $j\n";
      });
      await Future.delayed(Duration(seconds: 1)); // Pause for visual effect

      if (array[i] < array[j]) {
        temp.add(array[i]);
        i++;
      } else {
        temp.add(array[j]);
        j++;
      }
    }

    while (i <= mid) {
      temp.add(array[i]);
      i++;
    }

    while (j <= right) {
      temp.add(array[j]);
      j++;
    }

    for (int k = 0; k < temp.length; k++) {
      array[left + k] = temp[k];
    }

    setState(() {
      currentOutput += "Merged subarray: ${temp.toString()}\n";
    });
    await Future.delayed(Duration(seconds: 3)); // Pause for visual effect
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

// List of questions (array questions in data structure)
final List<Question> allQuestions = [
 Question(
  questionText: 'Which of the following is true about merge sort?',
  options: ['It is a divide-and-conquer algorithm', 'It is not stable', 'It can sort linked lists in O(n log n)', 'Both A and C'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'What is the space complexity of merge sort?',
  options: ['O(n)', 'O(1)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of merge sort in the average case?',
  options: ['O(n log n)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the time complexity of merge sort in the average case?',
  options: ['O(n log n)', 'O(n)', 'O(log n)', 'O(n^2)'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the primary purpose of merge sort?',
  options: ['To sort an array', 'To search an element', 'To reverse an array', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following is true about merge sort?',
  options: ['It is a divide-and-conquer algorithm', 'It is not stable', 'It can sort linked lists in O(n log n)', 'Both A and C'],
  correctAnswerIndex: 3,
),
Question(
  questionText: 'How does merge sort divide the array?',
  options: ['Into halves', 'Into quarters', 'Into thirds', 'Randomly'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the first step in the merge sort algorithm?',
  options: ['Merge the arrays', 'Divide the array', 'Sort the array', 'None of the above'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'How many times is the merge function called in merge sort for an array of size n?',
  options: ['n', 'n log n', 'log n', '1'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'In merge sort, what is the base case for the recursive function?',
  options: ['When the array has one element', 'When the array is empty', 'When the array is sorted', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'Which of the following best describes the merge process in merge sort?',
  options: ['Combining two sorted arrays into one sorted array', 'Splitting an array into two parts', 'Sorting an array in-place', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is the worst-case time complexity of merge sort?',
  options: ['O(n)', 'O(log n)', 'O(n log n)', 'O(n^2)'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'Which of the following is a key advantage of merge sort?',
  options: ['It is an in-place sorting algorithm', 'It is stable and works well on large datasets', 'It uses less memory', 'None of the above'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'What happens to the order of equal elements in merge sort?',
  options: ['The order is not preserved', 'The order is preserved', 'They are randomly ordered', 'None of the above'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'How does merge sort handle an array of size 0 or 1?',
  options: ['It throws an error', 'It does nothing', 'It merges the array', 'None of the above'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'Which of the following sorting algorithms is similar to merge sort?',
  options: ['Quick sort', 'Heap sort', 'Bubble sort', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What data structure is often used to implement merge sort?',
  options: ['Arrays', 'Linked lists', 'Both A and B', 'None of the above'],
  correctAnswerIndex: 2,
),
Question(
  questionText: 'What is the primary disadvantage of merge sort?',
  options: ['It is not efficient for small datasets', 'It requires additional space for temporary arrays', 'It is not a stable sort', 'None of the above'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'What is the merge sort algorithm’s approach to sorting an array?',
  options: ['Sorting in-place', 'Dividing, sorting, and merging', 'Using a heap', 'None of the above'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'In which scenario is merge sort particularly useful?',
  options: ['When data is already sorted', 'When data is too large to fit in memory', 'When speed is the only concern', 'None of the above'],
  correctAnswerIndex: 1,
),
Question(
  questionText: 'When merging two sorted arrays, what do you need to maintain?',
  options: ['The order of elements', 'The size of the arrays', 'The indices of elements', 'None of the above'],
  correctAnswerIndex: 0,
),
Question(
  questionText: 'What is a real-world application of merge sort?',
  options: ['Sorting files on a disk', 'Searching for an element in an array', 'Generating random numbers', 'None of the above'],
  correctAnswerIndex: 0,
),


];


class MergesortQuiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merge Sort Quiz',
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
        title: Text('Merge Sort Quiz'),
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
            padding: EdgeInsets.all(16.0), backgroundColor: Color.fromARGB(255, 167, 69, 167),
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




