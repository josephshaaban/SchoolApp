import 'dart:convert';
import 'dart:core';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;


class Item5Screen extends StatefulWidget {
  @override
  _Item5ScreenState createState() => _Item5ScreenState();
} 

class _Item5ScreenState extends State<Item5Screen> {
  List<Data> _news = <Data>[];

  Future<List<Data>> fetchData() async{
    var response =await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1/comments'));

    var news= <Data>[];

    if (response.statusCode == 200){
      var dataJson= json.decode(response.body);
      for (var dataJson in dataJson){
        news.add(Data.fromJson(dataJson));
      }
    }
    return news;
  }

  @override
  void initState(){
    fetchData().then((value) {
      setState(() {
        _news.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:ReusableWidgets.getAppBar('تواصل مع المشرف'),
        body: ListView.builder(
        itemBuilder: (context, index){
          return ReusableWidgets.getCard(_news[index].name,_news[index].email,_news[index].body);
        },
        itemCount: _news.length,
      ));
  }
}


