import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/animations/jumpinglogo2.dart';
import 'package:plantopia/pages/careinfo.dart';
import 'package:plantopia/pages/results.dart';
import 'package:plantopia/pages/home.dart';
import 'package:plantopia/pages/monitor.dart';
import 'package:plantopia/pages/notifications.dart';
import 'package:plantopia/pages/settings.dart';
import 'package:plantopia/providers/plant_provider.dart';
import 'package:plantopia/classes/plantclass.dart';
import 'package:provider/provider.dart';

class Profile extends StatelessWidget {
  final String plantId;

  Profile({required this.plantId});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardTopPosition = 70.0;
    double cardBottomPosition = 40.0;
    double cardHeight = screenHeight - cardTopPosition - cardBottomPosition;
    // Fetch plant details using the plantId
    final PlantProvider plantProvider = Provider.of<PlantProvider>(context);
    final Plant? plant = plantProvider.findPlantById(plantId);

    if (plant == null) {
      // Handle case when plant is not found
      return Scaffold(
        body: Center(
          child: Text('Plant not found!'),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background2.jpg'),
                fit: BoxFit.cover,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.leaf,
                              color: Colors.green, size: 40),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                plant.name,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: 70,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () =>  Navigator.push(context, SlidePageRoute(page: Results())),
                              child: OverlappingMenuButton(
                                imagePath: 'assets/images/camera.jpg',
                                icon: FontAwesomeIcons.camera,
                                text: 'Camera',
                                backgroundColor: Colors.orange,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 170,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => Navigator.push(context, SlidePageRoute(page: CareInfo(plantId: plant.id))),
                              child: OverlappingMenuButton(
                                imagePath: 'assets/images/careinfo.jpg',
                                icon: FontAwesomeIcons.infoCircle,
                                text: 'Care Info',
                                backgroundColor: Colors.blue,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 270,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => Navigator.push(context, SlidePageRoute(page: Monitor(plantId: plant.id))),
                              child: OverlappingMenuButton(
                                imagePath: 'assets/images/monitor.jpeg',
                                icon: FontAwesomeIcons.wifi,
                                text: 'Monitor',
                                backgroundColor: Colors.teal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0,
                      color: Colors.green,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Color(0xFF8EAC4E),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60.0),
                          topRight: Radius.circular(60.0),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(FontAwesomeIcons.bell,
                                    color: Colors.white, size: 30),
                                onPressed: () => Navigator.push(context,
                                    SlidePageRoute(page: Notifications())),
                              ),
                              Text('Notifications',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Kavoon')),
                            ],
                          ),
                          SizedBox(
                            width: 47,
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(FontAwesomeIcons.home,
                                    color: Colors.white, size: 30),
                                onPressed: () => Navigator.push(
                                    context, SlidePageRoute(page: Home())),
                              ),
                              Text('Home',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Kavoon')),
                            ],
                          ),
                          SizedBox(
                            width: 73,
                          ),
                          Column(
                            children: [
                              IconButton(
                                icon: Icon(FontAwesomeIcons.cog,
                                    color: Colors.white, size: 30),
                                onPressed: () => Navigator.push(
                                    context,
                                    SlidePageRoute(
                                        page: Settings(plantId: plant.id))),
                              ),
                              Text('Settings',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Kavoon')),
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

class OverlappingMenuButton extends StatelessWidget {
  final String imagePath;
  final IconData icon;
  final String text;
  final Color backgroundColor;

  const OverlappingMenuButton({
    Key? key,
    required this.imagePath,
    required this.icon,
    required this.text,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.white),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: backgroundColor, size: 24),
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

