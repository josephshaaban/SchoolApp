import 'dart:core';
import 'reusable.dart';
import 'package:flutter/material.dart';

class Item5Screen extends StatefulWidget {
  @override
  _Item5ScreenState createState() => _Item5ScreenState();
}

class _Item5ScreenState extends State<Item5Screen> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:ReusableWidgets.getAppBar('التواصل مع المشرف'),
        body: Center(
            child: Text('الرجاء الترقية الى النسخة المدفوعة',style: TextStyle(fontWeight: FontWeight.w900),))
    );
  }
}



