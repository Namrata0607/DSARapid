import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsa_rapid/User/Dashboard.dart';
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
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
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
                          DataColumn(label: Text('Test id', style: TextStyle(fontWeight: FontWeight.bold))),
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

final List<Question> arrayQuestions = [
  Question(
    questionText: 'What is an array?',
    options: ['A data structure', 'A function', 'An operator', 'A loop'],
    correctAnswerIndex: 0,
  ),//1
  Question(
    questionText: 'How is an array accessed?',
    options: ['By index', 'By name', 'By function', 'By operator'],
    correctAnswerIndex: 0,
  ),//2
  Question(
    questionText: 'What is the time complexity of accessing an element in an array by index?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
    correctAnswerIndex: 0,
  ),//3
  Question(
    questionText: 'What is the disadvantage of arrays?',
    options: [
      'Fixed size',
      'Efficient memory usage',
      'Ease of access by index',
      'Faster than other data structures'
    ],
    correctAnswerIndex: 0,
  ),//4

  Question(
     questionText: 'What is the index of the first element in an array?',
    options: ['0', '1', '2', 'Depends on the language'],
    correctAnswerIndex: 0,
  ),//5

   Question(
    questionText: 'Which of the following is the correct way to declare an array in C?',
     options: ['int arr(10);', 'int arr[10];', 'arr{10};', 'array int arr[10];'],
     correctAnswerIndex: 1,
  ),//6

   Question(
    questionText: 'If int arr[5] = {10, 20, 30, 40, 50}; what is the value of arr[3]?',
     options: ['10', '20', '40', '50'],
     correctAnswerIndex: 2,
  ),//7

  Question(
    questionText: 'What is an array?',
    options: ['A collection of variables of different types stored at contiguous memory locations',
     ' A collection of variables of the same type stored at contiguous memory locations', 
     'A collection of variables of the same type stored randomly in memory', 
     'A collection of variables of different types stored randomly in memory'],
    correctAnswerIndex: 2,
  ),//8

  Question(
    questionText: 'How do you access the first element of an array in C/C++?',
    options: ['arr[1]', 'arr[0]', 'arr(1)', 'arr[2]'],
    correctAnswerIndex: 1,
  ),//9

  Question(
    questionText: 'Which of the following operations is not possible with arrays directly?',
    options: ['Insertion of an element at the beginning', 'Accessing an element at a specific index', 'Traversing the array', 'Sorting the array'],
    correctAnswerIndex: 0,
  ),//10

   Question(
    questionText: 'If int arr[4] = {11, 22, 30, 45}; what is the value of arr[3]?',
     options: ['11', '22', '30', '45'],
     correctAnswerIndex: 3,
  ),//11
   Question(
    questionText: 'Which of the following allows dynamic resizing in arrays?',
    options: ['Dynamic arrays', 'Static arrays', 'Both', 'None'],
    correctAnswerIndex: 0,
  ),//12

   Question(
    questionText: 'What is a multidimensional array?',
    options: [
      'Array with more than one dimension',
      'Array with one dimension',
      'Array without elements',
      'Array that cannot be resized'
    ],
    correctAnswerIndex: 0,
  ),//13

   Question(
     questionText: 'What is the time complexity of inserting an element at the end of an array?',
    options: ['O(1)', 'O(n)', 'O(log n)', 'O(n^2)'],
    correctAnswerIndex: 0,
  ),//14

   Question(
   questionText: 'How do you declare an array in most programming languages?',
    options: ['int[] arr;', 'int arr[];', 'arr[] int;', 'array of int'],
    correctAnswerIndex: 0,
  ),//15

   Question(
     questionText: 'What does it mean when an array is "zero-indexed"?',
    options: [
      'The first element is at index 0',
      'The array starts with a zero',
      'Array cannot hold any values',
      'Array contains only one element'
    ],
    correctAnswerIndex: 0,
  ),//16

   Question(
    questionText: 'If int arr[3] = {78,98,20}; what is the value of arr[1]?',
     options: ['78', '98', '20'],
     correctAnswerIndex: 2,
  ),//17

   Question(
     questionText: 'Which of the following is not a valid way to iterate through an array?',
    options: ['For loop', 'While loop', 'Do-while loop', 'Switch statement'],
    correctAnswerIndex: 3,
  ),//18

   Question(
    questionText: 'What is the time complexity of accessing an element in a 2D array?',
    options: ['O(1)', 'O(n)', 'O(n^2)', 'O(log n)'],
    correctAnswerIndex: 0,
  ),//19

   Question(
    questionText: 'Which of the following is not a valid way to iterate through an array?',
    options: ['For loop', 'While loop', 'Do-while loop', 'Switch statement'],
    correctAnswerIndex: 3,
  ),//20

   Question(
    questionText: 'How can you copy the contents of one array to another?',
    options: ['By loop', 'By function', 'By reference', 'All of the above'],
    correctAnswerIndex: 3,
  ),//21

   Question(
    questionText: 'If int arr[6] = {78,98,20,33,22,11}; what is the value of arr[5]?',
     options: ['78', '98', '20','11'],
     correctAnswerIndex: 3,
  ),//22

   Question(
    questionText: 'What is a jagged array?',
    options: [
      'An array with rows of different lengths',
      'An array with rows of the same length',
      'A type of stack',
      'A type of queue'
    ],
    correctAnswerIndex: 0,
  ),//23

   Question(
    questionText: 'How do you find the length of an array in most programming languages?',
    options: [ 'array.size', 'array.length','length(array)', 'size(array)'],
    correctAnswerIndex: 1,
  ),//24

   Question(
   questionText: 'What happens when you access an index that is out of bounds in an array?',
    options: [
      'An error occurs',
      'It returns the last element',
      'It returns the first element',
      'It returns null'
    ],
    correctAnswerIndex: 0,
  ),//25

  Question(
    questionText: 'Which of the following is a valid array operation?',
    options: ['Insertion', 'Deletion', 'Traversal', 'All of the above'],
    correctAnswerIndex: 3,
  ),//26

  Question(
    questionText: 'If int arr[5] = {1, 2, 3, 4, 5}; what will be the result of arr[5]?',
    options: ['5', '0', 'Runtime error or undefined behavior', 'Index out of bounds error'],
    correctAnswerIndex: 2,
  ),//27

  Question(
    questionText: 'Which of the following is not a feature of arrays?',
    options: [' Fixed size', 'Contiguous memory allocation', 'Store elements of different data types', ' Access time is O(1) by index'],
    correctAnswerIndex: 2,
  ),//28

  Question(
    questionText: 'Which of the following is a limitation of arrays?',
    options: ['Arrays allow access to elements by index', 'Arrays can store multiple values in one variable', 'Arrays have a fixed size once created', 'Arrays allow traversal of elements'],
    correctAnswerIndex: 2,
  ),//29

  Question(
    questionText: 'If int arr[4] = {1, 3, 4, 5}; what will be the result of arr[4]?',
    options:  ['5', '4', 'Runtime error or undefined behavior', 'Index out of bounds error'],
    correctAnswerIndex: 2,
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
        List<dynamic>? testIdArray = data['test_id'];
        if (testIdArray != null && testIdArray.contains("1") && testIdArray.contains("2") && testIdArray.contains("3")) {
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
            return QuizUI(quizQuestions: arrayQuestions, testId: testId);
          } else {
            return Home();
          }
        } else {
          return Center(child: Text('Error loading data'));
        }
      },
    );
  }
}