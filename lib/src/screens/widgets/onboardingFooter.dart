import 'package:flutter/material.dart';

class OnboardingFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          InkWell(
            child: Text("SKIP"),
          ),
        ],
      ),
    );
  }
}
