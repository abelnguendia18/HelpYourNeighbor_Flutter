import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help_your_neighbor/src/utils/firebase_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewAnnouncementScreen extends StatefulWidget {
  @override
  _NewAnnouncementScreenState createState() => _NewAnnouncementScreenState();
}

class _NewAnnouncementScreenState extends State<NewAnnouncementScreen> {
  final Color _greenApp = Color(0xff89ca89);
  final Color _grey = Color(0xffdcdcdc);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  var imageUrl = null;
  var _groupValue;
  var _selectedCategory;

  List _listOfCategories = [
    "Einkaufshilfe",
    "Putzhilfe",
    "Gartenhilfe",
    "Gassi"
  ];

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
        appBar: AppBar(
          centerTitle: true,
          title: Text("Neues Inserat",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
          backgroundColor: _greenApp,
          automaticallyImplyLeading: false,
        ),
        //resizeToAvoidBottomInset: false,
        //resizeToAvoidBottomPadding: false,

        body: SingleChildScrollView(
          child: Form(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    //Image
                    child: GestureDetector(
                      child: imageUrl == null
                          ? Icon(
                              Icons.add_a_photo_outlined,
                              color: _greenApp,
                              size: 50.0,
                            )
                          : Image.network(imageUrl),
                      onTap: () async {
                        var userId = _firebaseAuth.currentUser.uid;
                        if (userId != null) {
                          //print("User ID: $userId");
                          String url =
                              await AuthenticationService.uploadImage(userId);
                          setState(() {
                            imageUrl = url;
                          });
                          print("URLLL: $url");
                        } else {
                          print("no user");
                        }
                        // File image = await ImagePicker.pickImage(source: ImageSource.gallery);
                        //print("$image");
                      },
                    ),
                    height: 200.0,
                    width: 200.0,
                    color: _grey,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    // Radiobuttons
                    children: <Widget>[
                      Radio(
                        value: "Ich suche",
                        groupValue: _groupValue,
                        activeColor: _greenApp,
                        onChanged: (val) {
                          setState(() {
                            _groupValue = val;
                          });
                          print("Radio $val");
                        },
                      ),
                      //SizedBox(width: 5.0,),
                      Text("Ich suche"),
                      Radio(
                        value: "Ich biete",
                        groupValue: _groupValue,
                        activeColor: _greenApp,
                        onChanged: (val) {
                          setState(() {
                            _groupValue = val;
                          });
                          print("Radio $val");
                        },
                      ),
                      Text("Ich biete"),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  DropdownButton(
                    icon: Icon(Icons.arrow_drop_down),
                    dropdownColor: _grey,
                    hint: Text("Kategorie auswählen"),
                    items: _listOfCategories.map((valueItem) {
                      return DropdownMenuItem(
                        child: Text(valueItem),
                        value: valueItem,
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                    value: _selectedCategory,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Preis(Euro/Stunde)"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Wohnort",
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Beschreibung",
                    ),
                  ),
                  SizedBox(
                    height: 70.0,
                  ),
                  SizedBox(
                    width: 250,
                    height: 45,
                    child: RaisedButton(
                        color: _greenApp,
                        textColor: Colors.black,
                        child: Text("Anzeige Aufgeben"),
                        elevation: 2.0,
                        onPressed: () {}),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: _onBackPressed,
    );
  }
}
