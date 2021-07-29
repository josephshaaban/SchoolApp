import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;


class Item6Screen extends StatefulWidget {
  @override
  _Item6ScreenState createState() => _Item6ScreenState();
}

class _Item6ScreenState extends State<Item6Screen> {

  int school_Id;
  int student_id;
  int classId;

  List<MediaData> _media = <MediaData>[];

  Future getStudentData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      school_Id = preferences.getInt('school_Id')??0;
      student_id=  preferences.getInt('student_id')??0;
      classId= preferences.getInt('classId')??0;
    });
  }

  @override
  void initState(){
    fetchData().then((value) {
      setState(() {
        _media.addAll(value);
      });
    });
    super.initState();
    getStudentData();
  }

  Future <List<MediaData>> fetchData() async {
    var response = await http.get(Uri.parse('https://school-node-api.herokuapp.com/api/userid/$student_id'));

    var media = <MediaData>[];

    if (response.body.isNotEmpty) {
      var dataJson = json.decode(response.body);
      for (var dataJson in dataJson) {
        media.add(MediaData.fromJson(dataJson));
      }
    }
    return media;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:ReusableWidgets.getAppBar('بنك الميديا'),
        body:   FutureBuilder(
          future: fetchData() ,
          builder: (context, snapshot1) {
            if (snapshot1.hasData) {
              return ListView.builder(itemBuilder: (context,index){
                MediaData myproject = snapshot1.data[0];
                return Padding(padding: EdgeInsets.only(top: 15),
                 child: Card(
                  color: Colors.white60,
                      child:   Column(
                      children:[
                        Padding(padding: EdgeInsets.only(bottom: 15,top: 15),
                    child:  Text('fileName:  '+myproject.fileName)),
                    Padding(padding: EdgeInsets.only(bottom: 15,top: 15),
                        child: Text('Image Url: '+ myproject.fileUrl))
                ])));
              },
                  itemCount: snapshot1.data.length
              );
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }
}


