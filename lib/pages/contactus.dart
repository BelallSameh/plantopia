import 'package:flutter/material.dart';
import 'package:plantopia/animations/jumpinglogo.dart'; // Import JumpingLogo

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardTopPosition = 70.0;
    double cardBottomPosition = 40.0;
    double cardHeight = screenHeight - cardTopPosition - cardBottomPosition-20;
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background2.jpg'), // Replace with your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Card(
              color: Color(0xFFE8F0DE),
              margin: EdgeInsets.symmetric(vertical: 24.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide(color: Color(0xFFA3D761), width: 5),
              ),
              child: Container(
                width: 300,
                height: cardHeight,
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Replace static logo with JumpingLogo2
                          JumpingLogo(),
                          SizedBox(height: 10),
                          Text(
                            'Contact us!',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kavoon',
                            ),
                          ),
                          SizedBox(height: 20),

                          // Email section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email:',
                                style: TextStyle(
                                  fontFamily: 'Kavoon',
                                  fontSize: 20,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 200,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4D564),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  'Plantopia@gmail.com', // Replace with your email
                                  style: TextStyle(
                                    fontFamily: 'Kavoon',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),

                          // Phone section
                          // Phone section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start, // Align text to the left
                                children: [
                                  SizedBox(width: 15,),
                                  Text(
                                    'Phone Number:',
                                    style: TextStyle(
                                      fontFamily: 'Kavoon',
                                      fontSize: 20,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: 200,
                                height: 40,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4D564),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.green,
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  '+1 (123) 456-7890', // Replace with your phone number
                                  style: TextStyle(
                                    fontFamily: 'Kavoon',
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(height: 65),
                              Center(
                                child: Text(
                                  'Thank you for using Plantopia! If you have any questions, feedback, or technical issues, please don\'t hesitate to get in touch with us. We\'re here to help!',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontFamily: 'Kavoon',
                                    color: Colors.lightGreen,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 25),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context); // Navigate back to the previous screen
                                  },
                                  child: Image.asset(
                                    "assets/images/back.png",
                                    width: 24,
                                    height: 24,
                                    color: Color(0xFF205724),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
