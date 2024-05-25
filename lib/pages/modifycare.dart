import 'package:flutter/material.dart';
import 'package:plantopia/animations/jumpinglogo2.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:plantopia/providers/plant_provider.dart';
import 'package:plantopia/classes/plantclass.dart';
import 'package:provider/provider.dart';

class ModifyCare extends StatefulWidget {
  final String selectedPlantId;

  ModifyCare({required this.selectedPlantId});

  @override
  _ModifyCareState createState() => _ModifyCareState();
}

class _ModifyCareState extends State<ModifyCare> {
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

  int waterCounter = 0;
  int sprayCounter = 0;
  int pruneCounter = 0;
  int fertiliseCounter = 0;
  int rotateCounter = 0;
  int cleanCounter = 0;

  @override
  void initState() {
    super.initState();

    // Initialize counters with the current plant's care data
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      PlantProvider plantProvider =
          Provider.of<PlantProvider>(context, listen: false);
      Plant? selectedPlant =
          await plantProvider.fetchPlantById(widget.selectedPlantId);

      if (selectedPlant != null) {
        setState(() {
          waterCounter = selectedPlant.waterCounter;
          sprayCounter = selectedPlant.sprayCounter;
          pruneCounter = selectedPlant.pruneCounter;
          fertiliseCounter = selectedPlant.fertiliseCounter;
          rotateCounter = selectedPlant.rotateCounter;
          cleanCounter = selectedPlant.cleanCounter;
          _selectedImagePath = selectedPlant.imagePath; // Set the image path
        });
      }
    });
  }

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
                          SizedBox(width: 20),
                          Text(
                            "Modify Care Info",
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
                              child: Column(
                                children: [
                                  if (_selectedImagePath != null)
                                    Image.file(
                                      File(_selectedImagePath!),
                                      height: 150,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    )
                                  else
                                    Icon(
                                      Icons.image,
                                      size: 100,
                                      color: Colors.grey,
                                    ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
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
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: ElevatedButton(
                                onPressed: () {
                                  updatePlantCareInfo();
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Update',
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

  void updatePlantCareInfo() async {
    PlantProvider plantProvider =
        Provider.of<PlantProvider>(context, listen: false);
    Plant? plant = await plantProvider.fetchPlantById(widget.selectedPlantId);
    if (plant != null) {
      Plant updatedPlant = Plant(
        id: plant.id,
        name: plant.name,
        imagePath: plant.imagePath,
        waterCounter: waterCounter,
        sprayCounter: sprayCounter,
        pruneCounter: pruneCounter,
        fertiliseCounter: fertiliseCounter,
        rotateCounter: rotateCounter,
        cleanCounter: cleanCounter,
      );
      await plantProvider.updatePlant(updatedPlant);
      // Update the counter values in Firestore
      await plantProvider.updatePlantCareCountersInFirestore(updatedPlant);
    }
  }
}
