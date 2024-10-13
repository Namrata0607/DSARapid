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
