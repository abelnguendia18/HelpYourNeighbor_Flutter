import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreenStateful(),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum BottomIcons{
  Home,
  Favorite,
  Add,
  Account
}

class HomeScreenStateful extends StatefulWidget {
  @override
  _HomeScreenStatefulState createState() => _HomeScreenStatefulState();
}

class _HomeScreenStatefulState extends State<HomeScreenStateful> {

  //that is the default state, when the authentication was successful

  BottomIcons bottomIcons = BottomIcons.Home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: <Widget>[
            bottomIcons == BottomIcons.Home ? Center(
              child: Text("Home"),
            ) : Container() ,
            bottomIcons == BottomIcons.Favorite ? Center(
              child: Text("Favoriten"),
            ) : Container() ,
            bottomIcons == BottomIcons.Add ? Center(
              child: Text("Neues Inserat"),
            ) : Container() ,
            bottomIcons == BottomIcons.Account ? Center(
              child: Text("Account"),
            ) : Container() ,
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 24,
                right: 24, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          setState(() {
                              bottomIcons = BottomIcons.Home;
                          });
                        },
                        child: bottomIcons == BottomIcons.Home ? Container(
                          decoration: BoxDecoration(
                              color: Colors.indigo.shade100.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                            padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                            child: Row(
                              children: <Widget>[
                                Icon(EvaIcons.homeOutline),
                                SizedBox(width: 8,),
                                Text("Home",
                                style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),),
                              ],
                            ),

                        ):Icon(EvaIcons.homeOutline),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            bottomIcons = BottomIcons.Favorite;
                          });
                        },
                        child: bottomIcons == BottomIcons.Favorite ? Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade100.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                          child: Row(
                            children: <Widget>[
                              Icon(EvaIcons.heartOutline),
                              SizedBox(width: 8,),
                              Text("Favoriten",
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),),
                            ],
                          ),

                        ):Icon(EvaIcons.heartOutline),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            bottomIcons = BottomIcons.Add;
                          });
                        },
                        child: bottomIcons == BottomIcons.Add ? Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade100.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                          child: Row(
                            children: <Widget>[
                              Icon(EvaIcons.plusCircleOutline),
                              SizedBox(width: 8,),
                              Text("Inserat",
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),),
                            ],
                          ),

                        ):Icon(EvaIcons.plusCircleOutline),
                      ),
                      GestureDetector(
                        onTap: (){
                          setState(() {
                            bottomIcons = BottomIcons.Account;
                          });
                        },
                        child: bottomIcons == BottomIcons.Account ? Container(
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade100.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                          child: Row(
                            children: <Widget>[
                              Icon(EvaIcons.personOutline),
                              SizedBox(width: 8,),
                              Text("Account",
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                ),),
                            ],
                          ),

                        ):Icon(EvaIcons.personOutline),
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
      ),


    );
  }
}
