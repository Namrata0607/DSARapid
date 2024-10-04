import 'package:flutter/material.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:dsa_rapid/Dashboard.dart';

// void main() {
//   runApp(BinarySearchVisualizerApp());
// }

class BinarySearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary Search Visualizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BinarySearchScreen(),
    );
  }
}

class BinarySearchScreen extends StatefulWidget {
  @override
  _BinarySearchScreenState createState() => _BinarySearchScreenState();
}

class _BinarySearchScreenState extends State<BinarySearchScreen> {
  List<int> array = []; // Initially empty array
  int? left, right; // For visual representation of search bounds
  bool searching = false; // State for search animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Binary Search Visualizer'),
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
                onPressed: searching ? null : () => _showFindIndexDialog(context),
                child: Text('Search'),
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
      array = [10, 20, 30, 40, 50,60,70,80,90,100]; // Default array
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      left = null;
      right = null;
    });
  }

  // Show dialog to input value for inserting into the array
  Future<void> _showInsertDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Insert Value');
    if (value != null) {
      setState(() {
        array.add(value); // Add element to array
        array.sort(); // Sort the array after insertion for binary search
      });
    }
  }

  // Show dialog to find the index of an element using binary search
  Future<void> _showFindIndexDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Find Index of Value');
    if (value != null) {
      await _binarySearch(value); // Perform binary search with animation
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
          color: (index == left || index == right)
              ? Colors.red // Highlight search bounds
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

  // Perform binary search with animation
  Future<void> _binarySearch(int value) async {
    searching = true;
    left = 0;
    right = array.length - 1;

    while (left! <= right!) {
      setState(() {});
      await Future.delayed(Duration(seconds: 2)); // Pause for visual effect

      int mid = left! + (right! - left!) ~/ 2;
      if (array[mid] == value) {
        setState(() {
          left = mid; // Highlight found index
          right = mid; // Highlight found index
        });
        await Future.delayed(Duration(seconds: 1));
        break;
      } else if (array[mid] < value) {
        left = mid + 1;
      } else {
        right = mid - 1;
      }
      setState(() {
        // Optional: Add a small visual effect (e.g., change mid bar color momentarily)
      });
    }

    // Show result in a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(value.toString() + ' found at index: ${left!}'),
      ),
    );

    searching = false;
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