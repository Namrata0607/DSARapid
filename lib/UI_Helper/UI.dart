import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dsa_rapid/Dashboard.dart';
import 'dart:math';
 
AppBar mtext(){
          return AppBar(
            title: Text("DSA Rapid",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 105, 1, 161),
          );
}

AppBar appBack(BuildContext context) {
  return AppBar(
    title: Text(
      "DSA Rapid",
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 20,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    backgroundColor: Color.fromARGB(255, 105, 1, 161),
    // Add back button
    leading: IconButton(
      icon: Icon(Icons.arrow_back,color: Colors.white,),
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()), // Redirect to Home
        );
      },
    ),
  );
}

TextStyle h2(){
  return TextStyle(
     fontSize: 22,
      fontWeight: FontWeight.bold,
  );
}

TextStyle h3(){
   return TextStyle(
     fontSize: 18,
  );
}


// Define the Question class
class Question {
  final String questionText;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.options,
    required this.correctAnswerIndex,
  });
}

// Function to generate random questions (or you can just pass the question list from each topic)
List<Question> getRandomQuestions(List<Question> allQuestions) {
  var random = Random();
  List<Question> selectedQuestions = [];
  while (selectedQuestions.length < 10) {
    Question question = allQuestions[random.nextInt(allQuestions.length)];
    if (!selectedQuestions.contains(question)) {
      selectedQuestions.add(question);
    }
  }
  return selectedQuestions;
}

class QuizUI extends StatefulWidget {
  final List<Question> quizQuestions; // Pass the questions from the topic file
  final String testId;
  
  QuizUI({required this.quizQuestions,required this.testId});

  @override
  _QuizUIState createState() => _QuizUIState();
}

class _QuizUIState extends State<QuizUI> {
  Map<int, int> selectedAnswers = {};
  bool isSubmitted = false;
  int score = 0;

  void handleAnswer(int questionIndex, int answerIndex) {
    setState(() {
      selectedAnswers[questionIndex] = answerIndex;
    });
  }

  
Future<void> submitQuiz() async {
  // Access the testId from the widget
  String quizId = widget.testId;
  int score = calculateScore(); // Method to calculate score based on selected answers

  try {
    await submitTest(quizId, score);
    // Show the result screen in a dialog
    setState(() {
      isSubmitted = true;
      this.score = score;
    });
  } catch (e) {
    // Handle any errors here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to submit quiz: $e')),
    );
  }
}


// Method to calculate score
int calculateScore() {
  int score = 0;
  for (int i = 0; i < widget.quizQuestions.length; i++) {
    if (selectedAnswers[i] == widget.quizQuestions[i].correctAnswerIndex) {
      score++;
    }
  }
  return score;
}

// submitTest function
Future<void> submitTest(String quizId, int score) async {
  // Get the user ID from Firebase Authentication
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  // Reference to the test document for the specific user
  final testDocument = FirebaseFirestore.instance.collection('user_db').doc(userId);

  try {
    // Retrieve current document data
    final snapshot = await testDocument.get();
    if (snapshot.exists) {
      List<dynamic> existingTestIds = snapshot['test_id'] ?? [];
      List<dynamic> existingMarks = snapshot['marks'] ?? [];
      List<dynamic> existingTimes = snapshot['time'] ?? [];

      // Manually add the new entries to each array
      existingTestIds.add(quizId);
      existingMarks.add(score);
      existingTimes.add(DateTime.now().toString());

      // Update the document with the modified arrays
      await testDocument.update({
        'test_id': existingTestIds,
        'marks': existingMarks,
        'time': existingTimes,
      });
    } else {
      // If document doesn't exist, create it with initial arrays
      await testDocument.set({
        'test_id': [quizId],
        'marks': [score],
        'time': [DateTime.now().toString()],
      });
    }
  } catch (e) {
    print('Error updating test data: $e'); // Log the error if the update fails
    throw e; // Optionally re-throw the error for further handling
  }
}



  void restartQuiz() {
    setState(() {
      isSubmitted = false;
      score = 0;
      selectedAnswers.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quiz"),
        backgroundColor: Color.fromARGB(255, 105, 1, 161),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isSubmitted ? buildResultScreen(score) : buildQuizBody(),
      ),
    );
  }

  Widget buildQuizBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Answer all questions:',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: widget.quizQuestions.length,
            itemBuilder: (context, index) {
              return buildQuestionCard(index);
            },
          ),
        ),
        Center(
          child: SizedBox(
            width: 600,
            height: 60,
            child: ElevatedButton(
              onPressed: selectedAnswers.length == widget.quizQuestions.length
                  ? () async {
                      // Call the submitQuiz function
                      await submitQuiz();
                    }
                  : null, // Enable button only if all questions are answered
              child: Text(
                'Submit Quiz',
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16.0),
                backgroundColor: Color.fromARGB(255, 105, 1, 161),
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildQuestionCard(int questionIndex) {
    Question question = widget.quizQuestions[questionIndex];
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${questionIndex + 1}. ${question.questionText}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ...question.options.asMap().entries.map((entry) {
              int optionIndex = entry.key;
              String optionText = entry.value;
              return RadioListTile<int>(
                title: Text(optionText),
                value: optionIndex,
                groupValue: selectedAnswers[questionIndex],
                onChanged: (value) {
                  handleAnswer(questionIndex, value!);
                },
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget buildResultScreen(int score) {
    return Center(
      child: SizedBox(
        height: 300,
        width: 400,
        child: Card(
          elevation: 8.0, // Adds shadow effect
          color: Color.fromARGB(255, 244, 224, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0), // Adds padding inside the card
            child: Column(
              mainAxisSize: MainAxisSize.min, // Keeps the card size minimal
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Your Score: $score / ${widget.quizQuestions.length}',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: restartQuiz,
                    child: Text(
                      'Restart Quiz',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16.0),
                      backgroundColor: Color.fromARGB(255, 105, 1, 161),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to previous screen
                    },
                    child: Text(
                      'Quit Quiz',
                      style: TextStyle(fontSize: 18),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16.0),
                      backgroundColor: Color.fromARGB(255, 105, 1, 161),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
