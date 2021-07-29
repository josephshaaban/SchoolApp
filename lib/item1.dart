import 'dart:convert';
import 'dart:core';
import 'data.dart';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Item1Screen extends StatefulWidget {
  @override
  _Item1ScreenState createState() => _Item1ScreenState();
}

class _Item1ScreenState extends State<Item1Screen> {


  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:ReusableWidgets.getAppBar('الحضور والغياب'),
    );
  }
}


