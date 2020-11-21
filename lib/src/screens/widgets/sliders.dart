import 'package:flutter/material.dart';


//A personal widget for each element of the slider
class SliderTile extends StatelessWidget {

  String imagePath, sliderTitle, sliderDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(height: 20,),
          Text(sliderTitle),
          SizedBox(height: 12,),
          Text(sliderDescription),

        ],

      ),
    );
  }
}
