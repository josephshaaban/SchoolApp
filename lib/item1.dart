import 'dart:convert';
import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;

class Item1Screen extends StatefulWidget {
  @override
  _Item1ScreenState createState() => _Item1ScreenState();
}

class _Item1ScreenState extends State<Item1Screen> {
  int school_Id;
  int student_id;
  int classId;

  List<Absence> _absence = <Absence>[];

  Future getStudentData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      school_Id = preferences.getInt('school_Id') ?? 0;
      student_id = preferences.getInt('student_id') ?? 0;
      classId = preferences.getInt('classId') ?? 0;
    });
  }

  @override
  void initState() {
    fetchData().then((value) {
      setState(() {
        _absence.addAll(value);
      });
    });
    super.initState();
    getStudentData();
  }

  Future<List<Absence>> fetchData() async {
    var response = await http.get(Uri.parse(
        'https://school-node-api.herokuapp.com/api/user/$student_id'));
    var absence = <Absence>[];
    if (response.body.isNotEmpty) {
      print(student_id);
      var dataJson = json.decode(response.body);
      for (var dataJson in dataJson) {
        absence.add(Absence.fromJson(dataJson));
      }
    }
    return absence;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableWidgets.getAppBar('درجات الطالب'),
        body: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    Absence project1 = snapshot.data[index];
                    return Card(
                        borderOnForeground: true,
                        color: Colors.white60,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text('studentName: ' + project1.studentName),
                          ),
                          Text('studentStatus: ' + project1.studentStatus),
                          Text('note: ' + project1.note),
                          Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Text('date: ' + project1.date))
                        ]));
                  },
                  itemCount: snapshot.data.length);
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }
}
