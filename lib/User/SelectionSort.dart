import 'package:flutter/material.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';

import 'package:url_launcher/url_launcher.dart';

class SelectionsortNotes extends StatelessWidget {
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
      const url = 'assets/notes/selection_sort.pdf';  // Relative path to the PDF
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


class SelectionSort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // debugShowCheckedModeBanner: false,
      body: SelectionSortScreen(),
    );
  }
}

class SelectionSortScreen extends StatefulWidget {
  @override
  _SelectionSortScreenState createState() => _SelectionSortScreenState();
}

class _SelectionSortScreenState extends State<SelectionSortScreen> {
  List<int> array = []; // Initially empty array
  int? currentIndex; // For visual representation of current index
  int? minIndex; // Index of the minimum element
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
                            'Selection Sort Visualizer',
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
                    onPressed: sorting ? null : () => _selectionSort(),
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
      array = [64, 25, 12, 22, 11]; // Default array
      currentIndex = null;
      minIndex = null;
      currentAlgorithm = """
1. Start from the first element as the minimum.
2. Compare the current minimum with the rest of the array.
3. If a smaller element is found, update the minimum.
4. After scanning the entire array, swap the minimum with the first unsorted element.
5. Repeat until the entire array is sorted.
""";
      currentOutput = "Default array created.";
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      currentIndex = null;
      minIndex = null;
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
              ? Colors.green // Highlight current index
              : (index == minIndex ? Colors.red : Colors.purple), // Min index color
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

  // Perform selection sort with animation
Future<void> _selectionSort() async {
  sorting = true;
  currentOutput = ""; // Clear previous output

  for (int i = 0; i < array.length - 1; i++) {
    int minIdx = i;
    setState(() {
      currentIndex = i; // Highlight the current index
      currentOutput += "Step ${i + 1}: Starting from index $i. Current array: ${array.toString()}\n";
    });

    await Future.delayed(Duration(seconds: 1)); // Pause for visual effect

    for (int j = i + 1; j < array.length; j++) {
      setState(() {
        minIndex = minIdx; // Highlight the current minimum index
        currentOutput += "Comparing ${array[minIdx]} (current min) and ${array[j]} at index $j.\n";
      });

      if (array[j] < array[minIdx]) {
        minIdx = j; // Update the index of the minimum element
        setState(() {
          currentOutput += "Found a new minimum ${array[minIdx]} at index $minIdx.\n"; // Update output
        });
      }
      await Future.delayed(Duration(seconds: 1)); // Pause for visual effect
    }

    // Swap the found minimum element with the first element
    if (minIdx != i) {
      setState(() {
        // Swap the elements
        int temp = array[minIdx];
        array[minIdx] = array[i];
        array[i] = temp;
        currentOutput += "Swapping ${array[i]} and ${array[minIdx]}.\n";
      });
    }

    await Future.delayed(Duration(seconds: 1)); // Pause for visual effect
  }

  setState(() {
    currentOutput += "Sorting complete! Final sorted array: ${array.toString()}.\n";
  });

  // Show the Snackbar with "Sorting Completed"
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("Sorting Completed!"),
      duration: Duration(seconds: 2),
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

final List<Question> SelectionSortQuestions = [
Question(
    questionText: 'What is the time complexity of selection sort in the worst case?',
    options: ['O(n)', 'O(n log n)', 'O(n^2)', 'O(log n)'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What is the primary operation performed in selection sort?',
    options: ['Swapping adjacent elements', 'Finding the maximum element', 'Finding the minimum element', 'Dividing the array'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What is the best-case time complexity of selection sort?',
    options: ['O(n)', 'O(n log n)', 'O(n^2)', 'O(1)'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'Which of the following statements is true about selection sort?',
    options: ['It is a stable sorting algorithm', 'It is not a stable sorting algorithm', 'It can sort linked lists', 'It is an in-place sorting algorithm'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'In selection sort, how many passes are required to sort an array of n elements?',
    options: ['n', 'n-1', 'n/2', 'n^2'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What is the space complexity of selection sort?',
    options: ['O(1)', 'O(n)', 'O(n log n)', 'O(n^2)'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'Which of the following is a characteristic of selection sort?',
    options: ['It performs better on small datasets', 'It is adaptive', 'It is recursive', 'It requires additional memory'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'Which sorting algorithm is often compared to selection sort due to its simplicity?',
    options: ['Bubble sort', 'Insertion sort', 'Merge sort', 'Quick sort'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which of the following data structures does selection sort work best with?',
    options: ['Linked lists', 'Trees', 'Arrays', 'Graphs'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What does selection sort do during each pass through the array?',
    options: ['Selects the smallest element and swaps it with the first unsorted element', 'Swaps adjacent elements if they are out of order', 'Finds the maximum element', 'Sorts the entire array in one pass'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'In selection sort, how is the minimum element found?',
    options: ['By iterating through the entire array', 'By using a divide-and-conquer approach', 'By swapping adjacent elements', 'By using a binary search'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'What is the average-case time complexity of selection sort?',
    options: ['O(n)', 'O(n log n)', 'O(n^2)', 'O(n^3)'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'What happens to the relative order of equal elements in selection sort?',
    options: ['It is preserved', 'It is not preserved', 'It is random', 'It cannot be determined'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which type of algorithm is selection sort classified as?',
    options: ['Comparison sort', 'Non-comparison sort', 'Hybrid sort', 'Distribution sort'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'If the array [7, 9, 1, 3, 5] is sorted using selection sort, what will be the result after the third pass?',
    options: ['[1, 3, 5, 7, 9]', '[1, 3, 5, 9, 7]', '[1, 5, 3, 7, 9]', '[7, 1, 3, 5, 9]'],
    correctAnswerIndex: 0,
),

Question(
    questionText: 'Which of the following describes a disadvantage of selection sort?',
    options: ['It is simple to implement', 'It is inefficient for large data sets', 'It can be implemented recursively', 'It uses less memory'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'What is the primary use case for selection sort?',
    options: ['Sorting small datasets', 'Sorting large datasets', 'Searching for an element', 'Merging two arrays'],
    correctAnswerIndex: 0,
),
Question(
    questionText: 'What is the main advantage of selection sort over other sorting algorithms?',
    options: ['It is the fastest', 'It uses less memory', 'It is easy to understand and implement', 'It is stable'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'How does selection sort handle an already sorted array?',
    options: ['It takes longer than unsorted arrays', 'It completes in the same time as for an unsorted array', 'It behaves differently', 'It throws an error'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Which of the following best describes the operation of selection sort?',
    options: ['It repeatedly compares adjacent elements and swaps them', 'It selects the minimum element from the unsorted portion and swaps it with the first unsorted element', 'It builds a sorted array by adding elements one by one', 'It divides the array into two halves and sorts each half'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'After applying selection sort on the array [3, 1, 2, 5, 4], what will be the state of the array after two passes?',
    options: ['[1, 2, 3, 4, 5]', '[1, 2, 3, 5, 4]', '[1, 3, 2, 4, 5]', '[3, 2, 1, 5, 4]'],
    correctAnswerIndex: 1,
),

Question(
    questionText: 'What is the main goal of the outer loop in selection sort?',
    options: ['To find the largest element', 'To iterate through all elements', 'To track the number of swaps', 'To ensure all elements are sorted'],
    correctAnswerIndex: 3,
),
Question(
    questionText: 'What will the array [8, 7, 6, 5, 4] look like after the first pass of selection sort?',
    options: ['[4, 7, 6, 5, 8]', '[8, 7, 6, 5, 4]', '[4, 8, 6, 5, 7]', '[7, 6, 5, 4, 8]'],
    correctAnswerIndex: 0,
),

Question(
    questionText: 'What happens when there are duplicate elements in the array?',
    options: ['Selection sort treats them as unique', 'Selection sort ignores them', 'Selection sort may swap them', 'Selection sort can only sort unique elements'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'Which sorting algorithm is generally more efficient for larger datasets than selection sort?',
    options: ['Bubble sort', 'Insertion sort', 'Merge sort', 'Selection sort'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'For the array [64, 25, 12, 22, 11], what is the final sorted array after applying selection sort?',
    options: ['[11, 12, 22, 25, 64]', '[64, 25, 12, 11, 22]', '[12, 11, 22, 25, 64]', '[25, 11, 12, 22, 64]'],
    correctAnswerIndex: 0,
),

Question(
    questionText: 'How many comparisons does selection sort make in the worst case?',
    options: ['n', 'n^2', 'n(n-1)/2', '1'],
    correctAnswerIndex: 2,
),
Question(
    questionText: 'If selection sort is applied to the array [5, 3, 6, 2, 4], what will be the result after the second pass?',
    options: ['[2, 3, 5, 4, 6]', '[2, 4, 3, 5, 6]', '[3, 5, 2, 4, 6]', '[2, 3, 6, 5, 4]'],
    correctAnswerIndex: 0,
),

Question(
    questionText: 'In terms of stability, what does it mean for an algorithm to be stable?',
    options: ['It sorts numbers only', 'It keeps equal elements in their original order', 'It uses less memory', 'It can sort both ascending and descending'],
    correctAnswerIndex: 1,
),
Question(
    questionText: 'Given the array [29, 10, 14, 37, 13], what will be the array after the first pass of selection sort?',
    options: ['[10, 29, 14, 37, 13]', '[29, 10, 14, 37, 13]', '[14, 10, 29, 37, 13]', '[29, 10, 37, 14, 13]'],
    correctAnswerIndex: 0,
),


];
class SelectionSortQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(SelectionSortQuestions);
    String testId = 'Selection Sort'; // Example test_id, modify as needed
    return QuizUI(quizQuestions: randomQuestions, testId: testId); // Use the common UI
  }
}