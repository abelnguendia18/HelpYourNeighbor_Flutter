import 'package:flutter/material.dart';
import 'package:help_your_neighbor/src/models/announcement_model.dart';
import 'package:help_your_neighbor/src/screens/home_screen.dart';

class AnnouncementDetailsScreen extends StatelessWidget {


  final Color _greenApp = Color(0xff89ca89);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: AnnouncementDetailsScreenState(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: _greenApp,
        ));
  }
}

class AnnouncementDetailsScreenState extends StatefulWidget {
  Announcement announcement;
  AnnouncementDetailsScreenState({Key key, @required this.announcement}): super(key: key);

  @override
  _AnnouncementDetailsScreenStateState createState() =>
      _AnnouncementDetailsScreenStateState(announcement);
}

class _AnnouncementDetailsScreenStateState
    extends State<AnnouncementDetailsScreenState> {
  Announcement announcement;
  _AnnouncementDetailsScreenStateState(this.announcement);
  final Color greenApp = Color(0xff89ca89);
  var _selectedIndex = 0;

  @override
/*  void initState() {
    // TODO: implement initState

    BuildContext context;
    final Announcement announcement = ModalRoute.of(context).settings.arguments;
    print("phone Number: ${announcement.ownerPhoneNumber}");
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    //final Announcement announcement = ModalRoute.of(context).settings.arguments;
    return Scaffold(
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
          title: Text("Details über die Anzeige"),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Text("Beschreibung: ${announcement.descriptionAnnouncement}"),
                 //Text(announcement.ownerPhoneNumber),

                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 20.0),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 60.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 160.0,
                      height: 80.0,
                      child: RaisedButton.icon(
                        color: greenApp,
                        onPressed: () {},
                        icon: Icon(Icons.call),
                        label: Text("Anrufen"),
                        elevation: 0.0,
                      ),
                    ),
                    Container(
                      width: 160.0,
                      height: 80.0,
                      child: RaisedButton.icon(
                        color: greenApp,
                        onPressed: () {},
                        icon: Icon(Icons.email),
                        label: Text("Schreiben"),
                        elevation: 0.0,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
