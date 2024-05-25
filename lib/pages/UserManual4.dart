import 'package:flutter/material.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/animations/jumpinglogo.dart';
import 'package:plantopia/pages/Welcome.dart';

class UserManual4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardTopPosition = 70.0;
    double cardBottomPosition = 40.0;
    double cardHeight = screenHeight - cardTopPosition - cardBottomPosition+5;
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
                child: Stack(
                  children: [
                    Positioned(
                      top: cardTopPosition-50,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: JumpingLogo(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
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
                                    border: Border.all(color: Color(0xFF205724), width: 2),
                                  ),
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
                          SizedBox(height: 100,),
                          Image.asset("assets/images/name.png", width: 250, height: 70),
                          SizedBox(height: 20,),
                          Text(
                            "Step three:",
                            style: TextStyle(
                              color: Color(0xFF7FBC69),
                              fontSize: 16.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Keep your plants healthy and growing",
                            style: TextStyle(
                              color: Color(0xFF7FBC69),
                              fontSize: 16.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.asset(
                              "assets/images/step3.png",
                              width: 250,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 40),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, SlidePageRoute(page: Welcome()));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text(
                                "Back",
                                style: TextStyle(
                                  color: Color(0xFF1C8D29),
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Kavoon',
                                ),
                              ),
                            ),
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
