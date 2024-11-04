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

class Updateprofile extends StatefulWidget {
  const Updateprofile({Key? key}) : super(key: key);

  @override
  State<Updateprofile> createState() => _UpdateprofileState();
}

class _UpdateprofileState extends State<Updateprofile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Update Profile'),
          backgroundColor: Colors.purple,
        ),
        body: Center(child: Text("Update Profile")),
      ),
    );
  }
}
