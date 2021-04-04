import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:paintrecognition/components/camera.dart';
import 'package:paintrecognition/services/visits.dart';
import '../components/drawer.dart';

class Visits extends StatelessWidget {
  final idpatient_visits;
  final patient_visit_company;
  final patient_visit_date;
  final patient_visit_desc;
  final patient_visit_pain_degree;
  final patient_visit_patient_id;
  final patient_visit_state;
  final patient_visits_image;

  Visits(
      {this.idpatient_visits,
      this.patient_visit_company,
      this.patient_visit_date,
      this.patient_visit_desc,
      this.patient_visit_pain_degree,
      this.patient_visit_patient_id,
      this.patient_visit_state,
      this.patient_visits_image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),

      height: 500,
      width: MediaQuery.of(context).size.width ,
      decoration: BoxDecoration(border: Border.all(color: Colors.black,width: 5)),
      child: Container(
        child: Column(
          children: <Widget>[
            (this.patient_visits_image=='no image' ||this.patient_visits_image=='' ||this.patient_visits_image == null)?
            Container(

              //child: Text(this.patient_visits_image))
                width: 150,
                height: 150,
                child: Text("no image"),)
                :
            Container(

              //child: Text(this.patient_visits_image))
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  image: new DecorationImage(
                      fit: BoxFit.cover,
                      image:MemoryImage(base64Decode(this.patient_visits_image), scale: 0.5)),
                )),
            ElevatedButton.icon(
              icon: Icon(Icons.image),
              style:  ElevatedButton.styleFrom(
                primary: Colors.pink,
              ),
              label: Text('صورة جديدة'),
              onPressed: () {
                print("visit id:  ");
                print(idpatient_visits);
                // Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TakePhoto(visitId: idpatient_visits),
                  ),
                );

               // Navigator.of(context).pushNamed('pain_measurement');

              },

            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left:10),
                    child: Text(
                      "الحالة:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:25),
                    child: Text(

                      this.patient_visit_state,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left:10),
                    child: Text(
                      "تاريخ الزيارة :",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    child: Text(
                      this.patient_visit_date,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left:10),
                    child: Text(
                      "المرافق:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:25),
                    child: Text(

                      this.patient_visit_company,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:10),
                    child: Text(
                      "درجة الألم السجلة:",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left:25),
                    child: Text(

                      this.patient_visit_pain_degree.toString(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blueGrey,
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(top:20),
              child: Column(

                children: <Widget>[
                  Text(
                    "معلومات اضافية عن الزيارة",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    this.patient_visit_desc,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
