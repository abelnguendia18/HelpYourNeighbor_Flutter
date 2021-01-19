import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class AnnouncementsList extends StatefulWidget {
  @override
  _AnnouncementsListState createState() => _AnnouncementsListState();
}

class _AnnouncementsListState extends State<AnnouncementsList> {
  final Color _greenApp = Color(0xff89ca89);
  bool favSelected = false;
  var _statusList = [
    "Ich biete",
    "Ich suche",
    "Ich suche",
    "Ich biete",
    "Ich suche",
    "Ich biete"
  ];
  var _descriptionsList = [
    "Description 1",
    "Description 2",
    "Description 3",
    "Description 4"
        "Description 5",
    "Description 6"
  ];

  var _imagePath = [""];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        //shrinkWrap: true,
        itemCount: _descriptionsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {},
            child: Card(
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
                          child: Image.asset("assets/Einkaufshilfe_1.png"),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            //title and desc
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                _statusList[index],
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
                                _descriptionsList[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                ),
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
                          width: 1,
                        ),
                        Text(
                          "Stadt",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontFamily: "Roboto"),
                        ),
                        SizedBox(
                          width: 200,
                        ),
                        Icon(
                          Icons.share_outlined,
                          color: _greenApp,
                          size: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          icon: Icon(EvaIcons.heartOutline, color: _greenApp, size: 30,),
                          onPressed: (){

                          },
                        ),
                        //Icon(EvaIcons.heartOutline, color: _greenApp, size: 30, )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
