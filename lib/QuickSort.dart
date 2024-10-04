import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';

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