import 'package:flutter/material.dart';
import 'package:help_your_neighbor/src/models/sliderModel.dart';
import 'package:help_your_neighbor/src/screens/widgets/sliders.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "HYN",
      home: Home() ,
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SliderModel> slides = new List<SliderModel>();
  int slideIndex = 0;
  Color greenApp = const Color.fromRGBO(137, 202, 137, 1.0);

  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides = getSlides();
    controller = new PageController();
  }

  @override
 /* Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        onPageChanged: (val){
          currentIndex = val;
        },
        itemCount: slides.length,
        itemBuilder: (context, index){
          return SliderTile(
            imagePath: slides[index].imagePath,
            sliderTitle: slides[index].sliderTitle,
            sliderDescription: slides[index].sliderDescription,
          );
        },
      ),
      bottomSheet: currentIndex != slides.length - 1 ? Container(

      ) : Container(

      ),
    );
  }*/

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                slideIndex = index;
              });
            },
            children: <Widget>[
              SliderTile(
                imagePath: slides[0].getImagePath(),
                sliderTitle: slides[0].getSliderTitle(),
                sliderDescription: slides[0].getSliderDescription(),
              ),
              SliderTile(
                imagePath: slides[1].getImagePath(),
                sliderTitle: slides[1].getSliderTitle(),
                sliderDescription: slides[1].getSliderDescription(),
              ),
              SliderTile(
                imagePath: slides[2].getImagePath(),
                sliderTitle: slides[2].getSliderTitle(),
                sliderDescription: slides[2].getSliderDescription(),
              )
            ],
          ),
        ),
        bottomSheet: slideIndex != 2 ? Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "SKIP",
                  style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                  ],),
              ),
              FlatButton(
                onPressed: (){
                  print("this is slideIndex: $slideIndex");
                  controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                },
                splashColor: Colors.blue[50],
                child: Text(
                  "NEXT",
                  style: TextStyle(color: Color(0xFF0074E4), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ): InkWell(
          onTap: (){
            print("Get Started Now");
          },
          child: Container(
            height: 60,
            //color: Colors.blue,
            color: greenApp,
            alignment: Alignment.center,
            child: Text(
              "GET STARTED NOW",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
