import 'dart:core';
import 'reusable.dart';
import 'package:flutter/material.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:ReusableWidgets.getAppBar(' تسجيل الدخول كمشرف'),
        body: Center(
            child: Text('الرجاء الترقية الى النسخة المدفوعة',style: TextStyle(fontWeight: FontWeight.w900),))
    );
  }
}
