import 'dart:convert';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';
import 'chatPage.dart';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;

class TeachersList extends StatefulWidget {
  @override
  _TeachersListState createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
  List<Teacher> _teachers = <Teacher>[];

  Future<List<Teacher>> fetchData() async {
    var response =
    await http.get(Uri.parse('https://school-node-api.herokuapp.com/api/teacher/1'));
    var teachers = <Teacher>[];

    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      for (var dataJson in dataJson) {
        teachers.add(Teacher.fromJson(dataJson));
      }
    }
    return teachers;
  }

  @override
  void initState() {
    fetchData().then((value) {
      setState(() {
        _teachers.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableWidgets.getAppBar('المشرفين'),
        body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  Teacher projecttt = snapshot.data[index];
                  print(projecttt.id);
                  return GestureDetector(
                      onTap: () async{
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        preferences.setInt('id',projecttt.id);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return ChatPage();
                            }));
                      },
                      child: Padding(padding: const EdgeInsets.only(
                          top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
                        child: Card(
                          color: Colors.grey.shade200,
                            child:  Container(
                                padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
                                child: Row(
                                    children: <Widget>[
                                      Expanded(
                                          child: Row(
                                              children: <Widget>[
                                                CircleAvatar(
                                                  backgroundImage: NetworkImage(projecttt.teacherAvatart),
                                                  backgroundColor: Colors.white,
                                                  maxRadius: 30,
                                                ),
                                                SizedBox(width: 16,),
                                                Expanded(
                                                    child: Container(
                                                      color: Colors.transparent,
                                                      child: Text(projecttt.teacherName, style: TextStyle(fontSize: 16,color: AppTheme.textColor)),
                                                    )),
                                              ])),
                                    ]))),
                      )
                  );
                },
                itemCount: _teachers.length,
              );
            }
            return const CircularProgressIndicator();
          },
        ));
  }
}
