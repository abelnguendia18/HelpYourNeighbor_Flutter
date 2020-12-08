import 'package:flutter/material.dart';




class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginHome extends StatefulWidget {
  @override
  _LoginHomeState createState() => _LoginHomeState();
}

class _LoginHomeState extends State<LoginHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  child: Text('coco',
                    style: TextStyle(
                      fontSize: 80.0, fontWeight: FontWeight.bold,),
                  ),
                ),
              ],
            ),

          ),
        ],
      ),
    );
  }
}
