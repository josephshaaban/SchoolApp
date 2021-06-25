import 'dart:async';
import 'package:hello_world1/selectSchool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';
import 'reusable.dart';
import 'myAnimation.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SelectSchool()))
    );

//    var initializationSettingsAndroid=
  //      AndroidInitializationSettings('@mipmap/ic_launcher');
  //  var initializationSettings = InitializationSettings(android: initializationSettingsAndroid );

    //flutterLocalNotificationsPlugin.initialize(initializationSettings);

   // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
     // RemoteNotification notification = message.notification;
   //   AndroidNotification android = message.notification?.android;
     // if(notification!=null && android!=null){
       // flutterLocalNotificationsPlugin.show(
         //   notification.hashCode, notification.title, notification.body,
           // NotificationDetails(
             // android: AndroidNotificationDetails(
               // channel.id, channel.name,channel.description
              //)
            //));
      //}
    //});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return new Scaffold(
        backgroundColor: AppTheme.backgroundColor,
      body: Stack(
          children:[
            FittedBox(),
                 Container(
                    width:size.width,
                    height:size.height,
                    child: Stack(
                        children:[
                          Container(
                           child: CustomPaint(
                            size: Size(size.width,size.height),
                            painter: WaveClipperTop(),
                            )),
                          Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top:size.height/3.5),
                              child: Column(children: [
                                Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                  //  padding: EdgeInsets.only(top: size.height/7),
                                     child: Image.asset("assets/images/flutter_lo.png")),
                                Container(
                                  //   padding: EdgeInsets.only(top: size.height/5),
                                  child: MyAnimator()
                              ),
                                Container(
                                    child: MyAnimator1()),
                              ])),
                          Container(
                               child: Positioned(
                                bottom: 0,
                                 child: CustomPaint(
                                   size: Size(size.width,size.height),
                                    painter: WaveClipperBottom() ,
                                 ),
                               ),
                              ),
                          ])),
          ]),
    );
  }
}
