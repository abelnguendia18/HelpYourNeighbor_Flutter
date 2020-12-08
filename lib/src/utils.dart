import 'package:shared_preferences/shared_preferences.dart';


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