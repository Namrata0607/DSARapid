import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';



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