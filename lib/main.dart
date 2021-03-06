import 'package:flutter/foundation.dart';
import 'package:hello_world1/item3.dart';
import 'package:scoped_model/scoped_model.dart';
import 'AllChatsPage.dart';
import 'splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'news.dart';
import 'ChatModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class MessageHandler extends StatefulWidget {
  final Widget child;
  MessageHandler({this.child});
  @override
  State createState() => MessageHandlerState();
}

class MessageHandlerState extends State<MessageHandler> {
  Widget child;
  @override
  void initState() {
    super.initState();
    child=this.widget.child;
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Item3Screen(payload: message.notification.body,)));
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                icon: message.notification.android?.smallIcon,
              ),
            ));

      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Item3Screen(payload: message.notification.body,)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'high_importance_notification',
  'This channel is user for important notifications.',
    importance: Importance.high,
    playSound: true
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  await flutterLocalNotificationsPlugin
  .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
  ?.createNotificationChannel(channel);

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  var teacherEmail= preferences.getString('teacherEmail');
    runApp(
      ScopedModel(
          model: ChatModel(),
          child: MaterialApp(
          routes: {
            '/notification':(context) => Item3Screen()
          },
            debugShowCheckedModeBanner: true,
            home: MessageHandler(child:email != null ? NewsScreen() : teacherEmail != null
                ? AllChatsPage()
                : SplashScreen()))));
  }

class AppTheme {
  static Color backgroundColor = Colors.white ;
  static Color textColor = const Color(0xFF003746);
}
