import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_your_neighbor/src/screens/home_screen.dart';
import 'package:help_your_neighbor/src/screens/sing_up_screen.dart';
import 'package:help_your_neighbor/src/screens/widgets/textfield_builder.dart';
import 'package:help_your_neighbor/src/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_your_neighbor/src/utils/firebase_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

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
  //Color greenApp = Color.fromRGBO(137, 202, 137, 0.0);
  final Color _greenApp = Color(0xff89ca89);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthenticationService _authenticationService = AuthenticationService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: 200,
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
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.only(top: 50.0),
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                width: 320.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildTextField(
                        _emailController, Icons.mail, 'E-Mail', false),


                    SizedBox(
                      height: 20.0,
                    ),
                    _buildTextField(
                        _passwordController, Icons.lock, 'Password', true),

                    SizedBox(height: 30.0),
                    Container(
                      height: 40.0,
                      width: 300.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(7.0),
                        shadowColor: Colors.green,
                        color: _greenApp,
                        elevation: 2.0,
                        child: RaisedButton(
                          color: _greenApp,
                          onPressed: () async {
                            var isInternetAvailable =
                                await Utils.isInternetConnectionAvailable();

                            if (isInternetAvailable) {

                              if((_emailController.text.isNotEmpty) && (_passwordController.text.isNotEmpty) ){
                                var result = await AuthenticationService.singIn(
                                    email:
                                    _emailController.text.toString().trim(),
                                    password:
                                    _passwordController.text.toString());
                                if (result) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                  print("Login Ok");
                                }else{
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
                              }else{
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
                                btnOkColor: Colors.red,
                              )..show();
                            }
                          },
                          child: Center(
                            child: Text('LOGIN'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              'Sind Sie neu hier?',
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
                                      builder: (context) => SingUp()),
                                );
                              },
                              child: Text(
                                ' Registrieren',
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
          ),
        ],
      ),
    ));
  }

  Widget _buildTextField(TextEditingController controller, IconData icon,
      String labelText, bool isPasswordField) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: _greenApp),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        obscureText: isPasswordField ? true : false,
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
