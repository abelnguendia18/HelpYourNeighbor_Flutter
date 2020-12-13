import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

setSecondTimeOfAppExecution() async{
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool("secondTimeOfApplicationExecution", true);
}

Future<bool> isSecondTimeAppExecuted() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  //if the variable don't already exit, it value is set to false and it is the first time we launch the App
  bool secondTimeOfApplicationExecution = preferences.getBool("secondTimeOfApplicationExecution") ?? false ;
  return secondTimeOfApplicationExecution;
}


//A class for custom clippath
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    //throw UnimplementedError();
    var path = new Path();
    path.lineTo(0, size.height-100);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width/2, size.height);
    path.quadraticBezierTo(controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip( CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    //throw UnimplementedError();
    return true;
  }
}