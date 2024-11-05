import 'package:flutter/material.dart';
import 'package:dsa_rapid/User/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

class QuicksortNotes extends StatelessWidget {
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
      const url = 'assets/notes/quick_sort.pdf';  // Relative path to the PDF
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


class QuickSort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quick Sort Visualizer',
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
  int? pivotIndex; // For visual representation of pivot index
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
                            'Quick Sort Visualizer',
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
                    onPressed: sorting ? null : () => _quickSort(0, array.length - 1),
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
      array = [10, 80, 30, 90, 40, 50, 70]; // Default array
      currentOutput = "Default array created.";
      pivotIndex = null; // Reset pivot index
      currentAlgorithm = """
1. Choose a pivot element from the array.
2. Partition the array into two sub-arrays:
   - Elements less than the pivot
   - Elements greater than the pivot
3. Recursively apply the above steps to the sub-arrays.
4. Combine the sorted sub-arrays.
""";
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      pivotIndex = null;
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
          color: (index == pivotIndex) ? Colors.green : Colors.purple, // Pivot index color
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

  // Quick Sort algorithm with animation
  Future<void> _quickSort(int low, int high) async {
    sorting = true; // Set sorting state
    currentOutput = ""; // Clear previous output

    if (low < high) {
      // Call partition
      int pivot = await _partition(low, high);
      // Recursively sort the elements
      await _quickSort(low, pivot - 1);
      await _quickSort(pivot + 1, high);
    }

    // Only show the Snackbar after the last sorting is complete
    if (low == 0 && high == array.length - 1) {
      setState(() {
        currentOutput += "Sorting complete! Final sorted array: ${array.toString()}.\n";
      });

      // Show result in a snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sorting complete! Final sorted array: ${array.toString()}'),
        ),
      );
      sorting = false; // Reset sorting state
    }
  }

  // Partition function for Quick Sort
  Future<int> _partition(int low, int high) async {
    int pivot = array[high]; // Choose the last element as pivot
    int i = low - 1; // Index of smaller element

    setState(() {
      pivotIndex = high; // Highlight pivot index
    });
    await Future.delayed(Duration(seconds: 3)); // Pause for visual effect

    for (int j = low; j < high; j++) {
      setState(() {
        currentOutput += "Comparing ${array[j]} with pivot $pivot.\n"; // Show comparison
      });
      await Future.delayed(Duration(seconds: 3)); // Pause for visual effect
      if (array[j] < pivot) {
        i++; // Increment index of smaller element
        setState(() {
          // Swap array[i] and array[j]
          int temp = array[i];
          array[i] = array[j];
          array[j] = temp;
          currentOutput += "Swapping ${array[i]} and ${array[j]}.\n"; // Show swap
        });
        await Future.delayed(Duration(seconds: 3)); // Pause for visual effect
      }
    }

    // Swap array[i + 1] and array[high] (or pivot)
    setState(() {
      int temp = array[i + 1];
      array[i + 1] = array[high];
      array[high] = temp;
      currentOutput += "Placing pivot $pivot at index ${i + 1}.\n"; // Show pivot placement
    });
    await Future.delayed(Duration(seconds: 1)); // Pause for visual effect

    return i + 1; // Return the partition index
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


final List<Question> QuickSortQuestions = [
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

class QuickSortQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(QuickSortQuestions);
    String testId = '15_quicksort'; // Example test_id, modify as needed
    return QuizUI(quizQuestions: randomQuestions, testId: testId); // Use the common UI
  }
}