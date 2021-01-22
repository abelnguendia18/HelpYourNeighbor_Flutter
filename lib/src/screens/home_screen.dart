import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          _page == 0
              ? Container(
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
              ? Center(
                  child: Text("Favoriten"),
                )
              : Container(),
/*          _page == 3
              ? Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyAccountScreen()))
              : Container(),*/
        ],
      ),

      /*body: Stack(
        children: <Widget>[
          bottomIcons == BottomIcons.Home
              ? Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 100.0, top: 40.0, ),
                      child: SearchBar(),
                    ),
                    Expanded(child:AnnouncementsList()),
                   // AnnouncementsList(),

                  ],
                )
              : Container(),
          bottomIcons == BottomIcons.Favorite
              ? Center(
                  child: Text("Favoriten"),
                )
              : Container(),
          bottomIcons == BottomIcons.Add
              ? Center(
                  child: Text("Neues Inserat"),
                )
              : Container(),
          bottomIcons == BottomIcons.Account
              ? Center(
                  child: Text("Account"),
                )
              : Container(),
         Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              color: _greenApp,
              padding: EdgeInsets.only(left: 24, right: 24, bottom: 5, top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        bottomIcons = BottomIcons.Home;
                      });
                    },
                    child: bottomIcons == BottomIcons.Home
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  EvaIcons.homeOutline,
                                  color: _greenApp,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Home",
                                  style: TextStyle(
                                      color: _greenApp,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        : Icon(EvaIcons.homeOutline),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        bottomIcons = BottomIcons.Favorite;
                      });
                    },
                    child: bottomIcons == BottomIcons.Favorite
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  EvaIcons.heartOutline,
                                  color: _greenApp,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Favoriten",
                                  style: TextStyle(
                                      color: _greenApp,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        : Icon(EvaIcons.heartOutline),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        bottomIcons = BottomIcons.Add;
                      });
                    },
                    child: bottomIcons == BottomIcons.Add
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  EvaIcons.plusCircleOutline,
                                  color: _greenApp,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Inserat",
                                  style: TextStyle(
                                      color: _greenApp,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        : Icon(EvaIcons.plusCircleOutline),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        bottomIcons = BottomIcons.Account;
                      });
                    },
                    child: bottomIcons == BottomIcons.Account
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.only(
                                left: 16, right: 16, top: 8, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  EvaIcons.personOutline,
                                  color: _greenApp,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  "Account",
                                  style: TextStyle(
                                      color: _greenApp,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          )
                        : Icon(EvaIcons.personOutline),
                  ),
                  //Icon(EvaIcons.homeOutline),
                  //Icon(EvaIcons.heartOutline),
                  //Icon(EvaIcons.plusCircleOutline),
                  //Icon(EvaIcons.personOutline),
                ],
              ),
            ),
          )
        ],
      ),*/
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
/*          _page == 3 ? Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyAccountScreen())): null;*/
          if(_page == 2){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewAnnouncementScreen()));
          } else if(_page == 3){
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyAccountScreen()));
          }
        },
      ),
    );
  }
}
