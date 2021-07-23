import 'dart:convert';
import 'dart:core';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;


class Item6Screen extends StatefulWidget {
  @override
  _Item6ScreenState createState() => _Item6ScreenState();
}

class _Item6ScreenState extends State<Item6Screen> {
  List<Items> _items = <Items>[];

  Future<List<Items>> fetchData() async{
    var response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var items= <Items>[];

    if (response.statusCode == 200){
      var dataJson= json.decode(response.body);
      for (var dataJson in dataJson){
        items.add(Items.fromJson(dataJson));
      }
    }
    return  items;
  }

  @override
  void initState(){
    fetchData().then((value) {
      setState(() {
        _items.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:ReusableWidgets.getAppBar('بنك الميديا'),
        body: ListView.builder(
          itemBuilder: (context, index){
            return ReusableWidgets.getCard(_items[index].name,_items[index].email,_items[index].username);
          },
          itemCount: _items.length,
        ));
  }
}


