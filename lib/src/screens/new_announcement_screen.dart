import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewAnnouncementScreen extends StatefulWidget {
  @override
  _NewAnnouncementScreenState createState() => _NewAnnouncementScreenState();
}

class _NewAnnouncementScreenState extends State<NewAnnouncementScreen> {
  final Color _greenApp = Color(0xff89ca89);
  final Color _grey = Color(0xffdcdcdc);
   int _groupValue = 1;
   var selectedCategory ="";

  void _handleRadioValueChange(int value) {
     // debugPrint("value is : $value");
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Wollen Sie wirklich die App Verlassen?"),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => SystemNavigator.pop(), child: Text("Ja")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(

        child: Scaffold(
          resizeToAvoidBottomInset: false,

          body: SafeArea(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Neues Inserat", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30.0), ),
                ListView(
                  shrinkWrap: true,
                  children: <Widget>[

                    Form(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container( //Image
                              child: GestureDetector(
                                child: Icon(Icons.add_a_photo_outlined, color: _greenApp, size: 50.0,),
                                onTap: (){

                                },
                              ),
                              height: 75.0,
                              width: 75.0,
                              color: _grey,
                            ),
                            SizedBox(height: 20.0,),

                            Row( // Radiobuttons
                              children: <Widget>[
                                Radio(
                                  value: "Ich suche",
                                  groupValue: _groupValue,
                                  activeColor: _greenApp,

                                ),
                                //SizedBox(width: 5.0,),
                                Text("Ich suche"),
                                Radio(
                                  value: "Ich suche",
                                  groupValue: _groupValue,
                                  activeColor: _greenApp,

                                ),
                                Text("Ich biete"),
                              ],
                            ),
                           


                            SizedBox(height: 10.0,),
                            TextFormField(),
                            SizedBox(height: 10.0,),
                            TextFormField(),
                            SizedBox(height: 10.0,),
                            TextFormField(),
                            SizedBox(height: 10.0,),
                            SizedBox(
                              width: 250,
                              height: 45,
                              child: RaisedButton(
                                  color: _greenApp,
                                  textColor: Colors.black,
                                  child: Text("Anzeige Aufgeben"),
                                  elevation: 2.0,
                                  onPressed: (){

                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),

          ),




        ),
        onWillPop: _onBackPressed,
    );
  }
}
