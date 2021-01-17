import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:help_your_neighbor/src/screens/login_screen.dart';
import 'package:help_your_neighbor/src/screens/login_screen_2.dart';
import 'package:help_your_neighbor/src/screens/onboarding.dart';
import 'package:help_your_neighbor/src/utils.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeSplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeSplashScreen extends StatefulWidget {
  @override
  _HomeSplashScreenState createState() => _HomeSplashScreenState();
}

class _HomeSplashScreenState extends State<HomeSplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 3), () async {
      bool isSecondTime = await isSecondTimeAppExecuted();
      setSecondTimeOfAppExecution();
      //It means the App is launched for the first time
      if (!isSecondTime) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyApp())); //Onboarding
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/icon.png',
          ),
          SizedBox(
            height: 30.0,
          ),
          SpinKitRipple(color: Colors.green),
        ],
      ),
    );
  }
/*Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: AnimatedSplashScreen(
        duration: 3000,
        splash: Image.asset('assets/icon.png'),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.bottomToTop,
        nextScreen: MyApp(),
        backgroundColor: Colors.white,

      ),
    );
  }*/
}
