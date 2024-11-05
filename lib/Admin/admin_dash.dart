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

class DashboardPage extends StatelessWidget {
  final String adminName;
  final String adminEmail;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DashboardPage({required this.adminName, required this.adminEmail});

  void _showAddAdminDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
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
            width: MediaQuery.of(context).size.width * 0.20, // Increased to 25% of screen width
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
                            child: Icon(Icons.person, color: Color(0xFF6901A1), size: 30), // Adjust icon size
                            radius: MediaQuery.of(context).size.width * 0.05, // Reduced radius
                          ),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.02), // Spacing

                        // Admin Name
                        Text(
                          adminName,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6901A1),
                          ),
                          textAlign: TextAlign.center,
                        ),

                        // Admin Email
                        Text(
                          adminEmail,
                          style: TextStyle(color: Color(0xFF6901A1)),
                          textAlign: TextAlign.center,
                        ),

                        Divider(),

                        // List of Options
                        ListTile(
                          leading: Icon(Icons.add, color: Color(0xFF6901A1)),
                          title: Text('Add Admin', style: TextStyle(color: Color(0xFF6901A1))),
                          onTap: () {
                            _showAddAdminDialog(context);
                          },
                        ),
                        Divider(),
                        ListTile(
                          leading: Icon(Icons.logout, color: Color(0xFF6901A1)),
                          title: Text('Logout', style: TextStyle(color: Color(0xFF6901A1))),
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
              child: Center(
                child: Text(
                  'Welcome to DSA RAPID Dashboard!',
                  style: TextStyle(fontSize: 24),
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
