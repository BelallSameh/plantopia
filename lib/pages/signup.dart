import 'package:flutter/material.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/animations/jumpinglogo.dart';
import 'package:plantopia/pages/T&C.dart';
import 'package:plantopia/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Function to validate password format
  bool _isPasswordValid(String password) {
    // Password must be at least 8 characters long
    if (password.length < 8) return false;

    // Password must contain at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) return false;

    // Password must contain at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) return false;

    return true;
  }

  Future<void> signUp(BuildContext context) async {
    // Check if passwords match and meet requirements
    if (passwordController.text != confirmPasswordController.text) {
      _showAlertDialog(context, "Passwords do not match");
      return;
    } else if (!_isPasswordValid(passwordController.text)) {
      _showAlertDialog(context,
          "Password must be at least 8 characters long and contain at least one uppercase letter and one digit");
      return;
    }

    // Your existing sign-up logic
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print('User signed up: ${userCredential.user!.uid}');
      // Navigate to terms and conditions page
      Navigator.push(context, SlidePageRoute(page: TC()));
    } on FirebaseAuthException catch (e) {
      print('Failed to sign up: $e');
      if (e.code == 'email-already-in-use') {
        _showAlertDialog(context, "Email is already in use");
      } else {
        // Handle other FirebaseAuthException errors
        _showAlertDialog(context, "Sign up failed: ${e.message}");
      }
    }
  }

  void _showAlertDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFE8F0DE),
          title: Text(
            'Authentication Error',
            style: TextStyle(
              color: Color(0xFF2C6103),
              fontSize: 16,
              fontFamily: 'Kavoon',
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              color: Color(0xFF2C6103),
              fontSize: 16,
              fontFamily: 'Kavoon',
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF2C6103),
                  fontSize: 16,
                  fontFamily: 'Kavoon',
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double cardTopPosition = 70.0;
    double cardBottomPosition = 40.0;
    double cardHeight = screenHeight - cardTopPosition - cardBottomPosition+5;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background Image
          Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background2.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Centered Card
          Center(
            child: SizedBox(
              width: 320,
              height: cardHeight,
              child: Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          JumpingLogo(),
                          Text(
                            "Create An Account",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1C8D29),
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF1C8D29),
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.white),
                                hintText: "Enter your name",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                isDense: true,
                              ),
                              style: TextStyle(color: Colors.white),
                              textAlignVertical: TextAlignVertical.center,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF1C8D29),
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.white),
                                hintText: "Enter your Email",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                isDense: true,
                              ),
                              style: TextStyle(color: Colors.white),
                              textAlignVertical: TextAlignVertical.center,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF1C8D29),
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.white),
                                hintText: "Enter your password",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                isDense: true,
                              ),
                              style: TextStyle(color: Colors.white),
                              textAlignVertical: TextAlignVertical.center,
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: TextField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Color(0xFF1C8D29),
                                prefixIcon:
                                    Icon(Icons.lock, color: Colors.white),
                                hintText: "Confirm password",
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 20.0),
                                isDense: true,
                              ),
                              style: TextStyle(color: Colors.white),
                              textAlignVertical: TextAlignVertical.center,
                            ),
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: () => signUp(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF472F26),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 90),
                            ),
                            child: Text(
                              "Continue",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context, SlidePageRoute(page: Login()));
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Have an account? ",
                                style: TextStyle(
                                  color: Color(0xFF1C8D29),
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Log In",
                                    style: TextStyle(
                                      color: Color(0xFF472F26),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
