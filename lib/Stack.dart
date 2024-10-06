import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';

class StackVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stack Visualizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StackScreen(),
    );
  }
}

class StackScreen extends StatefulWidget {
  @override
  _StackScreenState createState() => _StackScreenState();
}

class _StackScreenState extends State<StackScreen> {  
  List<int> stack = []; // Stack to hold elements
  int? topIndex; // For visual representation of the top of the stack
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stack Visualizer'),
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
                  children: stack.isEmpty
                      ? [
                          Text(
                            'Stack is empty',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          )
                        ]
                      : _buildStackBars(),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _createDefaultStack, // Create Default Button
                child: Text('Create Default'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: _clearStack, // Clear Button
                child: Text('Clear'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () => _showPushDialog(context), // Push Button
                child: Text('Push'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: stack.isEmpty ? null : _popElement, // Pop Button
                child: Text('Pop'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: stack.isEmpty ? null : _peekElement, // Peek Button
                child: Text('Peek'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // Build the visual representation of the stack
  List<Widget> _buildStackBars() {
    return List<Widget>.generate(stack.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: AnimatedContainer(
          height: 100, // Fixed height for all bars
          width: 60,
          duration: Duration(milliseconds: 300),
          color: (index == topIndex) ? Colors.red : Colors.purple, // Top element highlighted
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Text(
              stack[index].toString(),
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

  // Push element onto the stack
  Future<void> _showPushDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Push Value');
    if (value != null) {
      setState(() {
        stack.add(value); // Add element to stack
        topIndex = stack.length - 1; // Update top index
      });
    }
  }

  // Pop element from the stack
  void _popElement() {
    setState(() {
      if (stack.isNotEmpty) {
        stack.removeLast(); // Remove top element
        topIndex = stack.isNotEmpty ? stack.length - 1 : null; // Update top index
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Top element popped'),
      ),
    );
  }

  // Peek at the top element of the stack
  void _peekElement() {
    if (stack.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Top element: ${stack.last}'),
        ),
      );
    }
  }

  // Create a default stack with some values
  void _createDefaultStack() {
    setState(() {
      stack = [10, 20, 30, 40, 50]; // Default stack values
      topIndex = stack.length - 1; // Set top index
    });
  }

  // Clear the stack
  void _clearStack() {
    setState(() {
      stack = []; // Clear the stack
      topIndex = null; // Reset top index
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