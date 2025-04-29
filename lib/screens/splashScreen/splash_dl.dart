/// splash_image : "assets/images/splash_image.png"

class SplashPojo {
  SplashPojo({
    String? splashImage,
  }) {
    _splashImage = splashImage;
  }

  SplashPojo.fromJson(dynamic json) {
    _splashImage = json['splash_image'];
  }

  String? _splashImage;

  String get splashImage => _splashImage ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['splash_image'] = _splashImage;
    return map;
  }
}
