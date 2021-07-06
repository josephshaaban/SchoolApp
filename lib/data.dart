import 'package:flutter/cupertino.dart';

class Data{
  String name;
  String email;
  String body;
  Data(this.name, this.email, this.body);
  Data.fromJson(Map<String, dynamic> json){
    name= json['name'];
    email= json['email'];
    body= json['body'];
  }
}

class ItemData{
  String title;
  String url;
  String thumbnailUrl;
  ItemData(this.title, this.url, this.thumbnailUrl);
  ItemData.fromJson(Map<String, dynamic> json){
    title= json['title'];
    url= json['url'];
    thumbnailUrl= json['thumbnailUrl'];
  }
}

class Items{
  String name;
  String email;
  String username;
  Items(this.name, this.email, this.username);
  Items.fromJson(Map<String, dynamic> json){
    name= json['name'];
    email= json['email'];
    username= json['username'];
  }
}

class School {
  const School(this.name,this.icon);
  final String name;
  final Icon icon;
}


class ChatUsers{
  String name;
  String messageText;
  String image;
  ChatUsers({@required this.name,@required this.messageText,@required this.image});
}