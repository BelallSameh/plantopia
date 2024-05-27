import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantopia/animations/jumpinglogo.dart';
import 'package:plantopia/pages/signup.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/pages/T&C2.dart';
import 'package:plantopia/pages/home.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Login extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signIn(BuildContext context) async {
    try {
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print('User logged in: ${userCredential.user!.uid}');
      Navigator.push(context, SlidePageRoute(page: Home()));
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in: $e');
      _showAlertDialog(
          context, e.message ?? 'Failed to sign in. Please try again.');
    }
  }

   Future<void> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Sign in with the credential
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Navigate to the home page if the sign-in is successful
      if (userCredential.user != null) {
        Navigator.push(context, SlidePageRoute(page: Home()));
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing in with Google: $e')),
      );
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset email sent!')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        JumpingLogo(),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(FontAwesomeIcons.google,
                                  color: Colors.red, size: 33),
                              onPressed: () {
                                signInWithGoogle(context);
                              },
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                        SizedBox(height: 5),
                        Text(
                          'OR',
                          style: TextStyle(color: Colors.green, fontSize: 27),
                        ),
                        SizedBox(height: 5),
                        TextField(
                          controller: emailController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email, color: Colors.white),
                            hintText: 'Enter your Email',
                            hintStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.green,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Colors.white),
                            fillColor: Colors.green,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            suffixIcon: Icon(Icons.visibility_off,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(value: false, onChanged: (value) {}),
                                Text(
                                  'Remember me',
                                  style: TextStyle(color: Colors.brown),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () {
                                resetPassword(context);
                              },
                              child: Text(
                                'Forget Password',
                                style: TextStyle(
                                  color: Colors.brown,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        ElevatedButton(
                          onPressed: () => signIn(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.brown,
                            padding: EdgeInsets.symmetric(
                                horizontal: 110, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Log in',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context, SlidePageRoute(page: TC2()));
                            },
                            child: Text.rich(
                              TextSpan(
                                text: 'by continuing you agree to ',
                                style: TextStyle(color: Colors.brown),
                                children: [
                                  TextSpan(
                                    text: 'terms and conditions',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 13,
                                        color: Colors.brown),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context, SlidePageRoute(page: SignUp()));
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Don\'t have an account? ',
                              style: TextStyle(color: Colors.green),
                              children: [
                                TextSpan(
                                  text: 'Sign Up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.brown),
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
        ],
      ),
    );
  }
}
