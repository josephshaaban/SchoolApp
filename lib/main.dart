import 'splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'admin.dart';
import 'news.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
    runApp(
        MaterialApp(
            debugShowCheckedModeBanner: true,
            home: email == null ? SplashScreen() : email == 'admin'
                ? AdminScreen()
                : NewsScreen()));
  }

class AppTheme {
  static Color backgroundColor = Colors.white ;
  static Color textColor = const Color(0xFF003746);
}
