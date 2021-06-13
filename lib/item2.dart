import 'dart:convert';
import 'dart:core';
import 'reusable.dart';
import 'data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Item2Screen extends StatefulWidget {
  @override
  _Item2ScreenState createState() => _Item2ScreenState();
}

class _Item2ScreenState extends State<Item2Screen> {
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
        appBar:ReusableWidgets.getAppBar('آخر الأخبار'),
        body: ListView.builder(
        itemBuilder: (context, index) {
          return ReusableWidgets.getCard(_itemdata[index].title,_itemdata[index].url,_itemdata[index].thumbnailUrl);
        },
        itemCount: 10,
      ));
  }
}


