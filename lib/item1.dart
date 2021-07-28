import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;


class ItemScreen extends StatefulWidget {
  @override
  _ItemScreenState createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {

  int school_Id;
  int student_id;
  int classId;

  List<ExamData> _examdata = <ExamData>[];

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
        _examdata.addAll(value);
      });
    });
    super.initState();
    getStudentData();
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
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:ReusableWidgets.getAppBar('درجات الطالب'),
     body:   FutureBuilder(
       future: fetchData() ,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(itemBuilder: (context,index){
                ExamData project = snapshot.data[0];
               int intMark = project.examMark;
               String mark = intMark.toString();
                return Container(
                  child : Column(
                    children: <Widget>[
                      Text(mark),
                      Text(project.examType),
                      Text(project.examNote),
                      Text(project.examMaterial),
                      Text(project.examClassroom),
                      Text(project.examDate)
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


