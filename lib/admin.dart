import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'reusable.dart';

class AdminScreen extends StatelessWidget {

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