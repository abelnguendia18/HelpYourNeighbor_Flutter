import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:help_your_neighbor/src/models/announcement_model.dart';
import 'package:help_your_neighbor/src/screens/announcement_details_screen.dart';
import 'package:help_your_neighbor/src/utils/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AnnouncementsList extends StatefulWidget {
  @override
  _AnnouncementsListState createState() => _AnnouncementsListState();
}

class _AnnouncementsListState extends State<AnnouncementsList> {
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
    bigRslt = AuthenticationService.getAnnouncementsList();
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
          } else if (snapshot.data.length < 1) {
            return Center(
              child: Text(
                "Es sind keine Anzeigen verfügbar...",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            );
          } else {
            return Expanded(
                child: ListView.builder(
              //shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Announcement announcement = Announcement(
                        categoryAnnouncement: snapshot.data[index]['category'],
                        isFavorite: snapshot.data[index]['isFavorite'],
                        statusAnnouncement: snapshot.data[index]['status'],
                        priceAnnouncement: snapshot.data[index]['price'],
                        ownerPhoneNumber: snapshot.data[index]
                            ['ownerPhoneNumber'],
                        ownerId: snapshot.data[index]['ownerId'],
                        ownerAddress: snapshot.data[index]['ownerAddress'],
                        imagePath: snapshot.data[index]['imagePath'],
                        descriptionAnnouncement: snapshot.data[index]
                            ['description']);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnnouncementDetailsScreenState(
                              announcement: announcement),
                          //settings: RouteSettings(arguments: announcement),
                        ));
                    print("category: ${snapshot.data[index]['category']}");
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
                                          Container(
                                            width: 200.0,
                                            child: Text(
                                              snapshot.data[index]
                                                  ['description'],
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: true,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                //padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                //width: 900,
                                //Group 2: location, favIcon
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
                                    Container(
                                      width: 150.0,
                                      child: Text(
                                        snapshot.data[index]['ownerAddress'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: "Roboto"),
                                      ),
                                    ),

                                    Container(
                                        padding: EdgeInsets.only(
                                          left: 150,
                                        ),
                                        child: IconButton(
                                          icon: snapshot.data[index]
                                                      ['isFavorite'] ==
                                                  "ja"
                                              ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 30,
                                                )
                                              : Icon(
                                                  Icons
                                                      .favorite_border_outlined,
                                                  color: _greenApp,
                                                  size: 30,
                                                ),
                                          onPressed: () async {
                                            if (snapshot.data[index]
                                                    ['isFavorite'] ==
                                                "ja") {
                                              await AuthenticationService
                                                  .updateFavoriteState(
                                                      snapshot.data[index].id
                                                          .toString(),
                                                      "nein");
                                            } else if (snapshot.data[index]
                                                    ['isFavorite'] ==
                                                "nein") {
                                              await AuthenticationService
                                                  .updateFavoriteState(
                                                      snapshot.data[index].id
                                                          .toString(),
                                                      "ja");
                                            }
                                            setState(() {
                                              bigRslt = AuthenticationService
                                                  .getAnnouncementsList();
                                            });
                                          },
                                        )),

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
}
