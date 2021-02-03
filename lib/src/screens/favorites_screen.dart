import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:help_your_neighbor/src/utils/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {

  final Color _greenApp = Color(0xff89ca89);
  bool favSelected = false;
  var _currentUserId;
  bool _setFavoriteDecision;
  var bigRslt;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentUserId = FirebaseAuth.instance.currentUser.uid;
    bigRslt = AuthenticationService.getFavoritesList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: bigRslt,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Daten werden geladen ..."),
            );
          } else {
            return Expanded(
                child: ListView.builder(
                  //shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {

                        print("Tandannnnn: ${snapshot.data[index].id}");
                      },

                      // We don't need to show here the announcements created by the current User.
                      child: _currentUserId != snapshot.data[index]['ownerId']
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
                                        snapshot.data[index]['imagePath']),
                                    // child: Image.asset(_imagePath[index]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      //title and desc
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          snapshot.data[index]['status'],
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data[index]['description'],
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          maxLines: 3,
                                          softWrap: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
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
                                    snapshot.data[index]['ownerAddress'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        fontFamily: "Roboto"),
                                  ),

                                  /* Icon(
                          Icons.share_outlined,
                          color: _greenApp,
                          size: 30,
                        ),*/
                                  SizedBox(
                                    width: 250,
                                  ),
                                  IconButton(
                                    icon: snapshot.data[index]['isFavorite'] == "ja" ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 30,
                                    ): Icon( Icons.favorite_border_outlined, color: _greenApp),

/*                                    onPressed: () async {
                                      if(snapshot.data[index]['isFavorite'] == "ja") {
                                        await AuthenticationService
                                            .updateFavoriteState(
                                            snapshot.data[index].id
                                                .toString(), "nein");
                                      }else if(snapshot.data[index]['isFavorite'] == "nein"){

                                        await AuthenticationService
                                            .updateFavoriteState(
                                            snapshot.data[index].id
                                                .toString(), "ja");
                                      }
                                      setState(() {
                                        bigRslt = AuthenticationService.getAnnouncementsList();
                                      });

                                    },*/
                                  ),
                                  //Icon(EvaIcons.heartOutline, color: _greenApp, size: 30, )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                          : Container(),
                    );
                  },
                ));
          }
        },
      ),
    );
  }

  Widget isFavorite(bool value){

    if(value == true){

      return Icon(Icons.favorite, color: Colors.red,);
    } else{
      return Icon(Icons.favorite, color: _greenApp);
    }

  }
}
