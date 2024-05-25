import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:plantopia/animations/jumpinglogo2.dart';
import 'package:plantopia/providers/plant_provider.dart';
import 'package:plantopia/classes/plantclass.dart';
import 'package:provider/provider.dart';

class Monitor extends StatefulWidget {
  final String plantId;

  Monitor({required this.plantId});
  @override
  _MonitorState createState() => _MonitorState();
}

class _MonitorState extends State<Monitor> {
  final ImagePicker _picker = ImagePicker();
  String? _selectedImagePath;

  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  String humidity = 'Loading...';
  String temperature = 'Loading...';
  String soilMoisture = 'Loading...';
  String waterLevel = 'Loading...';
  double waterlevel1 = 0;
  @override
  void initState() {
    super.initState();
    _fetchSensorData();
  }

  Future<void> _fetchSensorData() async {
    print("try");
    _databaseReference.child('sensors').onValue.listen((event) {
      DataSnapshot sensorsSnapshot = event.snapshot;
      if (sensorsSnapshot.hasChild('Humidity')) {
        var humidityValue = sensorsSnapshot.child('Humidity').value;
        setState(() {
          humidity = humidityValue != null ? '${humidityValue.toString()}%' : 'No Data';
        });
      }
    });

    _databaseReference.child('sensors/Temperature/').onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        temperature = data != null ? '${data.toString()}°C' : 'No Data';
      });
    });

    _databaseReference.child('sensors/SoilMoisture/').onValue.listen((event) {
      final data = event.snapshot.value;
      setState(() {
        soilMoisture = data != null && data == 1 ? 'Normal Soil' : 'Soil needs care';
      });
    });

    _databaseReference.child('sensors/WaterLevel/').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        waterlevel1 = double.parse(data.toString());
        double waterlevel2 = double.parse(waterlevel1.toStringAsFixed(1));
        setState(() {
          waterLevel = waterlevel2 < 20 ? 'Plant needs water' : 'Normal Water Level';
          waterLevel += ' ($waterlevel2%)';
        });
      } else {
        setState(() {
          waterLevel = 'No Data';
        });
      }
    });
  }

  Future<void> _selectImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardTopPosition = 70.0;
    double cardBottomPosition = 40.0;
    double cardHeight = screenHeight - cardTopPosition - cardBottomPosition;
    final PlantProvider plantProvider = Provider.of<PlantProvider>(context);
    final Plant? plant = plantProvider.findPlantById(widget.plantId);

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
            //bottom: 35,
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
                          SizedBox(width: 85,),
                          Text(
                            "Monitor",
                            style: TextStyle(
                              color: Color(0xFF2C6103),
                              fontSize: 20,
                              fontFamily: 'Kavoon',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    // Centered image in a round shape
                    Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                          image: plant != null && plant.imagePath != null
                              ? DecorationImage(
                            image: FileImage(File(plant.imagePath!)),
                            fit: BoxFit.cover,
                          )
                              : DecorationImage(
                            image: AssetImage("assets/images/plant.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                buildSquareWidget(
                                  icon: Icons.thermostat,
                                  title: "Room Temperature",
                                  subtitle: temperature,
                                  backgroundColor: Color(0xFFF0F7AA),
                                  textColor: Colors.green,
                                ),
                                buildSquareWidget(
                                  icon: Icons.water_drop,
                                  title: "Humidity",
                                  subtitle: humidity,
                                  backgroundColor: Color(0xFFCAF7BA),
                                  textColor: Colors.green,
                                ),
                              ],
                            ),
                            buildRectangleWidget(
                              icon: Icons.invert_colors,
                              title: "Water Level",
                              subtitle: waterLevel,
                              backgroundColor: Color(0xFFCEDDF3),
                              textColor: waterLevel.contains('needs water') ? Colors.red : Colors.green,
                            ),
                            buildRectangleWidget(
                              icon: Icons.grass,
                              title: "Soil",
                              subtitle: soilMoisture,
                              backgroundColor: Color(0xFFE3DBFB),
                              textColor: soilMoisture.contains('needs care') ? Colors.red : Colors.green,
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
            child: JumpingLogo2(), // Add JumpingLogo2 widget
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

  Widget buildSquareWidget({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      width: 160,
      height: 160,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Icon(icon, size: 18, color: textColor),
            ),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              subtitle,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRectangleWidget({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Container(
      width: double.infinity,
      height: 110,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundColor: Colors.white,
              child: Icon(icon, size: 18, color: textColor),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
