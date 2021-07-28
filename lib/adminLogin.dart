import 'dart:convert';
import 'package:http/http.dart';
import 'admin.dart';
import 'data.dart';
import 'identity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';
import 'reusable.dart';

class AdminLoginPage extends StatefulWidget {

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String email='';
  String password='';
  int school_Id ;
  int student_id;
  int teacher_id;
  int classId;
  String identity;
  String identity1;
  Map saved_Logins1;

  Future getSchool() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      school_Id = preferences.getInt('school_id');
      identity= preferences.getString('identity');
      identity1= preferences.getString('identity1');
    });
  }

  void init_data()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getString('saved_login1'));
    preferences.getString('saved_login1')!=null?setState((){saved_Logins1 = jsonDecode(preferences.getString('saved_login1'));}) :setState((){saved_Logins1=Map();});
  }
  // loader will find all logged in account in this device then add them to widget array then put them in a column to display them
  Widget loader1(){
    if(saved_Logins1!=null){
      List<Widget> logins=[];
      saved_Logins1.forEach((key, value) {
        logins.add(InkWell(child: Container(child: Text(key),) ,
            onTap: ()async{
              print(key + " "+ value);
              SharedPreferences preferences = await SharedPreferences.getInstance();
              String username = preferences.getString('email');
              String userpassword = preferences.getString('password');
              if ( key == username && value == userpassword ){
                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.setString("email",key );
                Navigator.push(context, MaterialPageRoute(builder: (context) => AdminScreen()));
              }}
        ));

      });
      return Column(
          mainAxisSize: MainAxisSize.min,
          children: logins);
    }
    else {
      return CircularProgressIndicator(color: Colors.blue,);
    }
  }
  @override
  void initState() {
    super.initState();
    init_data();
    getSchool();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;  return Scaffold(
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
                      child:SingleChildScrollView(
                        child: Container(
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
                                    padding: const EdgeInsets.only(top: 20.0,bottom: 10.0),
                                    child: MaterialButton(
                                      color: AppTheme.textColor ,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                      child: Text("تسجيل الدخول", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900, color: AppTheme.backgroundColor)
                                      ),
                                      onPressed: () async {
                                        final url = Uri.parse('https://rude-sheep-77.loca.lt/api/account/school_id');
                                        final headers = {"Content-Type": "application/x-www-form-urlencoded"};
                                        final response = await post(url, headers: headers,
                                            body: jsonEncode(<String, String>{
                                              'account': emailController.text,
                                              'pass': passwordController.text})
                                        );
                                        if (response.statusCode == 200) {
                                          print(response.body);
                                          StudentData.fromJson(jsonDecode(response.body));
                                          var jsonResponse = json.decode(response.body);
                                          teacher_id = jsonResponse['teacher_id'];
                                          SharedPreferences preferences = await SharedPreferences.getInstance();
                                          preferences.setString('email', emailController.text);
                                          preferences.setString('password', passwordController.text);
                                          preferences.setInt('school_Id', school_Id);
                                          preferences.setInt('teacher_id', teacher_id);
                                          preferences.setInt('classId', classId);
                                          Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => AdminScreen()),
                                          );
                                        }else{
                                          // set up the AlertDialog
                                          AlertDialog alert = AlertDialog(content: Text("هذاالحساب ليس حساب مشرف",
                                            textAlign: TextAlign.center,)
                                          );
                                          // show the dialog
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return alert;
                                            },
                                          );
                                        }
                                        SharedPreferences preferences = await SharedPreferences.getInstance();
                                        Map m;
                                        preferences.getString('saved_login1')!=null?m = jsonDecode(preferences.getString('saved_login1')):m=Map<String,String>();
                                        m[emailController.text.toLowerCase().trim()]=passwordController.text;
                                        preferences.setString('saved_login1', jsonEncode(m));
                                      },
                                    )),
                                MaterialButton(
                                    color: AppTheme.textColor ,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                    child: Text("حسابات مسجلة سابقا", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w900,
                                        color: AppTheme.backgroundColor)
                                    ),
                                    onPressed: () async {
                                      showDialog(context: context, builder:(context){
                                        return AlertDialog(
                                          content: loader1(),
                                          actions: [
                                            MaterialButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Close'),
                                            )
                                          ],
                                        );
                                      } );
                                    }),
                              ]),
                        ),
                      ))),
                  Container(
                      child: SizedBox(
                          height: size.height - (size.height - size.height / 6),
                          width: size.width,
                          child: CustomPaint(
                            painter: SecondWaveClipperBottom(),
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