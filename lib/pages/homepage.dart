
import 'package:flutter/material.dart';
import 'package:paintrecognition/classes/Settings.dart';
import 'package:paintrecognition/components/drawer.dart';
import 'package:permission_handler/permission_handler.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Setting conf= new Setting();
  @override
  Widget build(BuildContext context) {
    conf.loadMyIP().then((value){

      Setting.setServerIP(value);

      print("IP init:"+value);

    });
    return Directionality(
        textDirection: TextDirection.rtl,

        child:  Scaffold(

        appBar: AppBar(
          backgroundColor:  Colors.deepPurple.withOpacity(0.2),

        title: Text("الرئيسية"),
    ),
    drawer: MyDrawer(),
    body:Container(
        alignment: Alignment.center,
      width: MediaQuery.of(context).size.width ,
      //  color: Colors.lightGreen,

      child: ListView(
        children: [
          InkWell(
              child:Card(

            color: Colors.blueAccent.withOpacity(0.3),
            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(20), // if you need this
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                // color: Colors.lightGreen,
                width:  MediaQuery.of(context).size.width*0.85,
                height: 150,
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.bar_chart, color: Colors.deepPurple.withOpacity(0.5),size: 80,),
                  Text("قياس درجة الألم",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),

                  ],
                ),
            ),
          ),
          onTap: () {

    Navigator.of(context).pushNamed('pain_measurement');
    }),
          /*InkWell(
              child:Card(

                color: Colors.blueAccent.withOpacity(0.3),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(20), // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  // color: Colors.lightGreen,
                  width:  MediaQuery.of(context).size.width*0.85,
                  height: 150,
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.center,

                    children: <Widget>[
                      Icon(Icons.account_circle_outlined, color: Colors.deepPurple.withOpacity(0.5),size: 80,),
                      Text("مراجع جديد",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),

                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('patientvisits');
              }),*/
          InkWell(
              child:Card(

                color: Colors.blueAccent.withOpacity(0.3),
                shape: RoundedRectangleBorder(

                  borderRadius: BorderRadius.circular(20), // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.center,
                  // color: Colors.lightGreen,
                  width:  MediaQuery.of(context).size.width*0.85,
                  height: 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment:MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.library_books_sharp, color: Colors.deepPurple.withOpacity(0.5),size: 80,),
                      Text("سجل المراجعين",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30)),

                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pushNamed('patientrest');
              }),

        ],
      )
    )
        ),
    );
  }
}
