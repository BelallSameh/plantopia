import 'package:flutter/material.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/animations/jumpinglogo.dart';
import 'package:plantopia/pages/UserManual3.dart';

class UserManual2 extends StatelessWidget {
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
                          // Text block
                          SizedBox(height: 20,),
                          Text(
                            "Step one:",
                            style: TextStyle(
                              color: Color(0xFF7FBC69),
                              fontSize: 16.4,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 10,),
                          Text(
                            "Take a picture of your plant",
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
                              "assets/images/step1.png",
                              width: 250,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 60),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(context, SlidePageRoute(page: UserManual3()));
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Color(0xFF48742C),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_forward, color: Colors.white),
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