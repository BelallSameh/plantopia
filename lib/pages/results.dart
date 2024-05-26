import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:plantopia/animations/jumpinglogo2.dart'; // Import JumpingLogo2

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String _response = "";
  bool _isLoading = false;

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    setState(() {
      _image = image;
    });
  }

  Future<void> _sendRequest() async {
    if (_image == null) return;

    setState(() {
      _isLoading = true;
    });
    _response = '';
    try {
      final file = File(_image!.path);
      final gemini = Gemini.instance;
      gemini.textAndImage(
        text:
        "your task is to identify plant health issues with precision. Analyze any image of a plant or leaf I provide, and detect all abnormal conditions, whether they are diseases, pests, deficiencies, or decay. Respond strictly with the name of the condition identified, and nothing else—no explanations, no additional text. If a condition is unrecognizable, reply with 'Your plant looks healthy'. If the image is not plant-related, say 'Please pick another image'.",
        images: [file.readAsBytesSync()],
      ).then((value) {
        setState(() {
          _response = value?.content?.parts?.last.text ?? 'No response';
        });
      }).catchError((e) {
        log('textAndImageInput', error: e);
        setState(() {
          _response = 'Error: $e';
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Theme(
            data: Theme.of(context).copyWith(
              textTheme: TextTheme(
                subtitle1: TextStyle(color: Colors.white),
              ),
              iconTheme: IconThemeData(color: Colors.white),
              listTileTheme: ListTileThemeData(
                tileColor: Color(0xFFF5D256),
              ),
            ),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Photo Library'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
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
                          SizedBox(
                            width: 85,
                          ),
                          Text(
                            "Results",
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
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () => _showPicker(context),
                                child: Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Color(0xFFA3D761),
                                      width: 5,
                                    ),
                                  ),
                                  child: _image == null
                                      ? Icon(Icons.camera_alt,
                                      size: 50, color: Color(0xFFA3D761))
                                      : ClipOval(
                                    child: Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.cover,
                                      width: 150,
                                      height: 150,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 40),
                          Center(
                            child: ElevatedButton(
                              onPressed: _isLoading ? null : _sendRequest,
                              child: _isLoading
                                  ? CircularProgressIndicator()
                                  : Text('Detect'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFF5D256),
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontFamily: 'Kavoon',
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Health:",
                            style: TextStyle(
                              color: Color(0xFFE8C035),
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kavoon',
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              hintText: _response,
                              hintStyle: TextStyle(color: Colors.black),
                              fillColor: Colors.green[50],
                              filled: true,
                            ),
                            readOnly: true,
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
}
