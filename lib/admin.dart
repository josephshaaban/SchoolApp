import 'package:flutter/material.dart';
import 'reusable.dart';
import 'main.dart';

class AdminScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
        onWillPop: () => showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          title: Text('تبديل الحساب أو تسجيل الخروج أولاً',textAlign: TextAlign.center),
        )),
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