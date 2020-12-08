import 'package:flutter/material.dart';


//A personal widget for each element of the slider
/*class SliderTile extends StatelessWidget {

  String imagePath, sliderTitle, sliderDescription;
  SliderTile({this.imagePath, this.sliderTitle, this.sliderDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
}*/

class SliderTile extends StatelessWidget {
  //String imagePath, title, desc;

  //SliderTile({this.imagePath, this.title, this.desc});

  String imagePath, sliderTitle, sliderDescription;
  SliderTile({this.imagePath, this.sliderTitle, this.sliderDescription});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 40,
          ),
          Text(sliderTitle, textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20
          ),),
          SizedBox(
            height: 20,
          ),
          Text(sliderDescription, textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14))
        ],
      ),
    );
  }
}