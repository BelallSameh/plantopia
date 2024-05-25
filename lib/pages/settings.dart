import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plantopia/animations/jumpinglogo2.dart';
import 'package:plantopia/pages/modifycare.dart';
import 'package:plantopia/pages/home.dart';
import 'package:plantopia/providers/plant_provider.dart';
import 'package:plantopia/animations/SlidingPage.dart';

class Settings extends StatefulWidget {
  final String plantId;

  Settings({required this.plantId});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<Settings> {
  bool _isNotificationEnabled = false;

  void _toggleNotification() {
    setState(() {
      _isNotificationEnabled = !_isNotificationEnabled;
    });
  }

  void _deletePlant() {
    Provider.of<PlantProvider>(context, listen: false)
        .deletePlantById(widget.plantId);
    Navigator.push(context, SlidePageRoute(page: Home()));
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
                color: Color(0xFFF8F9E9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                ),
                margin: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            width: 20,
                          ),
                          Text(
                            "Settings",
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 30),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                      SlidePageRoute(page: ModifyCare(selectedPlantId: widget.plantId))
                                  ),
                                  child: Container(
                                    width: 350,
                                    margin:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD7EBC1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: Colors.white),
                                    ),
                                    child: ListTile(
                                      title: Center(
                                        child: Text(
                                          'Modify Care Info',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.green),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 350,
                                  margin: EdgeInsets.symmetric(vertical: 16.0),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD7EBC1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: ListTile(
                                    title: Center(
                                      child: Text(
                                        'Notifications',
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.green),
                                      ),
                                    ),
                                    trailing: ElevatedButton(
                                      onPressed: _toggleNotification,
                                      child: Text(_isNotificationEnabled
                                          ? 'Disable'
                                          : 'Enable', style: TextStyle(color: Colors.white),),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _isNotificationEnabled
                                            ? Colors.red
                                            : Colors.green,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 350,
                                  margin: EdgeInsets.symmetric(vertical: 16.0),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFD7EBC1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.white),
                                  ),
                                  child: ListTile(
                                    title: Center(
                                      child: Text(
                                        'Delete Plant',
                                        style: TextStyle(
                                            fontSize: 22, color: Colors.green),
                                      ),
                                    ),
                                    onTap: _deletePlant,
                                  ),
                                ),
                              ],
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
}
