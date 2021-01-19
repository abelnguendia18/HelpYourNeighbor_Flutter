import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool _isFocusReceived = false;
  final Color _greenApp = Color(0xff89ca89);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: _isFocusReceived ? 230 : 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        color: Colors.white,
        boxShadow: kElevationToShadow[4],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 16),
            child: _isFocusReceived
                ? TextField(
                    decoration: InputDecoration(
                      hintText: "Suche nach Stadt filtern",
                      hintStyle: TextStyle(color: Colors.black12),
                      border: InputBorder.none,
                    ),
                  )
                : null,
          )),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            child: InkWell(
              onTap: () {
                setState(() {
                  _isFocusReceived = !_isFocusReceived;
                });
              },
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  _isFocusReceived ? EvaIcons.close : EvaIcons.search,
                  color: _greenApp, size: 28,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
