import 'package:flutter/material.dart';
import 'package:help_your_neighbor/src/utils.dart';

class Login2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginHome2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginHome2 extends StatefulWidget {
  @override
  _LoginHome2State createState() => _LoginHome2State();
}

class _LoginHome2State extends State<LoginHome2> {
  final Color _greenApp = Color(0xff89ca89);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: 180,
                decoration: BoxDecoration(
                  color: _greenApp,
                ),
                child: Center(
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            //SizedBox(height: 120.0,),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _greenApp),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: _greenApp),
            icon: Icon(
              icon,
              color: _greenApp,
            ),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }
}
