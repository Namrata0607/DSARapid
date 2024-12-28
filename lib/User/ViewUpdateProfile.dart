import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Viewprofile extends StatefulWidget {
  @override
  State<Viewprofile> createState() => _ViewprofileState();
}

class _ViewprofileState extends State<Viewprofile> {
  String? userId;
  DocumentReference? testDocument;

  @override
  void initState() {
    super.initState();
    // Get the current user ID
    userId = FirebaseAuth.instance.currentUser?.uid;

    if (userId != null) {
      testDocument = FirebaseFirestore.instance.collection('user_db').doc(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: appBack(context),
        body: userId == null || testDocument == null
            ? Center(child: Text('User not logged in'))
            : StreamBuilder<DocumentSnapshot>(
                stream: testDocument!.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return Center(child: Text('No profile data found.'));
                  }

                //  // Extract arrays for test data from Firestore
                  final data = snapshot.data!.data() as Map<String, dynamic>?;
                  // final List<dynamic> testnames = data?['topic_name'] ?? []; 
                  final List<dynamic> testIds = data?['test_id'] ?? [];
                  final List<dynamic> marks = data?['marks'] ?? [];
                  final List<dynamic> times = data?['time'] ?? [];

                  // Extract data from Firestore
                  // final data = snapshot.data!.data() as Map<String, dynamic>?;
                  // final List<Map<String, dynamic>> testData = data?['user_db'] != null
                  //     ? List<Map<String, dynamic>>.from(data!['user_db'])
                  //     : [];

                                        // Ensure all arrays have the same length before mapping to rows
                  final int rowCount = testIds.length;

                  return Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        height: 600,
                        width: 700,
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 244, 224, 255),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: DataTable(
                           columns: const [
                            DataColumn(label: Text('Topic Names', style: TextStyle(fontWeight: FontWeight.bold))),
                            // DataColumn(label: Text('Test Id', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Marks', style: TextStyle(fontWeight: FontWeight.bold))),
                            DataColumn(label: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
                          ],
                          rows: List<DataRow>.generate(rowCount, (index) {
                            return DataRow(cells: [
                              DataCell(Text(testIds[index]?.toString() ?? 'N/A')),
                              DataCell(Text(marks[index]?.toString() ?? 'N/A')),
                              DataCell(Text(times[index]?.toString() ?? 'N/A')),
                            ]);
                          }),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

// class Updateprofile extends StatefulWidget {
//   const Updateprofile({Key? key}) : super(key: key);

//   @override
//   State<Updateprofile> createState() => _UpdateprofileState();
// }

// class _UpdateprofileState extends State<Updateprofile> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: appBack(context),
//         body: Center(child: Text("Update Profile")),
//       ),
//     );
//   }
// }

final List<Question> finaltest = [
  Question(
    questionText: 'What is a linked list?',
    options: ['A linear data structure with nodes', 'A dynamic array', 'A fixed-size array', 'A stack'],
    correctAnswerIndex: 0,
  ),//1
  
  Question(
    questionText: 'Which data structure uses FIFO (First In, First Out) principle?',
    options: ['Stack', 'Queue', 'Array', 'Binary Tree'],
    correctAnswerIndex: 1,
  ),//2

  Question(
    questionText: 'What is a stack?',
    options: ['A collection with LIFO principle', 'A dynamic array', 'A binary tree', 'A queue'],
    correctAnswerIndex: 0,
  ),//3

  Question(
    questionText: 'What is the time complexity of searching in a binary search tree (average case)?',
    options: ['O(log n)', 'O(n)', 'O(n log n)', 'O(n^2)'],
    correctAnswerIndex: 0,
  ),//4

  Question(
    questionText: 'In which data structure are elements added and removed from the same end?',
    options: ['Queue', 'Stack', 'Array', 'Heap'],
    correctAnswerIndex: 1,
  ),//5

  Question(
    questionText: 'What is the height of an AVL tree with 7 nodes?',
    options: ['2', '3', '4', '5'],
    correctAnswerIndex: 1,
  ),//6

  Question(
    questionText: 'What is a heap?',
    options: ['A tree-based structure', 'A graph', 'A queue', 'A list'],
    correctAnswerIndex: 0,
  ),//7

  Question(
    questionText: 'What is the time complexity of inserting an element in a max-heap?',
    options: ['O(log n)', 'O(n)', 'O(1)', 'O(n log n)'],
    correctAnswerIndex: 0,
  ),//8

  Question(
    questionText: 'What is a binary tree?',
    options: ['A tree with at most two children per node', 'A tree with one child per node', 'A cyclic graph', 'A linear list'],
    correctAnswerIndex: 0,
  ),//9

  Question(
    questionText: 'What is the maximum number of nodes in a binary tree of height h?',
    options: ['2^h - 1', '2h', 'h^2', 'h'],
    correctAnswerIndex: 0,
  ),//10

  Question(
    questionText: 'Which data structure is commonly used for implementing recursion?',
    options: ['Stack', 'Queue', 'Array', 'Graph'],
    correctAnswerIndex: 0,
  ),//11

  Question(
    questionText: 'What is the best-case time complexity of quicksort?',
    options: ['O(n log n)', 'O(n)', 'O(n^2)', 'O(log n)'],
    correctAnswerIndex: 0,
  ),//12

  Question(
    questionText: 'Which data structure can be used to detect cycles in a graph?',
    options: ['Stack', 'Queue', 'Heap', 'DFS with parent tracking'],
    correctAnswerIndex: 3,
  ),//13

  Question(
    questionText: 'Which sorting algorithm has the worst-case time complexity of O(n^2)?',
    options: ['Merge sort', 'Quick sort', 'Bubble sort', 'Heap sort'],
    correctAnswerIndex: 2,
  ),//14

  Question(
    questionText: 'What is the time complexity of inserting a node in a linked list at the beginning?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
    correctAnswerIndex: 0,
  ),//15

  Question(
    questionText: 'Which data structure is used for implementing priority queues?',
    options: ['Heap', 'Stack', 'Linked List', 'Array'],
    correctAnswerIndex: 0,
  ),//16

  Question(
    questionText: 'What is the difference between a singly and a doubly linked list?',
    options: ['Singly linked lists have one pointer per node', 'Doubly linked lists have two pointers per node', 'Both are types of arrays', 'Both A and B'],
    correctAnswerIndex: 3,
  ),//17

  Question(
    questionText: 'Which traversal method is used in depth-first search?',
    options: ['In-order', 'Pre-order', 'Level-order', 'Reverse level-order'],
    correctAnswerIndex: 1,
  ),//18

  Question(
    questionText: 'What does "enqueue" mean in terms of a queue?',
    options: ['Adding an element', 'Removing an element', 'Traversing elements', 'Sorting elements'],
    correctAnswerIndex: 0,
  ),//19

  Question(
    questionText: 'In which data structure are elements arranged in a hierarchy?',
    options: ['Array', 'Tree', 'Queue', 'Linked List'],
    correctAnswerIndex: 1,
  ),//20

  Question(
    questionText: 'What is the main property of a hash table?',
    options: ['Constant time complexity for search', 'Sorted elements', 'Requires large memory', 'Hierarchical structure'],
    correctAnswerIndex: 0,
  ),//21

  Question(
    questionText: 'What is the primary use of a graph data structure?',
    options: ['Model relationships between entities', 'Sort elements', 'Store data in sequence', 'Manage FIFO tasks'],
    correctAnswerIndex: 0,
  ),//22

  Question(
    questionText: 'Which of the following sorting algorithms is stable?',
    options: ['Merge sort', 'Quick sort', 'Heap sort', 'Selection sort'],
    correctAnswerIndex: 0,
  ),//23

  Question(
    questionText: 'What is the purpose of breadth-first search (BFS)?',
    options: ['Explore nodes level by level', 'Explore nodes depth by depth', 'Sort nodes', 'Create a tree'],
    correctAnswerIndex: 0,
  ),//24

  Question(
    questionText: 'Which data structure is used for implementing depth-first search (DFS)?',
    options: ['Stack', 'Queue', 'Array', 'Tree'],
    correctAnswerIndex: 0,
  ),//25

  Question(
    questionText: 'What is the primary disadvantage of a hash table?',
    options: ['Possible collisions', 'Slow access time', 'Memory overhead', 'Fixed size'],
    correctAnswerIndex: 0,
  ),//26

  Question(
    questionText: 'What is the time complexity of removing an element from the beginning of a linked list?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
    correctAnswerIndex: 0,
  ),//27

  Question(
    questionText: 'In a binary search tree, what is the left child of a node generally less than?',
    options: ['Parent node', 'Root node', 'Right child', 'All nodes'],
    correctAnswerIndex: 0,
  ),//28

  Question(
    questionText: 'Which traversal method is used to retrieve a binary search tree in sorted order?',
    options: ['In-order', 'Pre-order', 'Post-order', 'Level-order'],
    correctAnswerIndex: 0,
  ),//29

  Question(
    questionText: 'What type of data structure is used to represent a weighted graph?',
    options: ['Adjacency matrix or list with weights', 'Stack', 'Queue', 'Binary tree'],
    correctAnswerIndex: 0,
  ),//30
];


class FinalQuiz extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch both flags from Firestore
  Future<Map<String, dynamic>> fetchFlags() async {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    int? flag1;
    bool flag2 = false;

    try {
      DocumentSnapshot snapshot = await _firestore.collection('user_db')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        var data = snapshot.data() as Map<String, dynamic>;
        flag1 = data['flag'] as int?;

        // Check for test_id array containing "1", "2", "3" as strings
        List<dynamic>? testTopicArray = data['test_id'];
        List<String> requiredTopics = [
        "Array",
        "Stack",
        "Queue",
        "Circular Queue",
        "Priority Queue",
        "Singly Linked List",
        "Doubly Linked List",
        "Circular Linked List",
        "Linear Search",
        "Binary Search",
        "Bubble Sort",
        "Selection Sort",
        "Insertion Sort",
        "Merge Sort",
        "Quick Sort",
        "Hashing",
        "Binary Search Tree",
        "Heap Tree",
        "AVL Tree",
        "BFS",
        "DFS"
      ];
        if (testTopicArray != null && 
        requiredTopics.every((topic) => testTopicArray.contains(topic))) {
      flag2 = true;
    }
      }
    } catch (e) {
      print('Error fetching flag values: $e');
    }

    return {'flag1': flag1, 'flag2': flag2};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchFlags(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          int? flag1 = snapshot.data?['flag1'];
          bool flag2 = snapshot.data?['flag2'] ?? false;

          if (flag1 == 0 && flag2) {
            String testId = 'final_test';
            return QuizUI(quizQuestions: finaltest, testId: testId);
          } else {
            return Leaderboard();
          }
        } else {
          return Center(child: Text('Error loading data'));
        }
      },
    );
  }
}



class Leaderboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBack(context),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('user_db').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No data found.'));
          }

          // Extract data from the snapshot
          final students = snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return Student(
              name: data['full_name'] ?? 'N/A',
              rollNumber: data['roll_no'] ?? 'N/A',
              className: data['class'] ?? 'N/A',
              division: data['division'] ?? 'N/A',
              // Convert marks to int, handling cases where it might be a string
              marks: int.tryParse(data['final'].toString()) ?? 0,
            );
          }).toList();

          // Filter students to include only those with marks greater than zero
          final filteredStudents = students.where((student) => student.marks > 0).toList();

          // Sort students by marks in descending order for ranking
          filteredStudents.sort((a, b) => b.marks.compareTo(a.marks));

          // Assign ranks based on sorted order
          for (int i = 0; i < filteredStudents.length; i++) {
            filteredStudents[i] = filteredStudents[i].copyWith(rank: i + 1);
          }

          return SingleChildScrollView(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Rank')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Roll Number')),
                DataColumn(label: Text('Class')),
                DataColumn(label: Text('Division')),
                DataColumn(label: Text('Marks')),
              ],
              rows: filteredStudents.map((student) {
                return DataRow(cells: [
                  DataCell(Text(student.rank.toString())), // Display rank
                  DataCell(Text(student.name)),
                  DataCell(Text(student.rollNumber)),
                  DataCell(Text(student.className)),
                  DataCell(Text(student.division)),
                  DataCell(Text(student.marks.toString())),
                ]);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}

class Student {
  final String name;
  final String rollNumber;
  final String className;
  final String division;
  final int marks;
  final int rank; // New field for rank

  Student({
    required this.name,
    required this.rollNumber,
    required this.className,
    required this.division,
    required this.marks,
    this.rank = 0, // Default value for rank
  });

  // Copy method to create a new Student with a different rank
  Student copyWith({int? rank}) {
    return Student(
      name: this.name,
      rollNumber: this.rollNumber,
      className: this.className,
      division: this.division,
      marks: this.marks,
      rank: rank ?? this.rank,
    );
  }
}
