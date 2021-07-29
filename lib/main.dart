//import 'package:test_app/register.dart';
//import 'package:test_app/chatPage.dart';
import 'adminLogin.dart';
import 'conversation.dart';
import 'splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
//import 'admin.dart';
import 'news.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
// await Firebase.initializeApp();
//print('Handling a background message ${message.messageId}');
//print(message.notification.title);
//print(message.notification.body);
//}

//const AndroidNotificationChannel channel = AndroidNotificationChannel(
//'high_importance_channel', // id
// 'High Importance Notifications', // title
// 'This channel is used for important notifications.', // description
//importance: Importance.high,
//);

//final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  //   .resolvePlatformSpecificImplementation<
  // AndroidFlutterLocalNotificationsPlugin>()
  // ?.createNotificationChannel(channel);

  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  var email1 = preferences.getString('teacherEmail');
  initializeDateFormatting().then((_)=> runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home: email != null ? NewsScreen() : email1 != null
              ? Conversation()
              : SplashScreen())));
}

class AppTheme {
  static Color backgroundColor = Colors.white ;
  static Color textColor = const Color(0xFF003746);
}
