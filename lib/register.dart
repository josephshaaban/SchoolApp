import 'admin.dart';
import 'identity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:form_field_validator/form_field_validator.dart";
import 'news.dart';
import 'main.dart';
import 'reusable.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String email='';
  String password='';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body:  Container(
              child:Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:<Widget>[
                SizedBox(
                  width: size.width,
                  height: size.height/6,
                  child: CustomPaint(
                   painter: SecondWaveClipperTop(),
                     child:Container(
                      alignment: Alignment.topRight,
                         padding: EdgeInsets.only(right: 15.0, top: 30.0),
                         child: IconButton(
                          iconSize: 50,
                          icon: Icon(Icons.arrow_forward,color: AppTheme.backgroundColor),
                          onPressed: () {
                           Navigator.push(context,
                               MaterialPageRoute(builder: (context) => Identity()));
                         }))
                        )),
    Expanded(  child: new Align(
    alignment: Alignment.bottomCenter,
                child:Container(
                  height: size.height-size.height/6,
                  alignment: Alignment.center,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: Container(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                width: 149,
                                height: 171,
                                child: Image.asset('assets/images/flutter_lo.png'))),
                          Padding(
                              padding: EdgeInsets.only(left:20.0,top: 20.0,right:20.0,bottom: 15.0),
                              child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: TextFormField(
                                    autovalidateMode: AutovalidateMode.always,
                                    textAlign: TextAlign.right,
                                    controller: emailController,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: AppTheme.textColor)),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(color: AppTheme.textColor),
                                            borderRadius: BorderRadius.circular(30.0)),
                                        hintStyle: TextStyle(fontSize: 20.0, color: AppTheme.textColor),
                                        hintText: 'البريد الالكتروني'),
                                    validator: EmailValidator(errorText: 'Not a Valid Email'),
                                  ))),
                          Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                              child: Directionality(
                                  textDirection: TextDirection.ltr,
                                  child: TextFormField(
                                      autovalidateMode: AutovalidateMode.always,
                                      key: _formKey,
                                      obscureText: true,
                                      textAlign: TextAlign.right,
                                      controller: passwordController,
                                      validator: (value){
                                        if (value.length < 6 && value.length >0 ) {
                                          return "Should Be At Least 6 characters" ;
                                        } else {
                                          return null;
                                        }},
                                      decoration: InputDecoration(
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: AppTheme.textColor)),
                                          border: OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
                                              borderSide: BorderSide(color: AppTheme.textColor)),
                                          hintTextDirection: TextDirection.rtl,
                                          hintStyle: TextStyle(fontSize: 20.0, color: AppTheme.textColor),
                                          hintText: ' كلمة المرور')
                                  ))),
                           Padding(
                              padding: const EdgeInsets.only(top: 20.0,bottom: 15.0),
                                       child: MaterialButton(
                                         color: AppTheme.textColor ,
                                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                         child: Text("تسجيل الدخول", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900, color: AppTheme.backgroundColor)
                                         ),
                                         onPressed: () async {
                                           email='user@gmail.com'; password='useruser';
                                           if ( emailController.text == email && passwordController.text == password) {
                                             SharedPreferences preferences = await SharedPreferences.getInstance();
                                             preferences.setString('email',emailController.text );
                                             Navigator.push(context, MaterialPageRoute(builder: (context) => NewsScreen()),
                                             );
                                           } else{ email= 'admin@gmail.com'; password='adminadmin';
                                           if ( emailController.text == email && passwordController.text == password ){
                                             SharedPreferences preferences = await SharedPreferences.getInstance();
                                             preferences.setString("email",emailController.text );
                                             Navigator.push(context, MaterialPageRoute(builder: (context) => AdminScreen()));
                                           }}},
                              )),
                        Expanded(
                            child: Container(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                          height: size.height - (size.height - size.height / 6),
                                          width: size.width,
                                          child: CustomPaint(
                                            painter: SecondWaveClipperBottom(),
                                          ))
                                    ]))),
                        ]),
                ))),
                ]))
         );
  }
}

class SecondWaveClipperBottom extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final height1= size.height-(size.height-size.height/6);

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