import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

class Utils {

  static final String apiKey = "AIzaSyCzOPbyKI6mx3R9TSMowPcIES3dsPYNsQI";

  static setSecondTimeOfAppExecution() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("secondTimeOfApplicationExecution", true);
  }

  static Future<bool> isInternetConnectionAvailable() async {
    var result = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile) ||
        (connectivityResult == ConnectivityResult.wifi)) {
      result = true;
    } else
      result = false;

    return result;
  }


  static Future<bool> isSecondTimeAppExecuted() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //if the variable don't already exit, it value is set to false and it is the first time we launch the App
    bool secondTimeOfApplicationExecution =
        preferences.getBool("secondTimeOfApplicationExecution") ?? false;
    return secondTimeOfApplicationExecution;
  }

  static void showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text)));
  }


  void findPlace(String placeName){
    if(placeName.length > 1){

      String autocompleteUrl = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$apiKey&sessiontoken=1234567890";

      //var response = await RequestAssistant.getRequest(autocompleteUrl);
    }
  }

}

//A class for custom clippath
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    //throw UnimplementedError();
    var path = new Path();
    path.lineTo(0, size.height - 100);
    var controllPoint = Offset(50, size.height);
    var endPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllPoint.dx, controllPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    //throw UnimplementedError();
    return true;
  }


}
