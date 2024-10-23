import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class InsertionsortNotes extends StatelessWidget {
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
      const url = 'assets/notes/insertion_sort.pdf';  // Relative path to the PDF
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


class InsertionSort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Insertion Sort Visualizer',
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
  bool sorting = false; // State for sort animation
  String currentAlgorithm = ""; // Holds the current algorithm
  String currentOutput = ""; // Holds the step-by-step output

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
                            'Insertion Sort Visualizer',
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
                    onPressed: sorting ? null : () => _insertionSort(),
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
      ),
    );
  }

  // Create default array
  void _createDefaultArray() {
    setState(() {
      array = [40, 20, 30, 10]; // Default array
      currentIndex = null;
      currentAlgorithm = """
1. Start with the first element as a sorted subarray.
2. Take the next element and insert it into the sorted subarray.
3. Shift all larger elements to the right to make space for the new element.
4. Repeat until the entire array is sorted.
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

  // Perform insertion sort with animation
  Future<void> _insertionSort() async {
    sorting = true;
    currentOutput = ""; // Clear previous output

    for (int i = 1; i < array.length; i++) {
      int key = array[i];
      int j = i - 1;

      setState(() {
        currentIndex = i; // Highlight current index
        currentOutput += "Step $i: Key = $key\n"; // Update output
      });

      await Future.delayed(Duration(seconds: 1)); // Pause for visual effect

      while (j >= 0 && array[j] > key) {
        setState(() {
          currentOutput += "Comparing ${array[j]} and $key: ${array[j]} is greater, shifting ${array[j]} to the right.\n"; // Update output
          currentIndex = j; // Highlight the current element being compared
        });

        await Future.delayed(Duration(seconds: 1)); // Pause for visual effect
        array[j + 1] = array[j]; // Shift the element to the right
        j--;

        setState(() {
          currentOutput += "Current array: ${array.toString()}\n"; // Show current state of the array
        });
      }

      array[j + 1] = key; // Insert the key in its correct position
      setState(() {
        currentOutput += "Inserted $key at index ${j + 1}\n"; // Update output
        currentOutput += "Current array: ${array.toString()}\n"; // Show current state of the array
      });

      await Future.delayed(Duration(seconds: 1)); // Pause for visual effect
    }

    currentOutput += "Sorting complete! Final array: ${array.toString()}\n"; // Final output

    // Show result in a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorting complete!'),
      ),
    );

    sorting = false; // Reset sorting state
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


final List<Question> InsertionSortQuestions = [
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
class InsertionSortQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(InsertionSortQuestions);
    return QuizUI(quizQuestions: randomQuestions); // Use the common UI
  }
}