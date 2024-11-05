import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class adminLogin extends StatefulWidget {
  @override
  _adminLoginState createState() => _adminLoginState();
}

class _adminLoginState extends State<adminLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // Hardcoded admin credentials
  final String adminEmail = 'admin@gmail.com';
  final String adminPassword = 'admin123';

  bool _isPasswordVisible = false; // State to toggle password visibility

  void _handleSignIn(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email == adminEmail && password == adminPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(
            adminName: 'Namrata Daphale', // Pass admin name here if needed
            adminEmail: email,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
        backgroundColor: Color.fromARGB(255, 105, 1, 161),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 20),
                child: Text(
                  'Admin Login',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 105, 1, 161),
                  ),
                ),
              ),
              SizedBox(
                height: 350,
                width: 500,
                child: Card(
                  color: Color.fromARGB(255, 244, 224, 255),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20.0),
                        TextField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                          ),
                          obscureText: !_isPasswordVisible,
                        ),
                        SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () => _handleSignIn(context),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Color.fromARGB(255, 105, 1, 161),
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
// }

class DashboardPage extends StatefulWidget {
  final String adminName;
  final String adminEmail;

  DashboardPage({required this.adminName, required this.adminEmail});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? division;
  String? rollNumber;
  List<dynamic> testIds = [];
  List<dynamic> marks = [];
  List<dynamic> times = [];

  void fetchStudentProgress() async {
    if (division != null && rollNumber != null) {
      // Fetch the document based on division and roll number
      QuerySnapshot snapshot = await _firestore.collection('user_db')
          .where('division', isEqualTo: division)
          .where('roll_no', isEqualTo: rollNumber)
          .get();

      if (snapshot.docs.isNotEmpty) {
        // Get the first matching document
        final data = snapshot.docs.first.data() as Map<String, dynamic>?;
        setState(() {
          testIds = data?['test_id'] ?? [];
          marks = data?['marks'] ?? [];
          times = data?['time'] ?? [];
        });
      } else {
        // Clear data if no document is found
        setState(() {
          testIds = [];
          marks = [];
          times = [];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mtext(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Row(
          children: [
            // Left Profile Information Container
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7),
              width: MediaQuery.of(context).size.width * 0.20, // Increased to 20% of screen width
              color: Color.fromARGB(255, 199, 167, 255),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height * 0.05), // Spacing

                          // Profile CircleAvatar
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage("assets/images/profile.png"), // Add profile image
                              radius: MediaQuery.of(context).size.width * 0.05, // Adjust radius as needed
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Spacing

                          // Admin Name
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("Name:"),
                            subtitle: Text(widget.adminName ?? 'Loading...'),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email:"),
                            subtitle: Text(widget.adminEmail ?? 'Loading...'),
                          ),
                          Divider(),
                          ListTile(
                            leading: Icon(Icons.logout),
                            title: Text('Logout'),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => adminLogin()),
                              );
                            },
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.05), // Increased final spacing
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Right Content Area
            Expanded(
              child: Container(
                color: Colors.white, // Main content background
                child: Padding(
                  padding: EdgeInsets.all(16.0), // Add some padding
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start, // Align to start
                    crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch the children to fit the width
                    children: [
                      Text(
                        'View Students Progress',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20), // Space between the title and text fields

                      // Row for TextFields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between TextFields
                        children: [
                          // Division TextField
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                division = value; // Capture division input
                              },
                              decoration: InputDecoration(
                                labelText: 'Division:', // Label for the TextField
                                border: OutlineInputBorder(), // Outline border
                              ),
                            ),
                          ),
                          SizedBox(width: 10), // Space between TextFields
                          // Roll Number TextField
                          Expanded(
                            child: TextField(
                              onChanged: (value) {
                                rollNumber = value; // Capture roll number input
                              },
                              decoration: InputDecoration(
                                labelText: 'Roll Number:', // Label for the TextField
                                border: OutlineInputBorder(), // Outline border
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Space before the button

                      // Centered Button
                      Center(
                        child: SizedBox(
                          width: 140, // Set the button width
                          height: 40,
                          child: ElevatedButton(
                            onPressed: fetchStudentProgress, // Call function on button press
                            child: Text(
                              'View Progress',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 105, 1, 161), // Button color
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20), // Space before the DataTable

                      // DataTable to display results
                      if (testIds.isNotEmpty) ...[
                        Expanded(
                          child: SingleChildScrollView(
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Test ID', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Marks', style: TextStyle(fontWeight: FontWeight.bold))),
                                DataColumn(label: Text('Time', style: TextStyle(fontWeight: FontWeight.bold))),
                              ],
                              rows: List<DataRow>.generate(testIds.length, (index) {
                                return DataRow(cells: [
                                  DataCell(Text(testIds[index]?.toString() ?? 'N/A')),
                                  DataCell(Text(marks[index]?.toString() ?? 'N/A')),
                                  DataCell(Text(times[index]?.toString() ?? 'N/A')),
                                ]);
                              }),
                            ),
                          ),
                        ),
                      ] else if (rollNumber != null && division != null) ...[
                        Center(child: Text('No records found for this student.')),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
