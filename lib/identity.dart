import 'register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'adminLogin.dart';
import 'main.dart';
import 'reusable.dart';

class Identity extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String identity = 'student' ;
    String identity1 = 'admin' ;
    return Scaffold(
        body:   Container(
         child:Column(
            children:<Widget>[
              SizedBox(
                  width: size.width,
                  height: size.height/3.3,
                  child: CustomPaint(
                      painter: SecondWaveClipperTop(),
                      )
                  ),
                      Expanded(  child: new Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              height: size.height-size.height/3.3,
                              child:Column( mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row( children: <Widget>[
                                      Padding(padding: EdgeInsets.only(top: size.height/1.9)),
                                      Expanded(child: Container(
                                          child: Column(
                                              children:<Widget>[
                                                Container(
                                                    width: 101, height: 100,
                                                    decoration: BoxDecoration(
                                                        color: AppTheme.backgroundColor,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(color: AppTheme.textColor, width: 3)),
                                                    child:MaterialButton(
                                                        child: Image.asset('assets/images/teacher1.png'),
                                                        onPressed: () async {
                                                          SharedPreferences preferences = await SharedPreferences.getInstance();
                                                          preferences.setString("identity1", identity1);
                                                          Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLoginPage()));
                                                        })),
                                                Container( child: Text("مشرف", style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900)))
                                              ]))),
                                     Expanded(child: Container(
                                          child: Column(
                                              children:<Widget>[
                                                Container(
                                                    width: 101, height: 100,
                                                    decoration: BoxDecoration(color: AppTheme.backgroundColor,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(color: AppTheme.textColor, width: 3)),
                                                    child: MaterialButton(onPressed: () async {
                                                      SharedPreferences preferences = await SharedPreferences.getInstance();
                                                      preferences.setString("identity",identity );
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                                                      },
                                                        child: Image.asset('assets/images/student1.png'))),
                                                Container(child: Text("طالب", style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900)))
                                              ])))
                                    ]),
                                    SizedBox(
                                        height: size.height-(size.height-size.height/6),
                                        width: size.width,
                                        child: CustomPaint(
                                          painter: SecondWaveClipperBottom() ,
                                        ))])
                          )
                      ))])
        )
    );
  }
}

class SecondWaveClipperBottom extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final height1= size.height-(size.height-size.height/11);

    Paint paint_0 = new Paint()
      ..color = AppTheme.textColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 50;
    Path path_0 = Path();
    path_0.moveTo(size.width*0.0041667,size.height*0.7362500);
    path_0.quadraticBezierTo(size.width*0.2481333,height1*0.7930167,size.width*0.5266667,size.height*0.7362500);
    path_0.quadraticBezierTo(size.width*0.6398000,size.height*1.0004167,size.width,height1*1.7362500);
    path_0.lineTo(size.width,size.height);
    path_0.lineTo(0,size.height);
    path_0.lineTo(size.width*0.0041667,height1*0.9362500);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}