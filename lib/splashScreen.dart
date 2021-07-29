import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hello_world1/identity.dart';
import 'package:hello_world1/item3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hello_world1/selectSchool.dart';
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
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);

    Future onSelectNotification(String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
     await Navigator.push(context,MaterialPageRoute(builder: (context) =>
         Item3Screen(
          payload: payload,
        )));
    }

    flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);

    FirebaseMessaging.instance.getInitialMessage()
        .then((RemoteMessage message) {
      if (message.notification != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Item3Screen()));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
       print('Handling a foreground message ${message.messageId}');
       print (message.notification.title);
       print(message.notification.body);
       RemoteNotification notification = message.notification;
       AndroidNotification android = message.notification?.android;
        if (notification!= null && android != null){
         flutterLocalNotificationsPlugin.show(
       notification.hashCode,
           notification.title,
             notification.body,
             NotificationDetails(

                 android: AndroidNotificationDetails(
                     channel.id,
                    channel.name,
                     channel.description,
                     icon: android?.smallIcon)
             ));
       }
     });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if ( notification != null && android != null){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Item3Screen()));
      }
    });
      Timer(
        Duration(seconds: 4),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => SelectSchool()))
    );
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
