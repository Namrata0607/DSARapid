import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:url_launcher/url_launcher.dart';

class HashingNotes extends StatelessWidget {
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
      const url = 'assets/notes/array.pdf';  // Relative path to the PDF
      await launch(url);  // This opens the PDF in a new browser tab
    });

    return Scaffold(
      appBar:appBack(context),
      body: Center(
        child: Text('Opening PDF...'),
      ),
    );
  }
}


class HashTable extends StatefulWidget {
  @override
  _HashTableVisualizerState createState() => _HashTableVisualizerState();
}

class _HashTableVisualizerState extends State<HashTable> {
  List<List<int>> table = List.generate(10, (_) => []); // Hash table of size 10
  int? highlightedIndex;  // This will highlight the index being operated on
  int? currentKey;
  String currentAlgorithm = "";
  String currentOutput = "";
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBack(context),
        body: Column(
          children: [
            // Display Algorithm and Output
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  // Left side for Algorithm and Output
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.grey.shade300,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          // Algorithm Display
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Algorithm', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple)),
                                  Divider(),
                                  Expanded(child: SingleChildScrollView(child: Text(currentAlgorithm))),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Output Display
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Step-by-Step Output', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple)),
                                  Divider(),
                                  Expanded(child: SingleChildScrollView(child: Text(currentOutput))),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  // Right side for Hash Table Visualization
                  Expanded(
                    flex: 2,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Hash Table Visualizer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple)),
                          Divider(),
                          Expanded(
                            child: Center(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(children: _buildHashTable()),
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
            // Bottom Container for Buttons
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              color: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(onPressed: _createDefaultTable, child: Text('Create Default Table')),
                  ElevatedButton(onPressed: _clearTable, child: Text('Clear Table')),
                  ElevatedButton(onPressed: () => _showInsertDialog(context), child: Text('Insert')),
                  ElevatedButton(onPressed: searching ? null : () => _showFindDialog(context), child: Text('Search')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to create default hash table
  void _createDefaultTable() {
    setState(() {
      table = List.generate(10, (_) => []); // Reset the table with 10 empty lists
      currentAlgorithm = "1. Compute hash using key % table size\n2. Insert key at the index.\n3. Handle collisions if necessary (Separate Chaining).";
      currentOutput = "Default hash table created.";
      highlightedIndex = null; // Reset highlight
    });
  }

  // Method to clear the hash table
  void _clearTable() {
    setState(() {
      table = List.generate(10, (_) => []);
      currentOutput = "Hash table cleared.";
      highlightedIndex = null; // Reset highlight
    });
  }

  // Method to show insert dialog and insert a value into the hash table
  Future<void> _showInsertDialog(BuildContext context) async {
    int? key = await _showInputDialog(context, 'Insert Key');
    if (key != null) {
      int index = key % table.length;
      setState(() {
        highlightedIndex = index; // Highlight the current index being inserted
        table[index].add(key);
        currentOutput = "Inserted key $key at index $index.";
      });
      await Future.delayed(Duration(seconds: 2)); // Keep highlight for 2 seconds
      setState(() {
        highlightedIndex = null; // Reset highlight after insertion
      });
    }
  }

  // Method to visualize hash table
  List<Widget> _buildHashTable() {
    return List<Widget>.generate(table.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Text('Index $index'),
            Container(
              height: 100,
              width: 60,
              color: highlightedIndex == index ? Colors.green.shade300 : Colors.purple.shade100,
              child: Column(
                children: List.generate(table[index].length, (i) {
                  return Text(table[index][i].toString());
                }),
              ),
            ),
          ],
        ),
      );
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
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text('Cancel')),
            TextButton(
              onPressed: () {
                final value = int.tryParse(controller.text);
                Navigator.of(context).pop(value);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Method to handle searching in the hash table
  Future<void> _showFindDialog(BuildContext context) async {
    int? key = await _showInputDialog(context, 'Find Key');
    if (key != null) {
      int index = key % table.length;
      setState(() {
        highlightedIndex = index; // Highlight the index being searched
      });
      await Future.delayed(Duration(seconds: 2)); // Keep highlight for 2 seconds

      if (table[index].contains(key)) {
        setState(() {
          currentOutput = "Key $key found at index $index.";
        });
      } else {
        setState(() {
          currentOutput = "Key $key not found in the hash table.";
        });
      }

      setState(() {
        highlightedIndex = null; // Reset highlight after search
      });
    }
  }
}

//Test
 
final List<Question> HashingQuestions = [
  Question(
    questionText: 'What is hashing in data structures?',
    options: [
      'A technique for finding the shortest path in a graph',
      'A technique to map data to a fixed size value',
      'A method to search through a linked list',
      'A process to sort data using comparisons'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the main purpose of a hash function?',
    options: [
      'To generate a unique identifier for each element in a set',
      'To compress data for storage',
      'To map keys to positions in a hash table',
      'To find the shortest path between nodes'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is a collision in hashing?',
    options: [
      'When two different keys hash to the same index',
      'When two hash functions are applied to the same key',
      'When all keys map to the same index',
      'When the hash table becomes full'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'Which of the following is a desirable property of a good hash function?',
    options: [
      'It should map similar keys to the same index',
      'It should generate the same output for all inputs',
      'It should minimize collisions',
      'It should run in quadratic time complexity'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the time complexity of inserting a key into a hash table (without collisions)?',
    options: [
      'O(n)',
      'O(1)',
      'O(log n)',
      'O(n^2)'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following techniques is used to resolve collisions in hashing?',
    options: [
      'Binary Search',
      'Chaining',
      'Recursion',
      'Merge Sort'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is open addressing in the context of hashing?',
    options: [
      'A collision resolution technique where all elements are stored in linked lists',
      'A method for accessing elements directly by key',
      'A collision resolution technique where collisions are resolved within the hash table by probing',
      'A method to store elements based on priority'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is a hash table?',
    options: [
      'A dynamic data structure used for efficient data retrieval',
      'A table used for sorting data in decreasing order',
      'A data structure that maps keys to values using a hash function',
      'A data structure that stores elements in a tree-like form'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following is not a collision resolution technique?',
    options: [
      'Chaining',
      'Linear Probing',
      'Quadratic Probing',
      'Binary Search'
    ],
    correctAnswerIndex: 3,
  ),
  Question(
    questionText: 'What is the primary disadvantage of using chaining for collision resolution?',
    options: [
      'It uses additional memory for pointers',
      'It cannot handle large hash tables',
      'It is slower than linear probing',
      'It is not a valid collision resolution technique'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is linear probing in open addressing?',
    options: [
      'A technique to hash all keys to the first available slot',
      'A technique to hash all keys into linked lists',
      'A technique where the next empty slot is found by checking subsequent positions in the hash table',
      'A method to hash similar keys to the same position'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'In quadratic probing, how is the next slot calculated when a collision occurs?',
    options: [
      'By jumping one slot at a time',
      'By adding the square of the probe number to the hash value',
      'By moving in a random direction',
      'By dividing the hash value by the number of keys'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is double hashing?',
    options: [
      'A collision resolution technique that uses a second hash function to determine the probe sequence',
      'A method of hashing a key twice for better performance',
      'A hashing technique that requires two hash tables',
      'A method where two keys are hashed together'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the load factor in a hash table?',
    options: [
      'The ratio of the number of elements to the total number of slots',
      'The number of elements hashed in one operation',
      'The maximum number of collisions allowed',
      'The total memory usage by the hash table'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What happens when the load factor of a hash table exceeds 1?',
    options: [
      'The hash table becomes full and cannot accept more elements',
      'The performance of the hash table improves',
      'The hash table must be rehashed or resized',
      'The hash function must be recalculated'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'Which of the following hash functions is most effective for uniformly distributing keys?',
    options: [
      'Multiplicative Hashing',
      'Division Hashing',
      'Mid-Square Hashing',
      'Modulo Hashing'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the purpose of rehashing in a hash table?',
    options: [
      'To resolve collisions by using a different hash function',
      'To recalculate hash values for all keys to a larger table',
      'To move keys that are no longer needed',
      'To optimize the search operation'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following situations would require rehashing?',
    options: [
      'When the load factor becomes too low',
      'When the load factor exceeds a certain threshold',
      'When the number of collisions exceeds the number of keys',
      'When the hash function does not work properly'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is a perfect hash function?',
    options: [
      'A hash function that minimizes the number of collisions',
      'A hash function that maps each key to a unique index with no collisions',
      'A hash function that only works on sorted data',
      'A hash function that always maps keys to the same index'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following is an advantage of hashing over binary search trees?',
    options: [
      'Hashing provides faster access on average',
      'Hashing guarantees balanced trees',
      'Hashing requires less space',
      'Hashing is always more efficient in space and time'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the time complexity of searching for an element in a hash table with proper collision handling?',
    options: [
      'O(log n)',
      'O(n)',
      'O(1)',
      'O(n^2)'
    ],
    correctAnswerIndex: 2,
  ),
  Question(
    questionText: 'What is the primary disadvantage of using open addressing?',
    options: [
      'It requires linked lists for each entry',
      'It suffers from clustering of keys',
      'It requires too much memory for small datasets',
      'It increases the complexity of hash function computation'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is the difference between chaining and open addressing?',
    options: [
      'Chaining stores multiple elements in the same slot using a list, while open addressing searches for the next available slot',
      'Chaining uses a single hash function while open addressing uses two',
      'Open addressing is used for large datasets while chaining is for small datasets',
      'Chaining results in fewer collisions than open addressing'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'How can clustering be reduced in open addressing?',
    options: [
      'By using double hashing',
      'By reducing the size of the hash table',
      'By using binary search instead of hashing',
      'By increasing the load factor'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is primary clustering?',
    options: [
      'When multiple elements hash to the same index and subsequent probes form a contiguous block',
      'When all hash values cluster around a particular key',
      'When too many keys hash to the same linked list in chaining',
      'When the hash function becomes too complex'
    ],
    correctAnswerIndex: 0,
  ),
    Question(
    questionText: 'Which hash function method involves multiplying the key by a constant and taking the fractional part?',
    options: [
      'Division Method',
      'Multiplicative Hashing',
      'Mid-Square Method',
      'Quadratic Probing'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What is a hash code?',
    options: [
      'A code used to identify the location of an element in a hash table',
      'A unique representation of an object’s data in a hash function',
      'A code that describes how data is compressed',
      'A method of encrypting data'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'Which of the following statements is true about a hash table?',
    options: [
      'All keys must be unique, but values can be duplicated',
      'Values must be unique, but keys can be duplicated',
      'Both keys and values can be duplicated',
      'Neither keys nor values can be duplicated'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'What is the typical method to handle dynamic resizing of a hash table?',
    options: [
      'Doubling the size of the table and rehashing all entries',
      'Reducing the size of the table by half',
      'Creating a new hash table with the same size',
      'Only adding new keys when space is available'
    ],
    correctAnswerIndex: 0,
  ),
  Question(
    questionText: 'When is the best time to use hashing?',
    options: [
      'When the data set is sorted',
      'When fast access and retrieval of data is required',
      'When the data set is small',
      'When there is a strict ordering of keys'
    ],
    correctAnswerIndex: 1,
  ),
  Question(
    questionText: 'What would happen if a hash table is not resized when the load factor exceeds 1?',
    options: [
      'The performance remains optimal',
      'The hash table will start losing elements',
      'The hash table will become inefficient with increased collisions',
      'All of the above'
    ],
    correctAnswerIndex: 3,
  ),
];

class HashingQuiz extends StatelessWidget {
  @override
 Widget build(BuildContext context) {
    List<Question> randomQuestions = getRandomQuestions(HashingQuestions);
    String testId = '16_hashing'; // Example test_id, modify as needed
    return QuizUI(quizQuestions:randomQuestions, testId: testId ); // Use the common UI
  }
}