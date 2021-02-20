import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help_your_neighbor/src/models/announcement_model.dart';
import 'package:help_your_neighbor/src/screens/home_screen.dart';
import 'package:help_your_neighbor/src/screens/my_account_screen.dart';
import 'package:help_your_neighbor/src/utils.dart';
import 'package:help_your_neighbor/src/utils/firebase_services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash/flash.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

import 'package:help_your_neighbor/src/models/place.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class NewAnnouncementScreen extends StatefulWidget {
  @override
  _NewAnnouncementScreenState createState() => _NewAnnouncementScreenState();
}

class _NewAnnouncementScreenState extends State<NewAnnouncementScreen> {
  final Color _greenApp = Color(0xff89ca89);
  final Color _grey = Color(0xffdcdcdc);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _globalKey = GlobalKey<ScaffoldState>();
  String _userId;
  var imageUrl = null;
  var _groupValue;
  var _selectedCategory;
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerOwnerAddress = TextEditingController();
  TextEditingController _controllerDescription = TextEditingController();
  List _listOfCategories = [
    "Einkaufshilfe",
    "Putzhilfe",
    "Gartenhilfe",
    "Gassi"
  ];

  void _handleRadioValueChange(int value) {
    // debugPrint("value is : $value");
  }

  // ignore: must_call_super
  void initState() {
    //_userId = AuthenticationService.getCurrentUserId();
    _userId = _firebaseAuth.currentUser.uid;
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
        key: _globalKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                  //Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          centerTitle: true,
          title: Text("Neues Inserat",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold)),
          backgroundColor: _greenApp,
        ),
        //resizeToAvoidBottomInset: false,
        //resizeToAvoidBottomPadding: false,

        body: SingleChildScrollView(
          child: Form(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
                        if (_userId != null) {
                          //print("User ID: $userId");
                          String url =
                              await AuthenticationService.uploadImage(userId);
                          setState(() {
                            // _userId = userId;
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
                        value: "Suche",
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
                        value: "Angebot",
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
                    controller: _controllerPrice,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "Preis(Euro/Stunde)"),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  /*AutoCompleteTextField(
                    suggestionsAmount: 5,
                    controller: _controllerOwnerAddress,
                    textChanged: (value) {
                      getLocationsResult(value);
                    },
                    suggestions: _suggestionss,
                    decoration: InputDecoration(
                      hintText: "Wohnort",
                    ),
                    itemBuilder: (context, item) {
                      return Container(
                        padding: EdgeInsets.all(20.0),
                        child: Row(
                          children: <Widget>[
                            Text(item),
                          ],
                        ),
                      );
                    },
                  ),*/
                  Container(
                    //padding: EdgeInsets.all(10.0),
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _controllerOwnerAddress,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                            hintText: "Wohnort",
                          
                        ),
                      ) ,
                      suggestionsCallback: (input)async{
                        return await Utils.getLocationsResult(input);
                      },

                      itemBuilder: (context, suggestion){
                        return ListTile(
                          leading: Icon(Icons.location_on_outlined, color: _greenApp,),
                          title: Text(suggestion['description'], style: TextStyle(color: Colors.black),),
                        );
                      },
                      onSuggestionSelected: (suggestion){
                                    _controllerOwnerAddress.text = suggestion['description'];
                      },
                    ),
                  ),
                  
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    maxLines: 3,
                    controller: _controllerDescription,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: "Beschreibung",
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  SizedBox(
                    width: 250,
                    height: 45,
                    child: RaisedButton(
                        color: _greenApp,
                        textColor: Colors.black,
                        child: Text("Anzeige Aufgeben"),
                        elevation: 2.0,
                        onPressed: () async {
                          var userTel;
                          userTel =
                              await AuthenticationService.getUserTelNumber(
                                  _userId);
                          print("Mon number: $userTel");

                          Announcement announcement = Announcement(
                              categoryAnnouncement:
                                  _selectedCategory.toString(),
                              descriptionAnnouncement:
                                  _controllerDescription.text.toString(),
                              imagePath: imageUrl,
                              ownerAddress:
                                  _controllerOwnerAddress.text.toString(),
                              ownerId: _userId.toString(),
                              ownerPhoneNumber: userTel.toString(),
                              priceAnnouncement:
                                  _controllerPrice.text.toString(),
                              statusAnnouncement: _groupValue.toString(),
                              isFavorite: "nein");
                          String result =
                              await AuthenticationService.saveAnnouncement(
                                  announcement);
                          if(result == "ok"){
                            final snackBar = SnackBar(
                              duration: Duration(seconds: 10),
                              content: Text("Anzeige erfolgreich erstellt."),
                              backgroundColor: _greenApp,
                              action: SnackBarAction(
                                label: 'Clicken Sie hierhin...',
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyAccountScreen()),
                                  );
                                },
                              ),
                            );
                            _globalKey.currentState.showSnackBar(snackBar);
                          }

                          print("Result of insertion: $result");
                        }),
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
