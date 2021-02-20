import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:help_your_neighbor/credentials.dart';
import 'package:http/http.dart' as http;

class Utils {
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

 static Future<List> getLocationsResult(String input) async {

    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';

    //String type = 'address';
    String type = '(cities)';
    //values for Germany, latitude and longitude
    String location = '51.0834196,10.423446';

    String request =
        '$baseURL?input=$input&key=$PLACES_API_KEY&type=$type&location=$location&language=de';

    Response response = await Dio().get(request);

    final predictions = response.data['predictions'];

/*    List<String> _requestResults = [];

    for (var i = 0; i < predictions.length; i++) {
      String placeName = predictions[i]['description'];
      _requestResults.add(placeName);
    }

    print(_requestResults);*/

    return predictions;
  }

  static Future<void> makeCall(String number) async {
    if (await canLaunch(number)) {
      await launch(number);
    } else {
      throw 'Anruf an $number ist nicht möglich';
    }
  }

  static Future<void> sendSms(String number) async {
    if (await canLaunch(number)) {
      await launch(number);
    } else {
      throw 'Nachricht an $number kann  nicht versendet werden.';
    }
  }

  static Future<bool> isSecondTimeAppExecuted() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    //if the variable don't already exit, it value is set to false and it is the first time we launch the App
    bool secondTimeOfApplicationExecution =
        preferences.getBool("secondTimeOfApplicationExecution") ?? false;
    return secondTimeOfApplicationExecution;
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
