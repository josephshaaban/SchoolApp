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
  @override
  void initState() {
    super.initState();
  }

  School selectedUser;
  List<School> users = <School>[
    const School('school1', Icon(Icons.school, color: const Color(0xFF003746))),
    const School('school2', Icon(Icons.school, color: const Color(0xFF003746))),
    const School('school3', Icon(Icons.school, color: const Color(0xFF003746))),
    const School('school4', Icon(Icons.school, color: const Color(0xFF003746))),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Material(
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
                            DropdownButton<School>(
                              hint: Text("Select item", style: TextStyle(color: AppTheme.textColor)),
                              value: selectedUser,
                              // ignore: non_constant_identifier_names
                              onChanged: (School Value) {
                                setState(() {
                                  selectedUser = Value;
                                });
                              },
                              items: users.map((School user) {
                                return DropdownMenuItem<School>(
                                  value: user,
                                  child: Row(
                                      children: <Widget>[
                                        user.icon,
                                        SizedBox(width: 15),
                                        MaterialButton(
                                            onPressed: () => Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) => Identity())),
                                            child: Text(user.name,
                                                style: TextStyle(
                                                    color: AppTheme.textColor))),
                                      ]),
                                );
                              }).toList(),
                            )])
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
            ])));
  }
}
