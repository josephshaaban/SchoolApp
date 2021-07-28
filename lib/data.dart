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

class ExamData{
  int examMark;
  String examMaterial;
  String examNote;
  String examDate;
  String examType;
  String examClassroom;

  ExamData(this.examMark, this.examMaterial,this.examNote,this.examClassroom, this.examDate, this.examType);
  ExamData.fromJson(Map<String, dynamic> json){
    examMark= json['examMark'];
    examClassroom= json['examClassroom'];
    examMaterial= json['examMaterial'];
    examNote= json['examNote'];
    examDate= json['examDate'];
    examType= json['examType'];
  }
}

class MediaData{
  String fileUrl;
  String fileName;
  MediaData(this.fileName, this.fileUrl);
  MediaData.fromJson(Map<String, dynamic> json){
    fileName= json['fileName'];
    fileUrl= json['fileUrl'];
  }
}
class Todo {
  final String filename;
  final String fileurl ;

  const Todo(this.filename, this.fileurl);
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

class School {
  String name;
  int school_Id;
  School(this.name, this.school_Id);
  School.fromJson(Map<String, dynamic> json){
    name= json['school_name'];
    school_Id= json['school_id'];
  }
}

class ChatUsers{
  String name;
  String messageText;
  String image;
  ChatUsers({@required this.name,@required this.messageText,@required this.image});
}

class StudentData {
  int student_id;
  int classId;
  StudentData(this.student_id, this.classId);
  StudentData.fromJson(Map<String, dynamic> json){
    student_id= json['id'];
    classId= json['classId'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.student_id;
    data['classId '] = this.classId;
    return data;
  }
}

