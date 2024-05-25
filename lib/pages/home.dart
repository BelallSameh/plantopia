import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/animations/jumpinglogo2.dart';
import 'package:plantopia/pages/addplant.dart';
import 'package:plantopia/pages/customdrawer.dart';
import 'package:plantopia/pages/profile.dart';
import 'package:plantopia/classes/plantclass.dart';
import 'package:plantopia/providers/plant_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
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
                            "Hi user!",
                            style: TextStyle(
                              color: Color(0xFF2C6103),
                              fontSize: 30,
                              fontFamily: 'Kavoon',
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "My Plants",
                        style: TextStyle(
                          color: Color(0xFF2C6103),
                          fontSize: 30,
                          fontFamily: 'Kavoon',
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: FutureBuilder(
                        future: Provider.of<PlantProvider>(context, listen: false).fetchPlants(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else {
                            return Consumer<PlantProvider>(
                              builder: (context, plantProvider, child) {
                                List<Plant> plants = plantProvider.plants;
                                return GridView.builder(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20,
                                  ),
                                  itemCount: plants.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index == plants.length) {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            SlidePageRoute(page: AddPlant()),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF5D256),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 80,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Add New Plant",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Kavoon',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Profile(plantId: plants[index].id),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Color(0xFFA3D761),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              plants[index].imagePath != null
                                                  ? Image.file(
                                                File(plants[index].imagePath),
                                                width: 80,
                                                height: 80,
                                              )
                                                  : Icon(
                                                Icons.image,
                                                size: 80,
                                                color: Colors.red,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                plants[index].name,
                                                style: TextStyle(
                                                  color: Color(0xFF314C1C),
                                                  fontSize: 18,
                                                  fontFamily: 'Kavoon',
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                );
                              },
                            );
                          }
                        },
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
}
