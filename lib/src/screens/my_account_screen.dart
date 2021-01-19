import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help_your_neighbor/src/screens/home_screen.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  final Color _greenApp = Color(0xff89ca89);

  Future<bool> _onBackPressed(){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Wollen Sie wirklich die App Verlassen?"),
            actions: <Widget>[
                  FlatButton(
                      onPressed:() => SystemNavigator.pop(),
                      child: Text("Ja")
                  ),
            ],
          );
        }
    );
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
                child: Text("Meine Anzeigen"),

              ),
              Center(
                child: Text("Mein Account"),
              ),
            ],
          ),
        )
    ),
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
            *//*title: TabBar(
              tabs: <Widget>[
                Tab(
                  child: Text("Meine Anzeigen"),
                ),
                Tab(
                  child: Text("Mein Profil"),
                ),
              ],
            ),*//*
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
