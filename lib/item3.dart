import 'dart:core';
import 'reusable.dart';
import 'package:flutter/material.dart';

class Item3Screen extends StatelessWidget {
  final payload;
  Item3Screen({Key key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ReusableWidgets.getAppBar('صندوق الإشعارات'),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
                borderOnForeground: true,
                color: Colors.white60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(payload ?? 'payload'),
                  )
                ]));
          },
          itemCount: 10,
        ));
  }
}
