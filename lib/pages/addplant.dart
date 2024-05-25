import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantopia/animations/SlidingPage.dart';
import 'package:plantopia/animations/jumpinglogo2.dart';
import 'package:plantopia/pages/addcare.dart';
import 'package:plantopia/classes/plantclass.dart';
import 'package:plantopia/providers/plant_provider.dart';
import 'package:provider/provider.dart';
import 'package:plantopia/pages/customdrawer.dart';
import 'dart:io';

class AddPlant extends StatefulWidget {
  @override
  _AddPlantState createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  final ImagePicker _picker = ImagePicker();
  String? _selectedImagePath;
  TextEditingController _plantNameController = TextEditingController();

  Future<void> _selectImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  Future<void> _selectImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  void _addPlant(BuildContext context) {
    final String plantName = _plantNameController.text;
    final String imageUrl = _selectedImagePath ?? '';

    if (plantName.isEmpty || imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please provide both plant name and image')),
      );
      return;
    }

    Plant newPlant = Plant(name: plantName, imagePath: imageUrl);
    PlantProvider plantProvider =
        Provider.of<PlantProvider>(context, listen: false);

    plantProvider.addPlant(newPlant);

    Navigator.push(context, SlidePageRoute(page: AddCare(plant: newPlant)));
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
                            "Let's add a new plant!",
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
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.camera_alt,
                                    color: Colors.white, size: 30),
                                onPressed: _selectImageFromCamera,
                              ),
                              SizedBox(width: 20),
                              IconButton(
                                icon: Icon(Icons.photo_library,
                                    color: Colors.white, size: 30),
                                onPressed: _selectImageFromGallery,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _plantNameController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF5D256),
                          hintText: 'Enter plant\'s name',
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon:
                              Icon(Icons.local_florist, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF5D256),
                          hintText: 'Location',
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon:
                              Icon(Icons.location_on, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFF5D256),
                          hintText: 'Day planted',
                          hintStyle: TextStyle(color: Colors.white),
                          prefixIcon:
                              Icon(Icons.calendar_today, color: Colors.white),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                        ),
                        onTap: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: Color(0xFFF5D256),
                                  colorScheme: ColorScheme.light(
                                    primary: Color(0xFFF5D256),
                                    onPrimary: Colors.white,
                                    surface: Color(0xFFE8F0DE),
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          _addPlant(context);
                        },
                        child: Text(
                          'Add more care info',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFA3D761)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.white, width: 2),
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
                            border:
                                Border.all(color: Color(0xFF205724), width: 2),
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
