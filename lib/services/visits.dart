//import 'dart:html';

import 'package:flutter/material.dart';

import 'package:paintrecognition/classes/Visits.dart';
import 'package:paintrecognition/components/date_picker.dart';
import 'package:dio/dio.dart';

import '../components/drawer.dart';
import '../classes/Visits.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:paintrecognition/classes/Settings.dart' ;

class VisitsRest extends StatefulWidget {
  final patient_id;
  final patient_name;

  // VisitsRest(this.patient_id, {patientid}) : super();
  VisitsRest({Key key, @required this.patient_id, this.patient_name})
      : super(key: key);

  @override
  _VisitsRestState createState() => _VisitsRestState(patient_id, patient_name);
}

class _VisitsRestState extends State<VisitsRest> {
  _VisitsRestState(this.patient_id, this.patient_name);

  final patient_id;
  final patient_name;
  final _formKey = GlobalKey<FormState>();
  int _user;
  Setting conf= new Setting();
  String myip='';
  DateTime selectedDate = DateTime.now();

  //final String endPoint = 'http://' +set.getServerIP()+':5000/visits';
  var users = <String>[
    'آخر',
    'الأب',
    'الأم',
  ];

  String patient_visit_date;
  String patient_visit_state;
  String patient_visit_company;
  String patient_visit_desc;

  Future getData() async {


    var url = "http://" +Setting.getServerIP()+":5000/get_visits_with_img/$patient_id";
    //http.head(url)

    var response = await http.get(url);
    var responseBody = jsonDecode(response.body);

    return responseBody;
  }

  @override
  void initState() {

    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple.withOpacity(0.2),
            title: Text("زيارات المريض $patient_name"),
          ),
          drawer: MyDrawer(),
          body: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot visitsarr) {
              if (visitsarr.hasData) {
                return ListView.builder(
                    itemCount: visitsarr.data.length,
                    itemBuilder: (context, i) {
                      return Visits(
                          idpatient_visits: visitsarr.data[i]
                              ['idpatient_visits'],
                          patient_visit_company: visitsarr.data[i]
                              ['patient_visit_company'],
                          patient_visit_date: visitsarr.data[i]
                              ['patient_visit_date'],
                          patient_visit_desc: visitsarr.data[i]
                              ['patient_visit_desc'],
                          patient_visit_pain_degree: visitsarr.data[i]
                              ['patient_visit_pain_degree'],
                          patient_visit_state: visitsarr.data[i]
                              ['patient_visit_state'],
                          patient_visits_image: visitsarr.data[i]
                              ['patient_visits_image']);
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: newVisit,
            tooltip: 'مراجعة جديدة',
            child: Icon(Icons.add_business_outlined),
          ),
        ));
  }
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      initialEntryMode: DatePickerEntryMode.input,
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
     {
       selectedDate = picked;
       setState(() {

       });
       patient_visit_date="${selectedDate.toLocal()}".split(' ')[0];
     }
  }
  void saveNewVisit() async {

    FormData data = FormData.fromMap({
      "patient_visit_date": patient_visit_date,
      "patient_visit_state": patient_visit_state,
      "patient_visit_company": patient_visit_company,
      "patient_visit_patient_id": patient_id.toString(),
      "patient_visit_desc":patient_visit_desc
    });
    Dio dio = new Dio();
    String endPoint='http://' +Setting.getServerIP()+':5000/visits';

    dio.post(endPoint, data: data).then((response) {
      if(response.statusCode==400)
        {
          print("Error");
        }
      if(response.statusCode==200)
        print('YES');
      var jsonResponse = jsonDecode(response.toString());
   //   degree=jsonResponse['degree'].toString();
      setState(() {

      });

      // var averageGrindSize = jsonResponse[''];
    }).catchError((error) => print(error));
  }

  Future newVisit() async {
    return await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.only(left: 25, right: 25),
          title: Center(child: Text("اضافة زيارة")),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Directionality(
                  textDirection: TextDirection.rtl,
                  child: SingleChildScrollView(
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            TextFormField(

                              cursorColor: Colors.black,
                              decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: 'الحالة'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "يجب ادخال وصف الحالة";
                                }else
                                  {
                                    patient_visit_state=value;
                                  }
                                return null;
                              },

                            ),
                            Row(
                              children: [
                                Text(' المرافق  :  '),
                                DropdownButton<String>(
                                  value: _user == null ? null : users[_user],
                                  onChanged: (newValue) {
                                    patient_visit_company=newValue;
                                    setState(() {
                                      _user = users.indexOf(newValue);

                                    });
                                    //  _user = users.indexOf(newValue);
                                  },
                                  hint: Text(
                                    "اختيار المرافق",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  items: users.map((String value) {
                                    return new DropdownMenuItem<String>(
                                      value: value,
                                      child: new Text(value),
                                    );
                                  }).toList(),

                                  // value: _value,
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                           //   mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "${selectedDate.toLocal()}".split(' ')[0],
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                RaisedButton(
                                  onPressed: () => _selectDate(context),
                                  // Refer step 3
                                  child: Text(
                                    'تاريخ الزيارة',
                                    style:
                                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.pink,
                                ),
                              ],
                            ),
                            TextFormField(
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              decoration: new InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: 15, bottom: 11, top: 11, right: 15),
                                  hintText: 'معلومات اضافية'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return '';
                                }else
                                  {
                                    patient_visit_desc=value;
                                  }
                                return null;
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                                  children: [
                                    ElevatedButton(

                                      onPressed: () {
                                        // Validate returns true if the form is valid, or false
                                        // otherwise.
                                        if (_formKey.currentState.validate()) {
                                          // If the form is valid, display a Snackbar.
                                          print(patient_visit_date);
                                          print(patient_visit_desc);
                                          print(patient_visit_state);
                                          print(patient_visit_company);
                                          saveNewVisit();
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text('اضافة'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('الغاء'),
                                    ),
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            },
          ),
        );
      },
    );
  }
}
