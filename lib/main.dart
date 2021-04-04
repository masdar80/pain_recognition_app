
import 'package:flutter/material.dart';
import 'package:paintrecognition/pages/homepage.dart';
import './services/patients.dart';
import './services/visits.dart';
import 'package:paintrecognition/classes/Settings.dart' ;
import 'components/camera.dart';
import 'package:permission_handler/permission_handler.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {



 // S
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AmesShop",
      theme: ThemeData(fontFamily: 'Cairo'),
      //home: httpTest(),
      //home: Home(),
      home: HomePage(),
      routes: {
        'homepage': (context) {
          return HomePage();
        },
        'patientrest': (context) {
          return PatientsRest();
        },
        'newpatient': (context) {
          return PatientsRest();
        },
        'paincheck': (context) {
          return PatientsRest();
        },
        'pain_measurement': (context) {
          return TakePhoto(visitId: -1);
        },
        'settings': (context) {
          return PatientsRest();
        }
      },//
    );
  }
}
