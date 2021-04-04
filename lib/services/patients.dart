import 'package:flutter/material.dart';
import '../components/drawer.dart';
import '../classes/Patients.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dart:async';
import 'dart:io';
import 'package:paintrecognition/classes/Settings.dart';

class PatientsRest extends StatefulWidget {
  @override
  _PatientsRestState createState() => _PatientsRestState();
}

class _PatientsRestState extends State<PatientsRest> {

  Setting conf= new Setting();
  String myip='';

  Future getData() async {
    //String IP=conf.getServerIP();
    //print("IP:"+IP);


    var url="http://"+Setting.getServerIP()+":5000/patients";
    print("URL 1:"+url);
    var response = await http.get(url,headers: {'Connection': "Keep-Alive"},);
    var responseBody = jsonDecode(response.body);
   // responseBody=[{"birthday":"2010-02-05","father_name":"\u0633\u0645\u064a\u0631\n","first_name":"skatouls","gender":"male","id":2.0,"last_name":"\u0627\u0644\u062e\u0631\u0633\u0627\n"},{"birthday":"2003-05-09","father_name":"\u0633\u0645\u064a\u0631","first_name":"sam","gender":"\u0627\u0646\u062b\u0649","id":3.0,"last_name":"male"},{"birthday":"2010-07-01","father_name":"arxidis","first_name":"skatouls5","gender":"male","id":4.0,"last_name":"\u0627\u0644\u062e\u0631\u0633\u0627"}];

    return responseBody;
  }

  @override
  void initState() {


    getData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    conf.loadMyIP().then((value){
      myip= value;
      print("IP 1:"+value);

    });
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor:  Colors.deepPurple.withOpacity(0.2),
              title: Text("المراجعين"),
            ),
            drawer: MyDrawer(),
            body: FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return Patients(
                            patient_id: snapshot.data[i]['id'],
                            firstname: snapshot.data[i]['first_name'],
                            lastname: snapshot.data[i]['last_name'],
                            birthday: snapshot.data[i]['birthday'],
                            gender: snapshot.data[i]['gender'],
                            father_name: snapshot.data[i]['father_name']
                        );


                      });
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
        ));
  }
}
