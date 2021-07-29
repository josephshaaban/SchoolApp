import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'item2.dart';
import 'item1.dart';
import 'item3.dart';
import 'item4.dart';
import 'item5.dart';
import 'item6.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MyGridView extends StatefulWidget {
  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<MyGridView> {

  int school_Id;
  int student_id;
  int classId;
  Future getStudentData() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      school_Id = preferences.getInt('school_Id')??0;
      student_id=  preferences.getInt('student_id')??0;
      classId= preferences.getInt('classId')??0;
    });
  }

  @override
  void initState(){
    super.initState();
    getStudentData();
  }

   @override
  Widget build(BuildContext context) {
    return GridView.count(
     scrollDirection: Axis.vertical,
          crossAxisCount: 2,
        children: <Widget>[
          MainObject(
              myImage: Container(color: AppTheme.textColor,
                  child:Image.asset("assets/images/yy.png")),section:Text('آخر الأخبار',style: TextStyle(color: AppTheme.backgroundColor,fontSize: 16, fontWeight: FontWeight.w900),maxLines: 1,),position: 1),
          MainObject(
              myImage: Container(color: AppTheme.textColor,
                  child: Image.asset("assets/images/cc.png")),section:Text('صندوق الإشعارات',style: TextStyle(color: AppTheme.backgroundColor,fontSize: 16, fontWeight: FontWeight.w900),maxLines: 1,),position:2),
          MainObject(
              myImage: Container(color: AppTheme.textColor,
                  child: Image.asset("assets/images/ee.png")),section:Text('درجات الطالب',style: TextStyle(color: AppTheme.backgroundColor,fontSize: 16, fontWeight: FontWeight.w900),maxLines: 1,),position:3),
          MainObject(myImage: Container(color: AppTheme.textColor,
              child:Image.asset("assets/images/rr.png")),section:Text('بنك الميديا',style: TextStyle(color: AppTheme.backgroundColor,fontSize: 16, fontWeight: FontWeight.w900),maxLines: 1,),position:4),
          MainObject(
              myImage: Container(color:Colors.grey.shade600,
                  child:Image.asset("assets/images/ll.png")),section:Text('تواصل مع المشرف',style: TextStyle(color: Colors.redAccent),),position:6),
          MainObject(
              myImage: Container(color: Colors.grey.shade600,
                  child: Image.asset("assets/images/oo.png")),section:Text('الحضور و الغياب',style: TextStyle(color: Colors.redAccent),),position: 5),
        ]);
  }
}

class MainObject extends StatelessWidget {
  MainObject({this.myImage, this.section,this.position});
  final Container myImage;
  final Text section;
  final int position;

  _getObjectItem(position, context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    switch (position) {
        case 1:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Item2Screen()));
          break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Item3Screen()));
            break;
            case 3:
               preferences.getInt('classId');
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Item4Screen()));
              break;
                case 4:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Item6Screen()));
                  break;
                  case 5:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Item1Screen()));
                    break;
                    case 6:
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Item5Screen()));
                      break;
                  default:
                    return new Text("Something went wrong");
    }
  }
  @override
  Widget build(BuildContext context) {
    return GridTile(
     child: InkWell(
      onTap: () => _getObjectItem(position,context),
         child:FittedBox(
             fit: BoxFit.fill,
               child: Container(
                 margin: const EdgeInsets.only(left: 14.0,right: 14.0,bottom: 12.0),
                 decoration: new BoxDecoration(color: AppTheme.textColor,borderRadius: BorderRadius.circular(8.0)),
                 child:FittedBox(
                   fit: BoxFit.fill,
                     child: Column(children:<Widget>[
                       Container(
                           alignment: Alignment.center,
                           child: myImage),
                      FittedBox(
                        fit:BoxFit.scaleDown,
                       child: section
                      )])),
      ))),
     );
  }
}