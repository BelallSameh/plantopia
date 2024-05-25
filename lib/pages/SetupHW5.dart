import 'package:flutter/material.dart';
import 'package:plantopia/animations/jumpinglogo.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/animations/balloon.dart';
import 'package:plantopia/pages/home.dart';

class SetupHW5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardTopPosition = 70.0;
    double cardBottomPosition = 40.0;
    double cardHeight = screenHeight - cardTopPosition - cardBottomPosition-20;
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
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF1C8D29),
                  width: 8.0,
                ),
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: SizedBox(
                width: double.infinity,
                height: cardHeight,
                child: Card(
                  elevation: 10,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  margin: EdgeInsets.zero,
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
                      Positioned.fill(
                        child: BalloonAnimation(),
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
                            SizedBox(height: 100),
                            Image.asset("assets/images/name.png", width: 250, height: 70),
                            SizedBox(height: 20),
                            Text(
                              "CONGRATULATIONS!!!",
                              style: TextStyle(
                                color: Color(0xFF7FBC69),
                                fontSize: 30,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF1C8D29),
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.asset(
                                  "assets/images/congrats.png",
                                  width: 280,
                                  height: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, SlidePageRoute(page: Home()),);
                              },
                              child: Container(
                                width: 250,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF4D564),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: Text(
                                    "Finish",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                    ),
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
          ),
        ],
      ),
    );
  }
}
