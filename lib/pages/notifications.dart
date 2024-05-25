import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:plantopia/animations/jumpinglogo2.dart';
import 'package:plantopia/classes/notification_class.dart';
import 'package:plantopia/providers/notification_provider.dart';
import 'package:plantopia/providers/plant_provider.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double cardTopPosition = 70.0;
    double cardBottomPosition = 40.0;
    double cardHeight = screenHeight - cardTopPosition - cardBottomPosition;
    return Scaffold(
      body: Consumer2<NotificationProvider, PlantProvider>(
        builder: (context, notificationProvider, plantProvider, _) {
          List<NotificationModel> notifications = notificationProvider.notifications;

          return Stack(
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
                              SizedBox(width: 20),
                              Text(
                                "Notifications",
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
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: notifications
                                    .map((notification) => buildNotification(
                                  icon: notification.icon,
                                  text:
                                  '${notificationProvider.getPlantNameFromId(notification.plantId, plantProvider.plants)} needs ${notification.careInfo}.',
                                ))
                                    .toList(),
                              ),
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
          );
        },
      ),
    );
  }

  Widget buildNotification({required IconData icon, required String text}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFF4D564),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
