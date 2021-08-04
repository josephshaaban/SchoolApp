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

  class ExamData {
    int examMark;
    String examMaterial;
    String examNote;
    String examDate;
    String examType;
    String examClassroom;

    ExamData(this.examMark, this.examMaterial, this.examNote,
        this.examClassroom, this.examDate, this.examType);

    ExamData.fromJson(Map<String, dynamic> json){
      examMark = json['examMark'];
      examClassroom = json['examClassroom'];
      examMaterial = json['examMaterial'];
      examNote = json['examNote'];
      examDate = json['examDate'];
      examType = json['examType'];
    }
  }

class Absence {
  String studentName;
  String  studentId;
  String  studentStatus;
  String  note;
  String  date;

  Absence(this.studentStatus, this.studentId, this.note,
      this.date, this.studentName);

  Absence.fromJson(Map<String, dynamic> json){
    studentName = json['studentName'];
    studentStatus = json['studentStatus'];
    note = json['note'];
    date = json['date'];
  }
}

class MediaData {
  String fileUrl;
  String fileName;

  MediaData(this.fileName, this.fileUrl);

  MediaData.fromJson(Map<String, dynamic> json){
    fileName = json['fileName'];
    fileUrl = json['fileUrl'];
  }
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


class Teacher{
  String id;
  String teacherName;
  String teacherAvatart;
  Teacher(this.teacherAvatart, this.teacherName, this.id);
  Teacher.fromJson(Map<String, dynamic> json){
    id= json['id'];
    teacherName= json['teacherName'];
    teacherAvatart= json['teacherAvatart'];
  }
}
class TeacherData{
  int id;
  TeacherData(this.id);
  TeacherData.fromJson(Map<String, dynamic> json){
    id= json['id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}

class News{
  String news;
  String link;
  News(this.news, this.link);
  News.fromJson(Map<String, dynamic> json){
    news= json['news'];
    link= json['link'];
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
  String image;
  String messageText;

  ChatUsers({@required this.name,@required this.image,@required this.messageText});
}

class StudentData {
  String student_id;
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

