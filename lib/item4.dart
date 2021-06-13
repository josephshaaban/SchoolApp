import 'dart:convert';
import 'dart:core';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;


class Item4Screen extends StatefulWidget {
  @override
  _Item4ScreenState createState() => _Item4ScreenState();
}

class _Item4ScreenState extends State<Item4Screen> {
  List<ItemData> _itemdata = <ItemData>[];

  Future<List<ItemData>> fetchData() async{
    var response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1/photos'));

    var itemdata= <ItemData>[];

    if (response.statusCode == 200){
      var dataJson= json.decode(response.body);
      for (var dataJson in dataJson){
        itemdata.add(ItemData.fromJson(dataJson));
      }
    }
    return  itemdata;
  }

  @override
  void initState(){
    fetchData().then((value) {
      setState(() {
        _itemdata.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:ReusableWidgets.getAppBar('درجات الطالب'),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ReusableWidgets.getCard(_itemdata[index].title,_itemdata[index].url,_itemdata[index].thumbnailUrl);
        },
        itemCount: 10,
      ));
  }
}


