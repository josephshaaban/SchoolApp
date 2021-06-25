import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'reusable.dart';
import 'main.dart';

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
              body:
                    Center(
                        child: Text('The Content For Admin' , style: TextStyle(fontSize: 22)),
    )));

  }
}