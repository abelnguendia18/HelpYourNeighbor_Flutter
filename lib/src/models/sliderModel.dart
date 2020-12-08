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
  sliderModel.setSliderDescription("Finden Sie Einkaufshilfe in Ihrer Nähe.");
  slides.add(sliderModel);

   sliderModel = new SliderModel();

  //2
  sliderModel.setImagePath("assets/putzen.jpg");
  sliderModel.setSliderTitle("Putzhilfe");
  sliderModel.setSliderDescription("Finden Sie Putzhilfe in Ihrer Nähe.");
  slides.add(sliderModel);

   sliderModel = new SliderModel();
  //3
  sliderModel.setImagePath("assets/gassi.PNG");
  sliderModel.setSliderTitle("Gassi");
  sliderModel.setSliderDescription("Finden Sie auch jemanden, der mit Ihrem Hunde gassi gehen könnte.");
  slides.add(sliderModel);

  return slides;



}