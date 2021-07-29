import 'dart:convert';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;


class Item4Screen extends StatefulWidget {
  @override
  _Item4ScreenState createState() => _Item4ScreenState();
}

class _Item4ScreenState extends State<Item4Screen> {
  int student_id;
  int classId;

  List<ExamData> _examdata = <ExamData>[];

  Future getStudentData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      student_id=  preferences.getInt('student_id')??0;
      classId= preferences.getInt('classId')??0;
    });
  }

  Future <List<ExamData>> fetchData() async{
    var response =await http.get(Uri.parse('https://school-node-api.herokuapp.com/api/exam/$student_id'));
    var examdata= <ExamData>[];
    if (response.body.isNotEmpty){
      print(student_id);
      var dataJson= json.decode(response.body);
      for (var dataJson in dataJson){
        examdata.add(ExamData.fromJson(dataJson));
      }
    }
    return  examdata;
  }

  @override
  void initState(){
    fetchData().then((value) {
      setState(() {
        _examdata.addAll(value);
      });
    });
    super.initState();
    getStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:ReusableWidgets.getAppBar('درجات الطالب'),
        body:   FutureBuilder(
          future: fetchData() ,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context,index){
                ExamData project = snapshot.data[index];
                int intMark = project.examMark;
                String mark = intMark.toString();
                return Card(
                    borderOnForeground: true,
                    color: Colors.white60,
                    shape:RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child : Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: 10),
                            child: Text('examClassroom: '+project.examClassroom),),
                          Text('examMark: '+mark),
                          Text('examMaterial: '+project.examMaterial),
                          Text('examNote: '+project.examNote),
                          Text('examDate: '+project.examDate),
                          Padding(padding: EdgeInsets.only(bottom: 10),
                              child:Text('examType'+project.examType))
                        ]));
              },
                  itemCount: snapshot.data.length
              );
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }
}


