/// on_boarding_pages : [{"on_boarding_image":"assets/images/on_boarding1.png","on_boarding_icon":"assets/svgs/card_icon.svg","on_boarding_header":"Order for Food","on_boarding_body":"Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."},{"on_boarding_image":"assets/images/on_boarding1.png","on_boarding_icon":"assets/svgs/card_icon.svg","on_boarding_header":"Order for Food","on_boarding_body":"Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."}]

class OnBoardingPojo {
  OnBoardingPojo({
    List<OnBoardingPages>? onBoardingPages,
  }) {
    _onBoardingPages = onBoardingPages;
  }

  OnBoardingPojo.fromJson(dynamic json) {
    if (json['on_boarding_pages'] != null) {
      _onBoardingPages = [];
      json['on_boarding_pages'].forEach((v) {
        _onBoardingPages?.add(OnBoardingPages.fromJson(v));
      });
    }
  }

  List<OnBoardingPages>? _onBoardingPages;

  List<OnBoardingPages> get onBoardingPages => _onBoardingPages ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_onBoardingPages != null) {
      map['on_boarding_pages'] = _onBoardingPages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// on_boarding_image : "assets/images/on_boarding1.png"
/// on_boarding_icon : "assets/svgs/card_icon.svg"
/// on_boarding_header : "Order for Food"
/// on_boarding_body : "Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."

class OnBoardingPages {
  OnBoardingPages({
    String? onBoardingImage,
    String? onBoardingIcon,
    String? onBoardingHeader,
    String? onBoardingBody,
  }) {
    _onBoardingImage = onBoardingImage;
    _onBoardingIcon = onBoardingIcon;
    _onBoardingHeader = onBoardingHeader;
    _onBoardingBody = onBoardingBody;
  }

  OnBoardingPages.fromJson(dynamic json) {
    _onBoardingImage = json['on_boarding_image'];
    _onBoardingIcon = json['on_boarding_icon'];
    _onBoardingHeader = json['on_boarding_header'];
    _onBoardingBody = json['on_boarding_body'];
  }

  String? _onBoardingImage;
  String? _onBoardingIcon;
  String? _onBoardingHeader;
  String? _onBoardingBody;

  String get onBoardingImage => _onBoardingImage ?? "";

  String get onBoardingIcon => _onBoardingIcon ?? "";

  String get onBoardingHeader => _onBoardingHeader ?? "";

  String get onBoardingBody => _onBoardingBody ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['on_boarding_image'] = _onBoardingImage;
    map['on_boarding_icon'] = _onBoardingIcon;
    map['on_boarding_header'] = _onBoardingHeader;
    map['on_boarding_body'] = _onBoardingBody;
    return map;
  }
}
