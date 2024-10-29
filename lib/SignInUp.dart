import 'dart:convert';
import 'dart:io';
import 'dart:html' as html;
import 'package:dsa_rapid/Dashboard.dart';
import 'package:dsa_rapid/UI_Helper/UI.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
// import 'package:firebase_auth/firebase_auth.dart'; // Ensure this is added
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isPasswordVisible = false; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        backgroundColor: Color.fromARGB(255, 105, 1, 161),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App logo or title
                  Container(
                    margin: EdgeInsets.only(top: 40, bottom: 20),
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
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your email';
                                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
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
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
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
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Please enter your password';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
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
                                  if (_formKey.currentState!.validate()) {
                                    final email = _emailController.text.trim();
                                    final password = _passwordController.text.trim();

                                    try {
                                      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
                                        email: email,
                                        password: password,
                                      );
                                      User? user = userCredential.user;
                                      if (user != null) {
                                        print('Sign in successful!');
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => Home()), 
                                        );
                                      } else {
                                        print('Sign in failed!');
                                      }
                                    } catch (e) {
                                      print('Error: $e');
                                    }
                                  }
                                },
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Don't have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => SignupPage()), // Make sure SignupPage() is defined
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


class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _confirmPasswordController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _classController = TextEditingController();
  final _divisionController = TextEditingController();
  final _rollnoController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final AuthService _auth = AuthService();
  File? _selectedImage;
  String? _profileUrl;
  static const String cloudName = 'dizb1hygb';
  static const String apiKey = '434625396783416';
  static const String apiSecret = 'lOMFEPBVqRzcZqT8C-EzEI1vL4k';

  Future<void> _pickImage() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files?.isNotEmpty ?? false) {
        final file = files!.first;
        await _uploadImageToCloudinary(file);
      }
    });
  }

  Future<void> _uploadImageToCloudinary(html.File imageFile) async {
    final uri = Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
    final request = http.MultipartRequest('POST', uri)
      ..fields['upload_preset'] = 'profile_pics' // Ensure this preset exists in your Cloudinary
      ..fields['api_key'] = apiKey // Add your API key
      ..fields['api_secret'] = apiSecret;

    final reader = html.FileReader();
    reader.readAsArrayBuffer(imageFile); // Read the image as an ArrayBuffer
    reader.onLoadEnd.listen((e) async {
      final bytes = reader.result as List<int>;
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        bytes,
        filename: imageFile.name,
      ));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        setState(() {
          _profileUrl = json.decode(responseData)['url'];
          print('Uploaded image URL: $_profileUrl'); // Store Cloudinary URL
        });
      } else {
        print("Failed to upload image: ${response.statusCode}");
        final responseData = await response.stream.bytesToString();
        print("Response: $responseData");
      }
    });
  }

  Future<void> _storeUserData(User user) async {
    // Firestore storage
    await FirebaseFirestore.instance.collection('user_db').doc(user.uid).set({
      'full_name': _fullNameController.text.trim(),
      'class': _classController.text.trim(),
      'division': _divisionController.text.trim(),
      'roll_no': _rollnoController.text.trim(),
      'profile_url': _profileUrl,
      'created_at': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mtext(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg.png"),
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
                    Container(
                      margin: EdgeInsets.only(top: 40, bottom: 20),
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
                      height: 750,
                      width: 500,
                      child: Card(
                        color: Color.fromARGB(255, 244, 224, 255),
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
                                InkWell(
                                  onTap: _pickImage,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: _profileUrl != null ? NetworkImage(_profileUrl!) : null,
                                    child: _profileUrl == null
                                        ? Icon(Icons.camera_alt)
                                        : null , // Show tick icon
                                  ),
                                ),
                                Text(
                                  _profileUrl != null ? "Image Uploaded Successfully" : "Upload Profile Picture",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
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
                                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _classController,
                                  decoration: InputDecoration(
                                    labelText: 'Class',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Icon(Icons.class_),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your Class';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _divisionController,
                                  decoration: InputDecoration(
                                    labelText: 'Division',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Icon(Icons.group),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your division';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _rollnoController,
                                  decoration: InputDecoration(
                                    labelText: 'Roll No',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Icon(Icons.confirmation_number),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your roll number';
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
                                    if (_formKey.currentState!.validate()) {
                                      final email = _emailController.text.trim();
                                      final password = _passwordController.text.trim();

                                      // Sign up user
                                      User? user = await _auth.signUpWithEmail(email, password);
                                      if (user != null) {
                                        // Store user data in Firestore
                                        await _storeUserData(user);
                                        print('Sign up successful!');
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => SignInPage()),
                                        );
                                      } else {
                                        print('Sign up failed!');
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    backgroundColor: Color.fromARGB(255, 105, 1, 161),
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Already have an account? "),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => SignInPage()),
                                        );
                                      },
                                      child: Text(
                                        "Sign In",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 105, 1, 161),
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
}
