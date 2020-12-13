import 'package:flutter/material.dart';
import 'package:help_your_neighbor/src/screens/login_screen.dart';
import 'package:help_your_neighbor/src/utils.dart';

class SingUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SingUpHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SingUpHome extends StatefulWidget {
  @override
  _SingUpHomeState createState() => _SingUpHomeState();
}

class _SingUpHomeState extends State<SingUpHome> {
  final Color _greenApp = Color(0xff89ca89);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                  child: Text('Registrierung',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),),
                ),
              ),
            ),

            SizedBox(height: 20.0,),
            /*Container(
              padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/icons/icon.png',
                      width: 250.0,
                      height: 150.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                      'coco',
                      style: TextStyle(
                        fontSize: 50.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
            Container(
              width: 320.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildTextField(_nameController, Icons.account_circle, 'Username'),
                  SizedBox(
                    height: 10.0,
                  ),
                  _buildTextField(_numberController, Icons.phone, 'Telefonnummer'),
                  SizedBox(height: 10.0,),
                  _buildTextField(_emailController, Icons.mail, 'E-Mail'),
                  SizedBox(height: 10.0,),
                  _buildTextField(_passwordController, Icons.lock, 'Password'),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    width: 300.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(5.0),
                      shadowColor: Colors.green,
                      color: _greenApp,
                      elevation: 2.0,
                      child: GestureDetector(
                        onTap: () {},
                        child: Center(
                          child: Text('REGISTRIEREN'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            'Haben Sie schon ein Konto?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                              MaterialPageRoute(builder:
                              (context) => Login()),
                              );
                            },
                            child: Text(
                              ' Sich einloggen',
                              style: TextStyle(
                                  color: _greenApp,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, IconData icon, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: _greenApp),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
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


