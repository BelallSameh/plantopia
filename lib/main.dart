import 'package:flutter/material.dart';
import 'package:plantopia/pages/Welcome.dart';
import 'package:plantopia/pages/signup.dart';
import 'package:plantopia/pages/T&C.dart';
import 'package:plantopia/pages/T&C2.dart';
import 'package:plantopia/pages/home.dart';
import 'package:plantopia/pages/addplant.dart';
import 'package:plantopia/pages/UserManual1.dart';
import 'package:plantopia/pages/UserManual2.dart';
import 'package:plantopia/pages/UserManual3.dart';
import 'package:plantopia/pages/UserManual4.dart';
import 'package:plantopia/pages/SetupHW1.dart';
import 'package:plantopia/pages/SetupHW2.dart';
import 'package:plantopia/pages/SetupHW3.dart';
import 'package:plantopia/pages/SetupHW4.dart';
import 'package:plantopia/pages/SetupHW5.dart';
import 'package:provider/provider.dart';
import 'package:plantopia/providers/plant_provider.dart';
import 'package:plantopia/providers/notification_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gemini/flutter_gemini.dart';


void main ()async{
  Gemini.init(apiKey: ''); // my api key
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PlantProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) =>  Welcome(),
          '/signup': (context) => SignUp(),
          '/t&c': (context) => TC(),
          '/t&c2': (context) => TC2(),
          '/home': (context) => Home(),
          '/addplant' : (context) => AddPlant(),
          '/usermanual1': (context) =>  UserManual1(),
          '/usermanual2' : (context) =>  UserManual2(),
          '/usermanual3' : (context) =>  UserManual3(),
          '/usermanual4' : (context) =>  UserManual4(),
          '/setuphw1' : (context) =>  SetupHW1(),
          '/setuphw2' : (context) =>  SetupHW2(),
          '/setuphw3' : (context) =>  SetupHW3(),
          '/setuphw4' : (context) =>  SetupHW4(),
          '/setuphw5' : (context) =>  SetupHW5(),
        },
      ),
    );
  }
}
