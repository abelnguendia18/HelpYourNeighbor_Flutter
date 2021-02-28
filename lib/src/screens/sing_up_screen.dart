import 'package:flutter/material.dart';
import 'package:help_your_neighbor/src/screens/login_screen.dart';
import 'package:help_your_neighbor/src/utils.dart';
import 'package:help_your_neighbor/src/utils/firebase_services.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
  final _globalKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _globalKey,
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
                    'Registrierung',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Form(
              child: Container(
                padding: EdgeInsets.only(top: 50.0),
                width: screenWidth - 50,
                height: screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildTextField(
                        _nameController, Icons.account_circle, 'Username'),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildTextField(
                        _numberController, Icons.phone, 'Telefonnummer'),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildTextField(_emailController, Icons.mail, 'E-Mail'),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildTextField(
                        _passwordController, Icons.lock, 'Password'),
                    SizedBox(height: 30.0),
                    Container(
                      height: 40.0,
                      width: 300.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(5.0),
                        shadowColor: Colors.green,
                        color: _greenApp,
                        elevation: 2.0,
                        child: RaisedButton(
                          color: _greenApp,
                          onPressed: () async {
                            var isInternetAvailable =
                                await Utils.isInternetConnectionAvailable();

                            if (isInternetAvailable) {
                              if ((_nameController.text.isNotEmpty) &&
                                  (_numberController.text.isNotEmpty) &&
                                  (_passwordController.text.isNotEmpty) &&
                                  (_emailController.text.isNotEmpty)) {
                                var user = await (AuthenticationService.singUp(
                                    userName:
                                        _nameController.text.toString().trim(),
                                    email:
                                        _emailController.text.toString().trim(),
                                    password:
                                        _passwordController.text.toString(),
                                    userTelNumber: _numberController.text
                                        .toString()
                                        .trim()));
                                if (user != null) {
                                  final snackBar = SnackBar(
                                    duration: Duration(seconds: 10),
                                    content:
                                        Text("Konto erfolgreich erstellt."),
                                    backgroundColor: _greenApp,
                                    action: SnackBarAction(
                                      label: 'Login',
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                        );
                                      },
                                    ),
                                  );
                                  _globalKey.currentState
                                      .showSnackBar(snackBar);

                                  print("User ID: ${user.uid}");
                                } else {
                                  AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    animType: AnimType.TOPSLIDE,
                                    headerAnimationLoop: false,
                                    useRootNavigator: true,
                                    title: 'Fehler',
                                    autoHide: Duration(seconds: 3),
                                    desc:
                                        'Überprüfen Sie bitte Ihre Eingabedaten!',
                                    btnOkIcon: Icons.cancel,
                                    btnOkColor: Colors.red,
                                  )..show();
                                }
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.WARNING,
                                  animType: AnimType.TOPSLIDE,
                                  headerAnimationLoop: false,
                                  useRootNavigator: true,
                                  title: 'Information',
                                  autoHide: Duration(seconds: 3),
                                  desc:
                                      'Alle Formularfelder müssen ausgefüllt werden!',
                                  btnOkIcon: Icons.cancel,
                                  btnOkColor: Colors.red,
                                )..show();
                              }
                            } else {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.TOPSLIDE,
                                  headerAnimationLoop: false,
                                  useRootNavigator: true,
                                  title: 'Fehler',
                                  autoHide: Duration(seconds: 3),
                                  desc:
                                      'Überprüfen Sie bitte Ihre Internetverbindung!',
                                  btnOkIcon: Icons.cancel,
                                  btnOkColor: Colors.red)
                                ..show();
                            }
                          },
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
                                  MaterialPageRoute(
                                      builder: (context) => Login()),
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
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
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
