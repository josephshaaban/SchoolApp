import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'main.dart';
import 'identity.dart';

class SelectSchool extends StatefulWidget {
  @override
  _SelectSchoolState createState() => _SelectSchoolState();
}

class _SelectSchoolState extends State<SelectSchool> {

  String sName = '' ;
  String sIp = '' ;

  @override
  void initState() {
    super.initState();
  }

  School selectedUser;
  List<School> schools = <School>[
    const School('school1','ip 1'),
    const School('school2','ip 2'),
    const School('school3', 'ip 3'),
    const School('school4', 'ip 4'),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return new WillPopScope(
        onWillPop: () =>  SystemNavigator.pop(),
    child: Material(
        child: Container(
            child: Column(children: <Widget>[
              SizedBox(
                  width: size.width,
                  height: size.height / 3.3,
                  child: CustomPaint(
                    painter: SecondWaveClipperTop(),
                  )),
              Expanded(
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppTheme.textColor,width: 5)),
                                child:  DropdownButton<School>(
                                  hint: Text(" اختر مدرسة ", style: TextStyle(color: AppTheme.textColor,fontWeight: FontWeight.bold)),
                                  value: selectedUser,
                                  // ignore: non_constant_identifier_names
                                  onChanged: (School Value) {
                                    setState(() {
                                      selectedUser = Value;
                                    });
                                  },
                                  items: schools.map((School school) {
                                    return DropdownMenuItem<School>(
                                      value: school,
                                      child: Row(
                                          children: <Widget>[
                                            SizedBox(width: 15),
                                            MaterialButton(
                                                onPressed: () async{
                                                  SharedPreferences preferences = await SharedPreferences.getInstance();
                                                  preferences.setString('sIp',school.ip );
                                                  preferences.setString('sName', school.name);
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => Identity()));
                                                },
                                                child: Text(school.name, style: TextStyle(
                                                    color: AppTheme.textColor,fontWeight: FontWeight.bold))),
                                          ]),
                                    );
                                  }).toList(),
                                ))])
                  )),
              Expanded(
                  child: Container(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                                height: size.height - (size.height - size.height / 6),
                                width: size.width,
                                child: CustomPaint(
                                  painter: SecondWaveClipperBottom(),
                                ))
                          ]))),
            ])
                          )));
  }
}
