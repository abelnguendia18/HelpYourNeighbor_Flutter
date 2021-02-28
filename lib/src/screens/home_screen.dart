import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:help_your_neighbor/src/screens/favorites_screen.dart';
import 'package:help_your_neighbor/src/screens/widgets/search_bar.dart';
import 'package:help_your_neighbor/src/screens/my_account_screen.dart';
import 'package:help_your_neighbor/src/screens/new_announcement_screen.dart';
import 'package:help_your_neighbor/src/screens/widgets/announcements_list.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreenStateful(),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum BottomIcons { Home, Favorite, Add, Account }

class HomeScreenStateful extends StatefulWidget {
  @override
  _HomeScreenStatefulState createState() => _HomeScreenStatefulState();
}

class _HomeScreenStatefulState extends State<HomeScreenStateful> {
  //that is the default state, when the authentication was successful

  BottomIcons bottomIcons = BottomIcons.Home;
  final Color _greenApp = Color(0xff89ca89);
  int _page = 0;
  bool tmp = false;
  int totalFavorites;

  Future<void> internetStatusMessage() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Überprüfen Sie Ihre Internetverbindung!"),
            actions: [FlatButton(onPressed: null, child: Text("OK"))],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //internetStatusMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          _page == 0
              ? Container(
                  padding: EdgeInsets.only(top: 15),
                  //Homescreen

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 40),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Home",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            SearchBar(),
                          ],
                        ),
                      ),

                      //SearchBar(),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: AnnouncementsList(),
                      )
                    ],
                  ),
                )
              : Container(),
          _page == 1
              ? Container(
                  //Favoriten

                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, top: 50),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Favoriten",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),

                      //SearchBar(),
                      SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: FavoritesScreen(),
                      )
                    ],
                  ),
                )
              : Container(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        color: _greenApp,
        index: 0,
        backgroundColor: Colors.white,
        buttonBackgroundColor: Colors.white,
        height: 50,
        animationDuration: Duration(milliseconds: 200),
        animationCurve: Curves.slowMiddle,
        items: <Widget>[
          Icon(
            EvaIcons.homeOutline,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            EvaIcons.heartOutline,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            EvaIcons.plusCircleOutline,
            size: 25,
            color: Colors.black,
          ),
          Icon(
            EvaIcons.personOutline,
            size: 25,
            color: Colors.black,
          )
        ],
        onTap: (index) {
          //debugPrint("Current index is: $index");

          setState(() {
            _page = index;
          });
          if (_page == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NewAnnouncementScreen()));
          } else if (_page == 3) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAccountScreen()));
          }
        },
      ),
    );
  }
}
