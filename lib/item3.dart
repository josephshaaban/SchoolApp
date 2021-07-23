//import 'dart:convert';
import 'dart:core';
import 'reusable.dart';
import 'package:flutter/material.dart';
//import 'data.dart';
//import 'package:http/http.dart' as http;

class Item3Screen extends StatelessWidget {

  final payload;
  Item3Screen({Key key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:ReusableWidgets.getAppBar('صندوق الإشعارات'),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Text(payload ?? '');
          },
          itemCount: 10,
        ));
  }
}
