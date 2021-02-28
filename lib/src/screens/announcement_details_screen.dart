import 'package:flutter/material.dart';
import 'package:help_your_neighbor/src/models/announcement_model.dart';
import 'package:help_your_neighbor/src/screens/home_screen.dart';
import 'package:help_your_neighbor/src/utils.dart';

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

  AnnouncementDetailsScreenState({Key key, @required this.announcement})
      : super(key: key);

  @override
  _AnnouncementDetailsScreenStateState createState() =>
      _AnnouncementDetailsScreenStateState(announcement);
}

class _AnnouncementDetailsScreenStateState
    extends State<AnnouncementDetailsScreenState> {
  Announcement announcement;
  Future<void> _launched;

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
          backgroundColor: greenApp,
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
          //Text("${announcement.statusAnnouncement}"),

        ),
        body: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 60.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      announcement.imagePath,
                      height: 150.0,
                      width: 150.0,
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  /*   Text("${announcement.statusAnnouncement}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
                  ),*/
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                    child: Text(
                      "${announcement.descriptionAnnouncement}",
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 20.0),
                    ),
                  ),

                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 0),
                    child: Text(
                      "${announcement.priceAnnouncement} Euro/Stunde",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),


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
                      width: 140.0,
                      height: 80.0,
                      child: RaisedButton.icon(
                        onPressed: () {
                          var phoneNumber = announcement.ownerPhoneNumber;

                          setState(() {
                            _launched = Utils.makeCall("tel:$phoneNumber");
                          });
                        },
                        color: greenApp,
                        icon: Icon(Icons.call),
                        label: Text("Anrufen"),
                        elevation: 0.0,
                      ),
                    ),
                    SizedBox(width: 40.0,),
                    Container(
                      width: 140.0,
                      height: 80.0,
                      child: RaisedButton.icon(
                        color: greenApp,
                        onPressed: () {
                          var phoneNumber = announcement.ownerPhoneNumber;

                          setState(() {
                            _launched = Utils.sendSms("sms:$phoneNumber");
                          });

                        },
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
