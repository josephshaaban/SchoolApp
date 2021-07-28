import 'dart:convert';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;

class Item2Screen extends StatefulWidget {
  @override
  _Item2ScreenState createState() => _Item2ScreenState();
}

class _Item2ScreenState extends State<Item2Screen> {

  int school_Id;
  int student_id;
  int classId;
  List<ExamData> _exam = <ExamData>[];
  List<ExamData> _items = <ExamData>[];

  Future<List<ExamData>> fetchData() async{
    var response =await http.get(Uri.parse('https://school-node-api.herokuapp.com/api/exam/$student_id'));
    var items= <ExamData>[];
    if (response.statusCode == 200 ){
      var dataJson= json.decode(response.body);
      for (var dataJson in dataJson){
        items.add(ExamData.fromJson(dataJson));
      }
    }
    return items;
  }

  Future<List<ExamData>> fetchData1() async{
    var response1 =await http.get(Uri.parse('https://school-node-api.herokuapp.com/api/exam/$student_id'));
    var exam= <ExamData>[];
    if( response1.statusCode==200){
      var dataJson1 = json.decode(response1.body);
      for(var dataJson1 in dataJson1){
        exam.add(ExamData.fromJson(dataJson1));
      }
    }
    return exam;
  }

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
        _items.addAll(value);
      });
    });
    super.initState();
    getStudentData();
    fetchData1().then((value){
      setState(() {
        _exam.addAll(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:ReusableWidgets.getAppBar('آخر الأخبار'),
        body:Column(
      children:[
        Expanded(child: FutureBuilder(
          future: fetchData() ,
          builder: (context, snapshot1) {
            if (snapshot1.hasData) {
              return ListView.builder(itemBuilder: (context,index){
                ExamData myproject = snapshot1.data[index];
                return Container(
                    child:   Column(
                        children:[
                          Text(myproject.examMaterial),
                          Text(myproject.examClassroom),
                          Text(myproject.examNote),
                          Text(myproject.examDate)
                       ]));
              },
                  itemCount: snapshot1.data.length
              );
            }
            else{
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
            }
          },
        )),
        Expanded(child:FutureBuilder(
         future: fetchData() ,
          builder: (context, snapshot1) {
         if (snapshot1.hasData) {
          return ListView.builder(itemBuilder: (context,index){
            ExamData myproject = snapshot1.data[index];
            return Container(
                child:   Column(
                    children:[
                      Text(myproject.examMaterial),
                      Text(myproject.examClassroom),
                      Text(myproject.examNote),
                      Text(myproject.examDate)
                    ]));
            },
              itemCount: snapshot1.data.length
          );
        }
        else{
        // By default, show a loading spinner.
          return const CircularProgressIndicator();
        }
        },
       )),
        Expanded(child:FutureBuilder(
          future: fetchData() ,
          builder: (context, snapshot1) {
            if (snapshot1.hasData) {
              return ListView.builder(itemBuilder: (context,index){
                ExamData myproject = snapshot1.data[index];
                return Card(
                    child:   Column(
                        children:[
                          Text(myproject.examMaterial),
                          Text(myproject.examClassroom),
                          Text(myproject.examNote),
                          Text(myproject.examDate)
                        ]));
              },
                  itemCount: snapshot1.data.length
              );
            }
            else{
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }
          },
        ))
      ]));
  }
}


