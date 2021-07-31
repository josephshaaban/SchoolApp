import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

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

class Teacher{
  int id;
  String teacherName;
  String teacherAvatart;
  Teacher(this.teacherAvatart, this.teacherName, this.id);
  Teacher.fromJson(Map<String, dynamic> json){
    id= json['id'];
    teacherName= json['teacherName'];
    teacherAvatart= json['teacherAvatart'];
  }
}

class TeacherData {
  int id;
  String  teacherName;
  String teacherAvatart;
  TeacherData(this.id, this.teacherName,this.teacherAvatart);
  TeacherData.fromJson(Map<String, dynamic> json){
    id= json['id'];
    teacherName= json['teacherName'];
    teacherAvatart= json['teacherAvatart'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['teacherName '] = this.teacherName;
    data['teacherAvatart '] = this.teacherAvatart;

    return data;
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

class Ads{
  String adsText;
  String adsImg;
  Ads(this.adsText, this.adsImg);
  Ads.fromJson(Map<String, dynamic> json){
    adsText= json['adsText'];
    adsImg= json['adsImg'];
  }
}


class Absence{
  String studentName;
  String studentStatus;
  String note;
  String date;

  Absence(this.date, this.note,this.studentStatus,this.studentName);
  Absence.fromJson(Map<String, dynamic> json){
    date= json['date'];
    note= json['note'];
    studentStatus= json['studentStatus'];
    studentName= json['studentName'];
  }
}

class Messages{
String text;
Messages(this.text);
Messages.fromJson(Map<String,dynamic> json){
  text= json['text'];
}
}