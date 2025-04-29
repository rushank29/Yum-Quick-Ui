/// welcome_image : "assets/images/welcome_image.png"
/// welcome_text : "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod."

class WelcomePojo {
  WelcomePojo({
      String? welcomeImage, 
      String? welcomeText,}){
    _welcomeImage = welcomeImage;
    _welcomeText = welcomeText;
}

  WelcomePojo.fromJson(dynamic json) {
    _welcomeImage = json['welcome_image'];
    _welcomeText = json['welcome_text'];
  }
  String? _welcomeImage;
  String? _welcomeText;

  String get welcomeImage => _welcomeImage ?? "";
  String get welcomeText => _welcomeText ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['welcome_image'] = _welcomeImage;
    map['welcome_text'] = _welcomeText;
    return map;
  }

}