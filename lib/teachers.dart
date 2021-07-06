import 'dart:convert';
import 'dart:core';
import 'chatPage.dart';
import 'reusable.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'package:http/http.dart' as http;

class TeachersList extends StatefulWidget {
  @override
  _TeachersListState createState() => _TeachersListState();
}

class _TeachersListState extends State<TeachersList> {
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
        appBar:ReusableWidgets.getAppBar('المشرفين'),
        body: ListView.builder(
          itemBuilder: (context, index){
            return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ChatPage();
                  }));
                },
                child: Padding(
                    padding: const EdgeInsets.only(top:32.0, bottom: 32.0,left: 16.0,right: 16.0),
                    child: Text(_items[index].username)
                ));
          },
          itemCount: _items.length,
        ));
  }
}
