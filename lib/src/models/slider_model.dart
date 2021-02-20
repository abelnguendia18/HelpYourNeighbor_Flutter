class SliderModel{
  String imagePath;
  String sliderTitle;
  String sliderDescription;

  SliderModel({this.imagePath, this.sliderTitle, this.sliderDescription});

  void setImagePath(String oneImagePath){
    imagePath = oneImagePath;
  }

  void setSliderTitle(String oneSliderTitle){
    sliderTitle = oneSliderTitle;
  }

  void setSliderDescription(String oneSliderDescription){
    sliderDescription = oneSliderDescription;
  }

  String getImagePath(){
    return this.imagePath;
  }
  String getSliderTitle(){
    return this.sliderTitle;
  }
  String getSliderDescription(){
    return sliderDescription;
}

}

List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  sliderModel.setImagePath("assets/Einkaufshilfe.jpg");
  sliderModel.setSliderTitle("Einkaufshilfe");
  sliderModel.setSliderDescription("Finden Sie anhand der App Einkaufshilfe in Ihrer Nähe.");
  slides.add(sliderModel);

   sliderModel = new SliderModel();

  //2
  sliderModel.setImagePath("assets/putzen.jpg");
  sliderModel.setSliderTitle("Putzhilfe");
  sliderModel.setSliderDescription("Brauchen Sie Unterstützung beim Putzen? Kein Problem, hier finden Sie Leute,"
      " die bereits Ihnen dabei zu helfen sind.");
  slides.add(sliderModel);

   sliderModel = new SliderModel();
  //3
  sliderModel.setImagePath("assets/gassi.PNG");
  sliderModel.setSliderTitle("Gassi");
  sliderModel.setSliderDescription("Finden Sie auch jemanden, der mit Ihrem Hunde Gassi gehen könnte.");
  slides.add(sliderModel);

  return slides;



}