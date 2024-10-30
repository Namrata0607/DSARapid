import 'package:flutter/material.dart';

void main() {
  runApp(AdminDash());
}

class AdminDash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: LoginPage(),
    );
  }
}

// Simulating password storage
String currentPassword = 'admin123';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleSignIn(BuildContext context) {
    String email = _emailController.text;
    String password = _passwordController.text;

    // Authentication logic (for demonstration)
    if (email == 'admin' && password == 'admin') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DashboardPage(
            adminName: 'Admin', // Pass admin name here
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
        backgroundColor: Colors.purple,
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 20),
                      child: Text(
                        'Admin Login Form',
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
                                ),
                                obscureText: true,
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () => _handleSignIn(context),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor:
                                      Color.fromARGB(255, 105, 1, 161),
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
          ),
        ],
      ),
    );
  }
}
class DashboardPage extends StatelessWidget {
  final String adminName;
  final String adminEmail;

  DashboardPage({required this.adminName, required this.adminEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DSA RAPID'),
        backgroundColor: Color(0xFF6901A1), // Dark purple color
      ),
      body: Row(
        children: [
          Container(
            width: 250,
            color: Color.fromARGB(255, 199, 167, 255), // Light purple background
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
  accountName: Text(
    adminName,
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xFF6901A1),
    ),
  ),
  accountEmail: adminEmail != 'admin' ? Text(
    adminEmail,
    style: TextStyle(color: Color(0xFF6901A1),),
  ) : null, // Hide email if it is 'admin'
  currentAccountPicture: CircleAvatar(
    backgroundColor: Colors.white,
    child: Icon(Icons.person, color: Color(0xFF6901A1), size: 40),
  ),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 199, 167, 255),
  ),
),
                ListTile(
                  leading: Icon(Icons.lock, color: Color(0xFF6901A1)),
                  title: Text('Change Password',
                      style: TextStyle(color: Color(0xFF6901A1))),
                  onTap: () {
                    _showChangePasswordDialog(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.group, color: Color(0xFF6901A1)),
                  title: Text('Manage Students',
                      style: TextStyle(color: Color(0xFF6901A1))),
                  onTap: () {
                    _showManageStudentsDialog(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Color(0xFF6901A1)),
                  title: Text('Logout', style: TextStyle(color: Color(0xFF6901A1))),
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
                Divider(),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Welcome to DSA RAPID!',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Current Password'),
              ),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'New Password'),
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirm Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('Submit'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF6901A1),
              ),
              onPressed: () {
                if (currentPasswordController.text == currentPassword) {
                  if (newPasswordController.text ==
                      confirmPasswordController.text) {
                    currentPassword = newPasswordController.text;

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Password changed successfully')),
                    );
                    Navigator.of(context).pop();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Current password is incorrect')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showManageStudentsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Manage Students'),
          content: Text('This feature is under development.'),
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
