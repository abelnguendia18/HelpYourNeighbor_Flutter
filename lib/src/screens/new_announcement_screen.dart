import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewAnnouncementScreen extends StatefulWidget {
  @override
  _NewAnnouncementScreenState createState() => _NewAnnouncementScreenState();
}

class _NewAnnouncementScreenState extends State<NewAnnouncementScreen> {
  final Color _greenApp = Color(0xff89ca89);

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
  Widget build(BuildContext context) {
    return WillPopScope(

        child: Scaffold(
          body: SingleChildScrollView(

           child: Container(
             padding: EdgeInsets.only(top: 10.0),
             child: Column(
               children: <Widget>[
                 Text("Neues Inserat", style: TextStyle(color: _greenApp),),
                 SizedBox(height: 10.0,),
                 Form(
                   child: Container(
                     child: Column(
                       children: <Widget>[
                         TextFormField(

                         ),
                       ],
                     ),
                   ),
                 ),

               ],

             ),
           ),
          ),


        ),
        onWillPop: _onBackPressed,
    );
  }
}
