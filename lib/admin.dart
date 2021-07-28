import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'reusable.dart';

class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  int school_Id;
  int student_id;
  int classId;

  Future getStudentData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      school_Id = preferences.getInt('school_Id')??0;
      student_id=  preferences.getInt('student_id')??0;
      classId= preferences.getInt('classId')??0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () =>  SystemNavigator.pop(),
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: AppTheme.textColor,
                title: Text("المشرف",textDirection: TextDirection.rtl),
                actions: [
                  Padding(padding: EdgeInsets.all(8.0),
                      child: Container(
                          decoration: new BoxDecoration(color: AppTheme.textColor),
                          child: MyMaterialButton()
                      ))]),
         ));
  }
}