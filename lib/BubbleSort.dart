import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';

class BubbleSort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bubble Sort Visualizer',
      debugShowCheckedModeBanner: false, // Disable the debug banner
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
  int? currentIndex; // For visual representation of the current index
  int? compareIndex; // For the index being compared during sorting
  bool sorting = false; // State for sort animation
  int? sortedIndex; // Tracks the sorted part of the array

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
                onPressed: sorting ? null : _startBubbleSort,
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
      compareIndex = null;
      sortedIndex = null;
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      currentIndex = null;
      compareIndex = null;
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
              : (index == compareIndex)
                  ? Colors.orange // Highlight the element being compared
                  : (index >= (sortedIndex ?? array.length))
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

  // Perform bubble sort with animation
  Future<void> _startBubbleSort() async {
    setState(() {
      sorting = true;
    });

    for (int i = 0; i < array.length - 1; i++) {
      for (int j = 0; j < array.length - i - 1; j++) {
        setState(() {
          currentIndex = j;
          compareIndex = j + 1;
        });

        await Future.delayed(Duration(milliseconds: 500)); // Delay for animation

        if (array[j] > array[j + 1]) {
          setState(() {
            // Swap if elements are out of order
            int temp = array[j];
            array[j] = array[j + 1];
            array[j + 1] = temp;
          });
        }
      }

      setState(() {
        sortedIndex = array.length - i - 1; // Mark sorted part
        currentIndex = null;
      });
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