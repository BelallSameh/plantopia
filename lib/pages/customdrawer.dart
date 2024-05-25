import 'package:flutter/material.dart';
import 'package:plantopia/animations/SlidingPage.dart'; // Import SlidePageRoute
import 'package:plantopia/pages/home.dart'; // Import Home page
import 'package:plantopia/pages/notifications.dart'; // Import Notifications page
import 'package:plantopia/pages/contactus.dart'; // Import Contact Us page
import 'package:plantopia/pages/welcome.dart'; // Import Contact Us page

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background2.jpg'), // Replace with your background image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width *
                0.7, // Adjust the width as needed
            child: Drawer(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green, // Set drawer background color to green
                  borderRadius: BorderRadius.only(
                    topRight:
                        Radius.circular(30), // Increase radius for top right
                    bottomRight:
                        Radius.circular(30), // Increase radius for bottom right
                  ),
                  border: Border.all(
                    color: Colors.white, // Set white border color
                    width: 2, // Set border width
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 50, // Adjust height as needed
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Close drawer on tap
                          },
                          child: Image.asset(
                            'assets/images/back.png', // Replace with your image path
                            width: 30, // Adjust width as needed
                            height: 30, // Adjust height as needed
                            color: Colors.white, // Set the color of the image
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.home,
                          color: Colors.white, size: 40), // Increase icon size
                      title: Text('Home',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white)), // Increase text size
                      onTap: () {
                        Navigator.push(
                          context,
                          SlidePageRoute(page: Home()),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.notifications,
                          color: Colors.white, size: 40), // Increase icon size
                      title: Text('Notifications',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white)), // Increase text size
                      onTap: () {
                        Navigator.push(
                          context,
                          SlidePageRoute(page: Notifications()),
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.contact_phone,
                          color: Colors.white, size: 40), // Increase icon size
                      title: Text('Contact us',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white)), // Increase text size
                      onTap: () {
                        Navigator.push(
                          context,
                          SlidePageRoute(
                              page:
                                  ContactUs()), // Assuming you have a ContactUs page
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: Icon(Icons.exit_to_app,
                          color: Colors.white, size: 40), // Increase icon size
                      title: Text('Log out',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white)), // Increase text size
                      onTap: () {
                        Navigator.push(
                          context,
                          SlidePageRoute(
                              page:
                                  Welcome()), // Assuming you have a ContactUs page
                        );
                      },
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
