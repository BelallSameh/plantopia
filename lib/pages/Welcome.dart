import 'package:flutter/material.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/animations/jumpinglogo.dart';
import 'package:plantopia/pages/UserManual1.dart';
import 'package:plantopia/pages/SignUp.dart';
import 'package:plantopia/pages/login.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
          Positioned(
            top: 150,
            left: 0,
            right: -10,
            child: Center(
              child: JumpingLogo(),
            ),
          ),
          Positioned(
            top: 340,
            left: 0,
            right: 0,
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD6F2B1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  ),
                  onPressed: () {
                    Navigator.push(context, SlidePageRoute(page: Login()));
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontFamily: 'Kavoon',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C8D29), // Text color
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD6F2B1), // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  onPressed: () {
                    Navigator.push(context, SlidePageRoute(page: SignUp()));
                  },
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontFamily: 'Kavoon',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C8D29),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD6F2B1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, SlidePageRoute(page: UserManual1()));
                  },
                  child: Text(
                    'How to Use',
                    style: TextStyle(
                      fontFamily: 'Kavoon',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1C8D29),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
