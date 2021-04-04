import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paintrecognition/classes/Settings.dart';

class TakePhoto extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final visitId;
  TakePhoto({Key key, @required this.visitId})
      : super(key: key);
  @override
  _TakePhotoState createState() => _TakePhotoState(visitId);
}

class _TakePhotoState extends State<TakePhoto> {
  _TakePhotoState(this.visitId);
  final visitId;
  File _image;
  String degree='';
  Setting conf= new Setting();

 // final String endPoint = 'http://'+Setting.Settings().server_ip+':5000/pain_degree';
 // final String  endPoint1 = "http://"+Setting.Settings().server_ip+":5000/visits/visit_id/"+visitId;
  final picker = ImagePicker();



  Future getImage() async {



   //final pickedFile = await picker.getImage(source: ImageSource.camera);
   File pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() async {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print("GOT ---------------- IT");

        _upload(_image,visitId);
        /*Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VisitsRest(patient_id: this.patient_visit_patient_id,patient_name: "اسم المريض "),
          ),
        );*/

      } else {
        print('لم يتم اختيار صورة');
      }
    });
  }

  void _upload(File file,visitId) async {
    String fileName = file.path
        .split('/')
        .last;
    print("file to upload");
    print(fileName);

    FormData data = FormData.fromMap({
      "patient_visits_image": await MultipartFile.fromFile(
        file.path,
        filename: fileName,
      ),
    });
    Dio dio = new Dio();

    print("visit id in:  ");
    print(visitId);
    if(visitId==-1)
      {
        String endPoint = 'http://'+Setting.getServerIP()+':5000/pain_degree';
        dio.post(endPoint, data: data).then((response) {
          var jsonResponse = jsonDecode(response.toString());
          //  var degree = jsonResponse['degree'];
          degree=jsonResponse['degree'].toString();

          setState(() {

          });
          print(degree);
          // var averageGrindSize = jsonResponse[''];
        }).catchError((error) => print(error));
      }else
        {
          dio.post("http://"+Setting.getServerIP()+":5000/update_visit_image/$visitId", data: data).then((response) {
            var jsonResponse = jsonDecode(response.toString());
            //  var degree = jsonResponse['degree'];
            degree=jsonResponse['degree'].toString();
            setState(() {

            });
            print("Degree:"+degree);
            // var averageGrindSize = jsonResponse[''];
          }).catchError((error) => print(error));
        }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التقاط صورة المريض'),
      ),
      body: Center(
          child: Column(
            children: [
              Container(

                child: _image == null
                    ? Text('No image selected.')
                    : Image.file(_image),),
              Column( children: [
                Text('درجة الألم'),
                Text(degree),
              ],)

            ],
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),

    );
  }
}