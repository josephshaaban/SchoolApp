import 'dart:core';
import 'dart:ui';
import 'identity.dart';
import 'main.dart';
import 'splashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableWidgets {
  static getAppBar(String title) {
    return AppBar(
        title: new Text(title),
      backgroundColor: AppTheme.textColor);
  }
  static getCard(String data1, String data2, String data3 ){
    return Card(
        child: Padding(
          padding: const EdgeInsets.only(top:32.0, bottom: 32.0,left: 16.0,right: 16.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(data1 ?? 'empty', style: TextStyle(fontSize:31, fontWeight: FontWeight.bold)),
                Text(data2 ?? 'empty', style: TextStyle(color: Colors.blue)),
                Text(data3 ?? 'empty', style: TextStyle(color: Colors.grey.shade800))
              ]),
        ));
  }
}
class WaveClipperTop extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = AppTheme.textColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 50;

    Path path_0 = Path();
    path_0.moveTo(0,0);
    path_0.quadraticBezierTo(size.width*0.1119500,size.height*0.0335680,size.width*0.1839750,size.height*0.0991360);
    path_0.cubicTo(size.width*0.2768750,size.height*0.1732000,size.width*0.7150500,size.height*0.1537600,size.width*0.8009750,size.height*0.2620000);
    path_0.quadraticBezierTo(size.width*0.8715000,size.height*0.3120800,size.width,size.height*0.3173120);
    path_0.lineTo(size.width,0);
    path_0.lineTo(0,0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class WaveClipperBottom extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {

    Paint paint_0 = new Paint()
      ..color = AppTheme.textColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 50;

    Path path_0 = Path();
    path_0.moveTo(size.width*0.0041667,size.height*0.9362500);
    path_0.quadraticBezierTo(size.width*0.2481333,size.height*0.7930167,size.width*0.5266667,size.height*0.9279167);
    path_0.quadraticBezierTo(size.width*0.6398000,size.height*1.0004167,size.width,size.height*0.8429167);
    path_0.lineTo(size.width,size.height);
    path_0.lineTo(0,size.height);
    path_0.lineTo(size.width*0.0041667,size.height*0.9362500);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class SecondWaveClipperTop extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = AppTheme.textColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 50;

    Path path_0 = Path();
    path_0.moveTo(0,0);
    path_0.quadraticBezierTo(size.width*0.1119500,size.height*0.134272,size.width*0.1839750,size.height*0.396544);
    path_0.cubicTo(size.width*0.2768750,size.height*0.6928,size.width*0.7150500,size.height*0.61504,size.width*0.8009750,size.height*1.048);
    path_0.quadraticBezierTo(size.width*0.8715000,size.height*1.24832,size.width,size.height*1.269248);
    path_0.lineTo(size.width,0);
    path_0.lineTo(0,0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppTheme.textColor
      ..strokeWidth = 5;

    Offset startingPoint = Offset(size.width/2-40, size.height /11.5);
    Offset endingPoint = Offset(size.width/2+40, size.height/11.5);

    canvas.drawLine(startingPoint, endingPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class MyMaterialButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) => choiceAction(value, context),
      icon: Image.asset("assets/images/account.png", fit: BoxFit.fill),
      itemBuilder: (BuildContext context) =>
      <PopupMenuItem<String>>[
        new PopupMenuItem<String>(
            child: const Text('تبديل الحساب', textDirection: TextDirection.rtl),
            value: "1"),
        new PopupMenuItem<String>(
            child: const Text('تسجيل الخروج', textDirection: TextDirection.rtl),
            value: "2"),
      ],
    );
  }
  void choiceAction(String value, BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');

    if (value == "1") {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Identity()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen()));
    }
  }
}