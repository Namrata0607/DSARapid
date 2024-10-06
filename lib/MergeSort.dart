import 'package:flutter/material.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:dsa_rapid/Dashboard.dart';



class MergeSort extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Merge Sort Visualizer',
      debugShowCheckedModeBanner: false, // Disable the debug banner
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
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
  int? leftIndex; // For visual representation of left index
  int? rightIndex; // For visual representation of right index
  bool sorting = false; // State for sort animation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mtext(),
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
                onPressed: sorting ? null : () => _startMergeSort(0, array.length - 1),
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
      leftIndex = null;
      rightIndex = null;
    });
  }

  // Clear the array
  void _clearArray() {
    setState(() {
      array = []; // Clear the array
      leftIndex = null;
      rightIndex = null;
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
          color: (index == leftIndex || index == rightIndex)
              ? Colors.red // Highlight current merge indices
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
  Future<void> _startMergeSort(int left, int right) async {
    setState(() {
      sorting = true;
    });

    await _mergeSort(left, right);

    setState(() {
      sorting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Array sorted successfully!'),
      ),
    );
  }

  // Merge sort algorithm
  Future<void> _mergeSort(int left, int right) async {
    if (left < right) {
      int mid = (left + right) ~/ 2;

      await _mergeSort(left, mid); // Sort first half
      await _mergeSort(mid + 1, right); // Sort second half
      await _merge(left, mid, right); // Merge the sorted halves
    }
  }

  // Merge two subarrays with animation
  Future<void> _merge(int left, int mid, int right) async {
    List<int> leftArray = List.from(array.sublist(left, mid + 1));
    List<int> rightArray = List.from(array.sublist(mid + 1, right + 1));

    int i = 0, j = 0, k = left;

    while (i < leftArray.length && j < rightArray.length) {
      setState(() {
        leftIndex = left + i;
        rightIndex = mid + 1 + j;
      });

      await Future.delayed(Duration(milliseconds: 500)); // Animation delay

      if (leftArray[i] <= rightArray[j]) {
        setState(() {
          array[k] = leftArray[i];
        });
        i++;
      } else {
        setState(() {
          array[k] = rightArray[j];
        });
        j++;
      }
      k++;
    }

    // Copy remaining elements of leftArray
    while (i < leftArray.length) {
      setState(() {
        leftIndex = left + i;
        rightIndex = null; // No comparison
      });

      await Future.delayed(Duration(milliseconds: 500));

      setState(() {
        array[k] = leftArray[i];
      });
      i++;
      k++;
    }

    // Copy remaining elements of rightArray
    while (j < rightArray.length) {
      setState(() {
        leftIndex = null; // No comparison
        rightIndex = mid + 1 + j;
      });

      await Future.delayed(Duration(milliseconds: 500));

      setState(() {
        array[k] = rightArray[j];
      });
      j++;
      k++;
    }

    setState(() {
      leftIndex = null;
      rightIndex = null;
    });
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