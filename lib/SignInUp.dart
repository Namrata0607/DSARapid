import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Ensure this is added


class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      // Authentication logic here
      print('Email: $email');
      print('Password: $password');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }
  @override
  void initState() {
    super.initState();
    // Set the persistence mode for web (for mobile this is not required)
    _setAuthPersistence();
  }


  Future<void> _setAuthPersistence() async {
    try {
      // Set persistence to LOCAL for web applications
      await _auth.setPersistence(Persistence.LOCAL);
      print('Persistence set to LOCAL');
    } catch (e) {
      print('Failed to set persistence: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mtext(),

      // backgroundColor: Color.fromARGB(255, 244, 224, 255),
      body: Stack(
        children: [
          // Optionally add a background image

          // Column(
          //   children: [
          //     Container(
          //       decoration: BoxDecoration(
          //         image: DecorationImage(
          //           image: AssetImage("assets/images/SplashDSA.jpeg"), // Add your background image here
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App logo or title
                    Container(
                      margin: EdgeInsets.only(top: 40,bottom: 20),
                      // color: Colors.white,
                      child: Text(
                        'Sign In Form',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 105, 1, 161),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 450,
                      width: 500,
                      child: Card(

                        color: Color.fromARGB(255, 244, 224, 255),
                        // margin: EdgeInsets.all(100),
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(

                          borderRadius: BorderRadius.circular(10),

                        ),
                        child: Padding(

                          padding: const EdgeInsets.all(30.0),
                          child: Form(

                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Please enter your email';
                                  //   } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  //       .hasMatch(value)) {
                                  //     return 'Please enter a valid email';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                  obscureText: true,
                                  // validator: (value) {
                                  //   if (value == null || value.isEmpty) {
                                  //     return 'Please enter your password';
                                  //   } else if (value.length < 6) {
                                  //     return 'Password must be at least 6 characters';
                                  //   }
                                  //   return null;
                                  // },
                                ),
                                SizedBox(height: 20.0),
                                SizedBox(height: 20.0),

                                // "Forgot Password?" link
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      // Add forgot password logic here
                                    },
                                    child: Text(
                                      'Forgot Password?',
                                      style: TextStyle(color: Color.fromARGB(255, 105, 1, 161)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                ElevatedButton(

                                  onPressed: () async {
                                    final email = _emailController.text.trim();
                                    final password = _passwordController.text.trim();

                                    try {
                                      // Sign in with Firebase
                                      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                      );
                                      User? user = userCredential.user;

                                      if (user != null) {
                                        print('Sign in successful!');
                                      } else {
                                        print('Sign in failed!');
                                      }
                                    } catch (e) {
                                      print('Error: $e');
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(

                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor:Color.fromARGB(255, 105, 1, 161), // Border color

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
                                // "Sign Up" link for new users
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Don't have an account? "),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => SignupPage()),
                                        );
                                      },
                                      child: Text(
                                        'Sign Up',

                                        style: TextStyle(
                                          color: Color.fromARGB(255, 105, 1, 161),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

// void main() {
//   runApp(MaterialApp(
//     title: 'Sign In',
//     theme: ThemeData(
//       primarySwatch: Colors.purple,
//     ),
//     home: SignInPage(),
//   ));
// }


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _collegeNameController = TextEditingController();
  final _divisionController = TextEditingController();
  final _rollNoController = TextEditingController();
  bool _isPasswordVisible = false; // Track password visibility
  bool _isConfirmPasswordVisible = false; // Track confirm password visibility
  final AuthService _auth = AuthService();
  bool _isSignUp = false;

  void _handleSignIn() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      // Authentication logic here
      print('Email: $email');
      print('Password: $password');

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mtext(),
      body: Stack(
        children: [
          // Optionally add a background image

          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"), // Your background image
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App logo or title
                    Container(
                      margin: EdgeInsets.only(top: 40,bottom: 20),

                      child: Text(
                        'Sign Up Form',
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 105, 1, 161),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 650,
                      width: 500,
                      child: SingleChildScrollView(
                        scrollDirection:Axis.vertical,
                        child: Card(
                          color: Color.fromARGB(255, 244, 224, 255),
                          // margin: EdgeInsets.all(100),
                          elevation: 8.0,
                          shape: RoundedRectangleBorder(

                            borderRadius: BorderRadius.circular(10),

                          ),
                          child: Padding(

                            padding: const EdgeInsets.all(30.0),
                            child: Form(

                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 20.0),
                                  TextFormField(
                                    controller: _fullNameController,
                                    decoration: InputDecoration(
                                      labelText: 'Full Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Icon(Icons.person),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your full name';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 20.0),

                                  TextFormField(
                                    controller: _collegeNameController,
                                    decoration: InputDecoration(
                                      labelText: 'College Name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Icon(Icons.school),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your college name';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 20.0),

                                  // TextFormField(
                                  //   controller: _divisionController,
                                  //   decoration: InputDecoration(
                                  //     labelText: 'Division',
                                  //     border: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //     ),
                                  //     prefixIcon: Icon(Icons.group),
                                  //   ),
                                  //   validator: (value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter your division';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),

                                  // SizedBox(height: 20.0),

                                  // TextFormField(
                                  //   controller: _rollNoController,
                                  //   decoration: InputDecoration(
                                  //     labelText: 'Roll No',
                                  //     border: OutlineInputBorder(
                                  //       borderRadius: BorderRadius.circular(10),
                                  //     ),
                                  //     prefixIcon: Icon(Icons.confirmation_number),
                                  //   ),
                                  //   keyboardType: TextInputType.number,
                                  //   validator: (value) {
                                  //     if (value == null || value.isEmpty) {
                                  //       return 'Please enter your roll number';
                                  //     } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  //       return 'Please enter a valid roll number';
                                  //     }
                                  //     return null;
                                  //   },
                                  // ),

                                  TextFormField(
                                    controller: _emailController,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Icon(Icons.email),
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20.0),
                                  TextFormField(
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      } else if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),

                                  SizedBox(height: 20.0),

                                  // Confirm Password Field
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                          });
                                        },
                                      ),
                                    ),
                                    obscureText: !_isConfirmPasswordVisible,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      } else if (value != _passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20.0),
                                  ElevatedButton(
                                    onPressed: () async {
                                      final email = _emailController.text.trim();
                                      final password = _passwordController.text.trim();
                                      User? user = await _auth.signUpWithEmail(email, password);
                                      if (user != null) {
                                        print('Sign up successful!');
                                      } else {
                                        print('Sign up failed!');
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      backgroundColor:Color.fromARGB(255, 105, 1, 161), // Border color

                                    ),
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  // "Sign Up" link for new users
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(" Already have an account? "),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => SignInPage()),
                                          );
                                        },
                                        child: Text(
                                          'Sign In',

                                          style: TextStyle(
                                            color: Color.fromARGB(255, 105, 1, 161),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
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

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

}