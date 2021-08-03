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
  String student_id;
  int classId;

  List<News> _news = <News>[];

  Future<List<News>> fetchData() async {
    var response = await http.get(
        Uri.parse('https://school-node-api.herokuapp.com/api/news/1'));
    var news = <News>[];
    if (response.statusCode == 200) {
      var dataJson = json.decode(response.body);
      for (var dataJson in dataJson) {
        news.add(News.fromJson(dataJson));
      }
    }
    return news;
  }

  Future getStudentData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      student_id = preferences.getString('student_id') ?? 0;
      classId = preferences.getInt('classId') ?? 0;
    });
  }

  @override
  void initState() {
    fetchData().then((value) {
      setState(() {
        _news.addAll(value);
      });
    });
    super.initState();
    getStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableWidgets.getAppBar('آخر الأخبار'),
        body: FutureBuilder(
            future: fetchData(),
            builder: (context, snapshot1) {
              if (snapshot1.hasData) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      News newsproject = snapshot1.data[index];
                      return Card(
                          child: Container(
                              alignment: Alignment.topLeft,
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade200),
                              child: Column(children: [
                                Card(
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.shade200),
                                        child: Column(children: [
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: 15, bottom: 15),
                                              child: Text(
                                                  'News: ' + newsproject.news)),
                                          Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 15),
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                  'Link: ' + newsproject.link)),
                                        ])))
                              ])));
                    },
                    itemCount: snapshot1.data.length);
              } else {
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              }
            }));
  }
}
