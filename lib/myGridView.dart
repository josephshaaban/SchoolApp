import 'dart:core';
import 'main.dart';
import 'item2.dart';
import 'item3.dart';
import 'item4.dart';
import 'item6.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
     scrollDirection: Axis.vertical,
          crossAxisCount: 2,
        children: <Widget>[
          MainObject(
              myImage: Image.asset("assets/images/yy.png"),section:'آخر الأخبار',position: 1),
          MainObject(
              myImage: Image.asset("assets/images/cc.png"),section:'صندوق الإشعارات',position:2),
          MainObject(
              myImage: Image.asset("assets/images/ee.png"),section:'درجات الطالب',position:3),
          MainObject(
              myImage: Image.asset("assets/images/rr.png"),section:'بنك الميديا',position:4)
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