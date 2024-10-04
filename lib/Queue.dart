import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';


class QueueVisualizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Queue Visualizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QueueScreen(),
    );
  }
}

class QueueScreen extends StatefulWidget {
  @override
  _QueueScreenState createState() => _QueueScreenState();
}

class _QueueScreenState extends State<QueueScreen> {
  List<int> queue = []; // Queue to hold elements
  bool isEmpty = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queue Visualizer'),
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
                  children: queue.isEmpty
                      ? [
                          Text(
                            'Queue is empty',
                            style: TextStyle(fontSize: 18, color: Colors.red),
                          )
                        ]
                      : _buildQueueBars(),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: _createDefaultQueue, // Create Default Button
                child: Text('Create Default'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: _clearQueue, // Clear Button
                child: Text('Clear'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: () => _showEnqueueDialog(context), // Enqueue Button
                child: Text('Enqueue'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: queue.isEmpty ? null : _dequeueElement, // Dequeue Button
                child: Text('Dequeue'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
              ),
              ElevatedButton(
                onPressed: queue.isEmpty ? null : _peekElement, // Peek Button
                child: Text('Peek'),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.purple),
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

  // Build the visual representation of the queue
  List<Widget> _buildQueueBars() {
    return List<Widget>.generate(queue.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: AnimatedContainer(
          height: 100, // Fixed height for all bars
          width: 60,
          duration: Duration(milliseconds: 300),
          color: Colors.purple, // No top element highlight for queue
          alignment: Alignment.bottomCenter,
          child: Center(
            child: Text(
              queue[index].toString(),
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

  // Enqueue element into the queue
  Future<void> _showEnqueueDialog(BuildContext context) async {
    int? value = await _showInputDialog(context, 'Enqueue Value');
    if (value != null) {
      setState(() {
        queue.add(value); // Add element to the end of the queue
      });
    }
  }

  // Dequeue element from the queue
  void _dequeueElement() {
    setState(() {
      if (queue.isNotEmpty) {
        queue.removeAt(0); // Remove front element from the queue
      }
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Front element dequeued'),
      ),
    );
  }

  // Peek at the front element of the queue
  void _peekElement() {
    if (queue.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Front element: ${queue.first}'),
        ),
      );
    }
  }

  // Create a default queue with some values
  void _createDefaultQueue() {
    setState(() {
      queue = [10, 20, 30, 40, 50]; // Default queue values
    });
  }

  // Clear the queue
  void _clearQueue() {
    setState(() {
      queue = []; // Clear the queue
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