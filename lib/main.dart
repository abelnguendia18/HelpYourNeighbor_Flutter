import 'package:flutter/material.dart';
import 'package:help_your_neighbor/src/screens/home_screen.dart';
import 'package:help_your_neighbor/src/screens/login_screen.dart';
import 'package:help_your_neighbor/src/screens/onboarding.dart';
import 'package:help_your_neighbor/src/screens/sing_up_screen.dart';
import 'package:help_your_neighbor/src/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

final Color greenApp =  Color(0xff89ca89);
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  //One way to hide the system status bar
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: greenApp,
    statusBarBrightness: Brightness.light,
  ));
  //Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
// I need to do this in order to access Firebase's services
  await Firebase.initializeApp();
  //runApp(MyApp());
 // runApp(SplashScreen());
  //runApp(HomeScreen());
runApp(Login());
}


