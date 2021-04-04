import 'package:flutter/material.dart';
import 'package:paintrecognition/services/visits.dart';
//import '../components/drawer.dart';

class Patients extends StatelessWidget {
  final patient_id;
  final firstname;
  final lastname;
  final birthday;
  final gender;
  final father_name;
  Patients({
    this.patient_id,this.firstname,this.birthday,this.lastname,this.gender,this.father_name
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(20), // if you need this
        side: BorderSide(
          color: Colors.grey.withOpacity(0.8),
          width: 1,
        ),
      ),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(5),


        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: <Widget>[

                Container(

                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left:5),
                        child: Text(
                          "الاسم:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left:10),
                        child: Text(
                          this.firstname,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left:5),
                        child: Text(
                          "الكنية:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left:10),
                        child: Text(
                          this.lastname,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ) ,
                      Container(
                        padding: EdgeInsets.only(left:10),
                        child: Text(
                          "الأب:",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueGrey,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          this.father_name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueGrey,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

              ],
            ),
            Row(
              mainAxisAlignment:MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "تاريخ الميلاد :",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(
                  this.birthday,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "الجنس :",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(
                  this.gender,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "اسم الاب :",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Text(
                  this.father_name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blueGrey,
                  ),
                )
              ],
            ),
            Container(
                padding: EdgeInsets.only(right: 20),
                child: Row(
                  children: <Widget>[
                   //  here we need a link to visits
                    FlatButton.icon(
                      textColor: Color(0xFF6200EE),

                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VisitsRest(patient_id: this.patient_id,patient_name: this.firstname+" "+this.lastname),
                          ),
                        );
                        // use patient_id here or in onTap
                        // Respond to button press
                      },
                      icon: Icon(Icons.style, size: 25),
                      label: Text("الزيارات",style: TextStyle(
                          fontSize: 20,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold
                      )),
                    ),

                  ],
                ))
          ],
        ),
      ),

    );
  }
}


