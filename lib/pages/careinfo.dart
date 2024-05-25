import 'package:flutter/material.dart';
import 'package:plantopia/animations/jumpinglogo2.dart';
import 'package:plantopia/classes/careinfoclass.dart';
import 'package:plantopia/classes/plantclass.dart';
import 'package:plantopia/providers/plant_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CareInfo extends StatefulWidget {
  final String plantId;

  CareInfo({required this.plantId});

  @override
  _CareInfoScreenState createState() => _CareInfoScreenState();
}

class _CareInfoScreenState extends State<CareInfo> {
  final ImagePicker _picker = ImagePicker();
  String? _selectedImagePath;

  Future<void> _selectImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  List<CareInfoModel> careInfoList = [
    CareInfoModel(
      title: 'Next Watering',
      icon: Icons.opacity,
      daysLeft: 0,
      maxDays: 0,
    ),
    CareInfoModel(
      title: 'Next Spraying',
      icon: Icons.water_damage,
      daysLeft: 0,
      maxDays: 0,
    ),
    CareInfoModel(
      title: 'Next Pruning',
      icon: Icons.shower,
      daysLeft: 0,
      maxDays: 0,
    ),
    CareInfoModel(
      title: 'Next Fertilizing',
      icon: Icons.eco,
      daysLeft: 0,
      maxDays: 0,
    ),
    CareInfoModel(
      title: 'Next Rotation',
      icon: Icons.refresh,
      daysLeft: 0,
      maxDays: 0,
    ),
    CareInfoModel(
      title: 'Next Cleaning',
      icon: Icons.cleaning_services,
      daysLeft: 0,
      maxDays: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardTopPosition = 70.0;
    double cardBottomPosition = 40.0;
    double cardHeight = screenHeight - cardTopPosition - cardBottomPosition;
    return FutureBuilder<Plant?>(
      future:
          Provider.of<PlantProvider>(context).fetchPlantById(widget.plantId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          Plant? selectedPlant = snapshot.data;

          if (selectedPlant == null) {
            return Scaffold(
              body: Center(
                child: Text('Plant not found!'),
              ),
            );
          }

          for (var info in careInfoList) {
            int maxDays;
            DateTime lastUpdated;
            switch (info.title) {
              case 'Next Watering':
                maxDays = selectedPlant.waterCounter;
                lastUpdated = selectedPlant.lastWatering;
                break;
              case 'Next Spraying':
                maxDays = selectedPlant.sprayCounter;
                lastUpdated = selectedPlant.lastSpraying;
                break;
              case 'Next Pruning':
                maxDays = selectedPlant.pruneCounter;
                lastUpdated = selectedPlant.lastPruning;
                break;
              case 'Next Fertilizing':
                maxDays = selectedPlant.fertiliseCounter;
                lastUpdated = selectedPlant.lastFertilizing;
                break;
              case 'Next Rotation':
                maxDays = selectedPlant.rotateCounter;
                lastUpdated = selectedPlant.lastRotation;
                break;
              case 'Next Cleaning':
                maxDays = selectedPlant.cleanCounter;
                lastUpdated = selectedPlant.lastCleaning;
                break;
              default:
                maxDays = 3;
                lastUpdated = DateTime.now();
            }
            info.maxDays = maxDays;

            if (info.daysLeft == 0) {
              info.daysLeft = maxDays;
            }

            int daysDifference = DateTime.now().difference(lastUpdated).inDays;
            info.daysLeft -= daysDifference;
          }

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
                      color: Color(0xFFF3F8EC),
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
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Color(0xFF205724),
                                        width: 2,
                                      ),
                                    ),
                                    child: Image.asset(
                                      "assets/images/back.png",
                                      width: 24,
                                      height: 24,
                                      color: Color(0xFF205724),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 80),
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
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Container(
                                    height: 190,
                                    width: 200,
                                    padding: EdgeInsets.all(20),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFDFE6D6),
                                      borderRadius: BorderRadius.circular(80),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 25,
                                        ),
                                        if (selectedPlant.imagePath != null)
                                          Image.file(
                                            File(selectedPlant.imagePath!),
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          )
                                        else
                                          Icon(
                                            Icons.image,
                                            size: 100,
                                            color: Colors.grey,
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Column(
                                    children: careInfoList
                                        .map((info) => buildCareInfoBlock(
                                            info, selectedPlant))
                                        .toList(),
                                  ),
                                  SizedBox(height: 30),
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
                    color: Color(0xFFC5E79A),
                  ),
                ),
                Positioned(
                  top: screenHeight - cardBottomPosition,
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
      },
    );
  }

  Future<void> updateCareInfo(Plant plant, String careInfoType) async {
    final plantProvider = Provider.of<PlantProvider>(context, listen: false);
    DateTime now = DateTime.now();

    // Update the specific care info variable based on the careInfoType
    switch (careInfoType) {
      case 'Next Watering':
        plant.waterCounter = plant.waterCounter; // Update water counter if needed
        plant.lastWatering = now; // Update last watering
        break;
      case 'Next Spraying':
        plant.sprayCounter = plant.sprayCounter; // Update spray counter if needed
        plant.lastSpraying = now; // Update last spraying
        break;
      case 'Next Pruning':
        plant.pruneCounter = plant.pruneCounter; // Update prune counter if needed
        plant.lastPruning = now; // Update last pruning
        break;
      case 'Next Fertilizing':
        plant.fertiliseCounter = plant.fertiliseCounter; // Update fertilize counter if needed
        plant.lastFertilizing = now; // Update last fertilizing
        break;
      case 'Next Rotation':
        plant.rotateCounter = plant.rotateCounter; // Update rotate counter if needed
        plant.lastRotation = now; // Update last rotation
        break;
      case 'Next Cleaning':
        plant.cleanCounter = plant.cleanCounter; // Update clean counter if needed
        plant.lastCleaning = now; // Update last cleaning
        break;
      default:
        break;
    }

    // Update the changes in Firestore
    await plantProvider.updatePlant(plant);
  }


  Widget buildCareInfoBlock(CareInfoModel info, Plant plant) {
    double progress = info.daysLeft / info.maxDays;
    double visualProgress;
    String status;
    Color progressColor;

    if (info.daysLeft == 0) {
      visualProgress = 0.2;
      status = 'Today';
      progressColor = Color(0xFF76C736); // Green
    } else {
      if (progress > 0) {
        visualProgress = 0.2 + (0.8 * progress);
      } else {
        visualProgress = 0.1 * progress.abs();
      }
      if (info.daysLeft < 0) {
        status = '${info.daysLeft.abs()} days late';
        progressColor = Color(0xFFC77336); // Red
      } else {
        status = '${info.daysLeft} days left';
        progressColor = Color(0xFF76C736); // Green
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE8F0DE), // Background color
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white), // White border
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 3),
                Container(
                  width: 150,
                  child: Row(
                    children: [
                      Icon(
                        info.icon,
                        color: Color(0xFF1C8D29),
                      ),
                      SizedBox(width: 3),
                      Text(
                        info.title,
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF1C8D29)),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 22),
                SizedBox(
                  height: 25,
                  width: 120,
                  child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFF8C8A72),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: visualProgress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: progressColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          status,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.check_box_outline_blank_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      info.daysLeft = info.maxDays;
                    });
                    updateCareInfo(plant, info.title);
                  },
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
