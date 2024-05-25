import 'package:flutter/material.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/animations/jumpinglogo2.dart';
import 'package:plantopia/pages/SetupHW1.dart';
import 'package:plantopia/pages/customdrawer.dart';
import 'package:provider/provider.dart';
import 'package:plantopia/classes/plantclass.dart';
import 'package:plantopia/providers/plant_provider.dart';
import 'dart:io';

class AddCare extends StatefulWidget {
  final Plant plant;

  AddCare({required this.plant});

  @override
  _AddCareState createState() => _AddCareState();
}

class _AddCareState extends State<AddCare> {
  int waterCounter = 0;
  int sprayCounter = 0;
  int pruneCounter = 0;
  int fertiliseCounter = 0;
  int rotateCounter = 0;
  int cleanCounter = 0;
  DateTime lastWatering = DateTime.now();
  DateTime lastSpraying = DateTime.now();
  DateTime lastPruning = DateTime.now();
  DateTime lastFertilizing = DateTime.now();
  DateTime lastRotation = DateTime.now();
  DateTime lastCleaning = DateTime.now();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardTopPosition = 70.0;
    double cardBottomPosition = 40.0;
    double cardHeight = screenHeight - cardTopPosition - cardBottomPosition;
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
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                SlidePageRoute(page: CustomDrawer()),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color(0xFF205724), width: 2),
                              ),
                              child: Icon(
                                Icons.menu,
                                color: Color(0xFF205724),
                                size: 24,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Care Info",
                            style: TextStyle(
                              color: Color(0xFF2C6103),
                              fontSize: 20,
                              fontFamily: 'Kavoon',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Color(0xFFD6E9BD),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: widget.plant.imagePath.isNotEmpty
                                  ? Image.file(
                                      File(widget.plant.imagePath),
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.image,
                                      size: 100,
                                      color: Colors.grey,
                                    ),
                            ),
                            SizedBox(height: 20),
                            // Add the rest of your care info blocks here
                            buildCareInfoBlock(
                              'Water every',
                              Icons.opacity,
                              waterCounter,
                              () {
                                setState(() {
                                  waterCounter++;
                                });
                              },
                              () {
                                setState(() {
                                  if (waterCounter > 0) {
                                    waterCounter--;
                                  }
                                });
                              },
                            ),
                            buildCareInfoBlock(
                              'Spray every',
                              Icons.water_damage,
                              sprayCounter,
                              () {
                                setState(() {
                                  sprayCounter++;
                                });
                              },
                              () {
                                setState(() {
                                  if (sprayCounter > 0) {
                                    sprayCounter--;
                                  }
                                });
                              },
                            ),
                            buildCareInfoBlock(
                              'Prune every',
                              Icons.shower,
                              pruneCounter,
                              () {
                                setState(() {
                                  pruneCounter++;
                                });
                              },
                              () {
                                setState(() {
                                  if (pruneCounter > 0) {
                                    pruneCounter--;
                                  }
                                });
                              },
                            ),
                            buildCareInfoBlock(
                              'Fertilize every',
                              Icons.eco,
                              fertiliseCounter,
                              () {
                                setState(() {
                                  fertiliseCounter++;
                                });
                              },
                              () {
                                setState(() {
                                  if (fertiliseCounter > 0) {
                                    fertiliseCounter--;
                                  }
                                });
                              },
                            ),
                            buildCareInfoBlock(
                              'Rotate every',
                              Icons.refresh,
                              rotateCounter,
                              () {
                                setState(() {
                                  rotateCounter++;
                                });
                              },
                              () {
                                setState(() {
                                  if (rotateCounter > 0) {
                                    rotateCounter--;
                                  }
                                });
                              },
                            ),
                            buildCareInfoBlock(
                              'Clean every',
                              Icons.cleaning_services,
                              cleanCounter,
                              () {
                                setState(() {
                                  cleanCounter++;
                                });
                              },
                              () {
                                setState(() {
                                  if (cleanCounter > 0) {
                                    cleanCounter--;
                                  }
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  PlantProvider plantProvider =
                                      Provider.of<PlantProvider>(context,
                                          listen: false);


                                  widget.plant.waterCounter = waterCounter;
                                  widget.plant.sprayCounter = sprayCounter;
                                  widget.plant.pruneCounter = pruneCounter;
                                  widget.plant.fertiliseCounter =
                                      fertiliseCounter;
                                  widget.plant.rotateCounter = rotateCounter;
                                  widget.plant.cleanCounter = cleanCounter;
                                  widget.plant.lastWatering = lastWatering;
                                  widget.plant.lastSpraying = lastSpraying;
                                  widget.plant.lastPruning = lastPruning;
                                  widget.plant.lastFertilizing = lastFertilizing;
                                  widget.plant.lastRotation = lastRotation;
                                  widget.plant.lastCleaning = lastCleaning;


                                  //add last update here
                                  plantProvider.updatePlant(widget.plant);

                                  Navigator.push(context,
                                      SlidePageRoute(page: SetupHW1()));
                                },
                                child: Text(
                                  'Setup Hardware',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFFF5D256)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                          color: Colors.white,
                                          width: 2), // Border color
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Center(
                              child: GestureDetector(
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
              color: Color(0xFFA3D761),
            ),
          ),
          Positioned(
            top: screenHeight - cardBottomPosition,
            left: 0,
            right: 0,
            child: Container(
              height: 10,
              color: Color(0xFFA3D761),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCareInfoBlock(
    String title,
    IconData icon,
    int counter,
    VoidCallback incrementCallback,
    VoidCallback decrementCallback,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 3,
            ),
            Container(
              width: 160,
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: Color(0xFF2C6103),
                  ),
                  SizedBox(width: 3),
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, color: Color(0xFF2C6103)),
                  ),
                ],
              ),
            ),
            Spacer(),
            IconButton(
              icon: Icon(Icons.arrow_upward, color: Colors.green),
              onPressed: incrementCallback,
            ),
            Text(
              '$counter',
              style: TextStyle(fontSize: 16, color: Color(0xFF2C6103)),
            ),
            IconButton(
              icon: Icon(Icons.arrow_downward, color: Colors.red),
              onPressed: decrementCallback,
            ),
          ],
        ),
      ),
    );
  }
}
