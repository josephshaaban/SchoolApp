import 'dart:core';
import 'package:hello_world1/AllChatsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'item2.dart';
import 'item3.dart';
import 'item4.dart';
import 'item1.dart';
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
              myImage: Image.asset("assets/images/oo.png"),section:'الحضور والغياب',position: 0),
          MainObject(
              myImage: Image.asset("assets/images/yy.png"),section:'آخر الأخبار',position: 1),
          MainObject(
              myImage: Image.asset("assets/images/cc.png"),section:'صندوق الإشعارات',position:2),
          MainObject(
              myImage: Image.asset("assets/images/ee.png"),section:'درجات الطالب',position:3),
          MainObject(
              myImage: Image.asset("assets/images/ll.png"),section:'تواصل مع المشرف',position:4),
          MainObject(
              myImage: Image.asset("assets/images/rr.png"),section:'بنك الميديا',position:5)
        ]);
  }
}
class MainObject extends StatelessWidget {
  MainObject({this.myImage, this.section,this.position});
  final Image myImage;
  final String section;
  final int position;

  _getObjectItem(position, context){
    switch (position) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Item1Screen()));
        break;
        case 1:
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Item2Screen()));
          break;
          case 2:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Item3Screen()));
            break;
            case 3:
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Item4Screen()));
              break;
              case 4:
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllChatsPage()));
                break;
                case 5:
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Item6Screen()));
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
                       child: Text(section,style: TextStyle(color: AppTheme.backgroundColor,fontSize: 16, fontWeight: FontWeight.w900),maxLines: 1,)
                      )])),
      ))),
     );
  }
}