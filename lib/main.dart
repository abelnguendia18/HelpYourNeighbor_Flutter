import 'package:flutter/material.dart';
import 'package:help_your_neighbor/src/screens/login_screen.dart';
import 'package:help_your_neighbor/src/screens/onboarding.dart';
import 'package:help_your_neighbor/src/screens/sing_up_screen.dart';
import 'package:help_your_neighbor/src/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

final Color greenApp =  Color(0xff89ca89);
void main(){

  //One way to hide the system status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: greenApp,
    statusBarBrightness: Brightness.light,


  ));
  //runApp(MyApp());
  runApp(SplashScreen());

}


