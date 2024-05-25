import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/animations/jumpinglogo2.dart';
import 'package:plantopia/pages/home.dart';
import 'package:plantopia/pages/contactus.dart';

class TC extends StatefulWidget {
  @override
  _TCState createState() => _TCState();
}

class _TCState extends State<TC> {
  bool _isChecked = false;

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFE8F0DE),
          title: Text(
            'Accept Terms and Conditions',
            style: TextStyle(
              color: Color(0xFF2C6103),
              fontSize: 16,
              fontFamily: 'Kavoon',
            ),
          ),
          content: Text(
            'You must accept the terms and conditions to sign up.',
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

  void _onSignUp() {
    if (!_isChecked) {
      _showAlertDialog();
    } else {
      Navigator.push(
        context,
        SlidePageRoute(page: Home()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardTopPosition = 70.0;
    double cardBottomPosition = 40.0;
    double cardHeight = screenHeight - cardTopPosition - cardBottomPosition+40;
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
            top: cardTopPosition,
            left: 0,
            right: 0,
            child: Container(
              height: cardHeight,
              child: Card(
                elevation: 10,
                color: Color(0xFFE8F0DE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color(0xFF205724), width: 2),
                              ),
                              child: Image.asset(
                                "assets/images/back.png",
                                width: 24,
                                height: 24,
                                color: Color(0xFF205724),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Terms and Conditions",
                            style: TextStyle(
                              color: Color(0xFF2C6103),
                              fontSize: 18,
                              fontFamily: 'Kavoon',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Color(0xFF2C6103),
                                    fontSize: 16,
                                    fontFamily: 'Kavoon',
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '''
Welcome to Plantopia! By using our mobile application ("App"), you agree to the following terms and conditions:

1. Acceptance of Terms
By using the App, you agree to be bound by these Terms. We may update these Terms from time to time without prior notice.

2. Description of the App
Plantopia helps you care for your plants by providing instant information about their species and health status. Simply snap a picture of your plant, and let Plantopia do the rest!

3. User Conduct
Please use the App responsibly and comply with all applicable laws and regulations.

4. Intellectual Property
All content and materials in the App are owned by Plantopia or its licensors and are protected by intellectual property laws.

5. Privacy Policy
Your privacy is important to us. Please review our Privacy Policy for information on how we collect and use your personal information.

6. Disclaimer of Warranties
The App is provided "as is" without any warranties. We do not guarantee uninterrupted or error-free operation.

7. Limitation of Liability
We are not liable for any damages arising from your use of the App.

8. Indemnification
You agree to indemnify us from any claims arising out of your use of the App.

9. Governing Law
These Terms are governed by the laws of Egypt.

10. Contact Us
If you have any questions or concerns about these Terms, please ''',
                                    ),
                                    TextSpan(
                                      text: 'Contact Us.',
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Color(0xFF472F26),
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(context, SlidePageRoute(page: ContactUs()));

                                        },
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(height: 20),
                              Row(
                                children: [
                                  Checkbox(
                                    value: _isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _isChecked = value!;
                                      });
                                    },
                                    checkColor: Color(0xFF472F26),
                                    activeColor: Color(0xFF472F26),
                                  ),
                                  Text(
                                    "I accept the Terms and Conditions",
                                    style: TextStyle(
                                      color: Color(0xFF472F26),
                                      fontSize: 16,
                                      fontFamily: 'Kavoon',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: ElevatedButton(
                                  onPressed: _onSignUp,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF472F26),
                                  ),
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'Kavoon',
                                    ),
                                  ),
                                ),
                              )
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
          Positioned(
            top: cardTopPosition-45,
            right: -50,
            child: JumpingLogo2(),
          ),
          Positioned(
            top: cardTopPosition,
            left: 0,
            right: 0,
            child: Container(
              height: 10,
              color: Color(0xFFC5E79A),
            ),
          ),
        ],
      ),
    );
  }
}
