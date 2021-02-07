import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help_your_neighbor/src/screens/home_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:help_your_neighbor/src/utils/firebase_services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final Color _greenApp = Color(0xff89ca89);
  var _currentUserId;
  var _totalAnnouncements = 0;
  var username;
  var userPhoneNumber;

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
  void initState() {
    _currentUserId = FirebaseAuth.instance.currentUser.uid;

    AuthenticationService.getUsername(_currentUserId).then((String value) {
      setState(() {
        username = value;
      });
    });

    AuthenticationService.getUserTelNumber(_currentUserId).then((String value) {
      setState(() {
        userPhoneNumber = value;
      });
    });


    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: DefaultTabController(
          length: 2,
          child: Scaffold(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                      //Scaffold.of(context).openDrawer();
                    },
                  );
                },
              ),
              backgroundColor: _greenApp,
              title: Text(
                "Mein Konto",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: "Droid Sans"),
              ),
              bottom: TabBar(
                unselectedLabelColor: Colors.white,
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: <Widget>[
                  Tab(
                    text: "Meine Anzeigen($_totalAnnouncements)",
                  ),
                  Tab(
                    text: "Mein Profil",
                  ),
                ],
              ),
              /*title: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text("Meine Anzeigen"),
                ),
                Tab(
                  child: Text("Mein Profil"),
                ),
              ],
            ),*/
            ),
            body: TabBarView(
              children: [
                Center(
                  child: FutureBuilder(
                    future: AuthenticationService.getAnnouncementsList(),
                    builder: (_, snapshot) {
                      _totalAnnouncements = snapshot.data.length;

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: Text("Daten werden geladen ..."),
                        );
                      }   else if(snapshot.data.length < 1) {
                        return Center(
                          child: Text("Sie haben noch keine Azeige angelegt...", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                        );
                      }
                      else {
                        return ListView.builder(
                          //shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              key: Key('${snapshot.data[index]}'),
                              background: Container(
                                color: Colors.red,
                                child: Icon(Icons.delete),
                              ),
                              child: _currentUserId ==
                                      snapshot.data[index]['ownerId']
                                  ? Card(
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            // Group 1: img, title, description
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  //image
                                                  width: 100.0,
                                                  height: 100.0,
                                                  child: Image.network(
                                                      snapshot.data[index]
                                                          ['imagePath']),
                                                  // child: Image.asset(_imagePath[index]),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Column(
                                                    //title and desc
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(
                                                        snapshot.data[index]
                                                            ['status'],
                                                        style: TextStyle(
                                                          fontSize: 25,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: 200.0,
                                                        child: Text(
                                                          snapshot.data[index]
                                                              ['description'],
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          maxLines: 8,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          /*Container(
                                            //Group 2: location, price
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  EvaIcons.pinOutline,
                                                  color: _greenApp,
                                                  size: 25,
                                                ),
                                                SizedBox(
                                                  width: 3,
                                                ),
                                                Text(
                                                  snapshot.data[index]
                                                      ['ownerAddress'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontFamily: "Roboto"),
                                                ),


                                                SizedBox(
                                                  width: 250,
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    EvaIcons.heartOutline,
                                                    color: _greenApp,
                                                    size: 30,
                                                  ),
                                                  onPressed: () {},
                                                ),
                                                //Icon(EvaIcons.heartOutline, color: _greenApp, size: 30, )
                                              ],
                                            ),
                                          )*/
                                        ],
                                      ),
                                    )
                                  : Container(),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Center(
                  //child: Text("Mein Account"),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.asset("assets/Gartenhilfe.jpg"),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Column(
                            children: [
                              Text("$username"),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text("$userPhoneNumber"),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 200,
                        height: 40,
                        child: RaisedButton(
                            color: _greenApp,
                            textColor: Colors.black,
                            child: Text("Ausloggen"),
                            elevation: 2.0,
                            onPressed: () {}),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
      onWillPop: _onBackPressed,
    );
    /* DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon:  Icon(Icons.arrow_back_outlined, size: 30,),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                    //Scaffold.of(context).openDrawer();
                    },

                );
              },
            ),
            backgroundColor: _greenApp,
            title: Text(
              "Mein Konto",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "Droid Sans"),
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: <Widget>[
                Tab(text: "Meine Anzeigen", icon: Icon(Icons.message)),
                Tab(text: "Mein Profil", icon: Icon(Icons.account_circle),),
              ],
            ),
            */ /*title: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text("Meine Anzeigen"),
                ),
                Tab(
                  child: Text("Mein Profil"),
                ),
              ],
            ),*/ /*
          ),
          body: TabBarView(
            children: [
              Center(
                child: Text("Meine Anzeigen"),

              ),
              Center(
                child: Text("Mein Account"),
              ),
            ],
          ),
        )
    );*/
  }
}
