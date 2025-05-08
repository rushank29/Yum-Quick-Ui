/// contact_us_data_list : [{"item_id":1,"item_icon":"assets/svg/help_and_support_icon.svg","item_title":"Customer Service"},{"item_id":2,"item_icon":"assets/svg/website_icon.svg","item_title":"Website"},{"item_id":3,"item_icon":"assets/svg/whatsapp_icon.svg","item_title":"Whatsapp"},{"item_id":4,"item_icon":"assets/svg/facebook_icon.svg","item_title":"Facebook"},{"item_id":5,"item_icon":"assets/svg/instagram_icon.svg","item_title":"Instagram"}]

class ContactUsDataPojo {
  ContactUsDataPojo({
      List<ItemContactUsDataList>? contactUsDataList,}){
    _contactUsDataList = contactUsDataList;
}

  ContactUsDataPojo.fromJson(dynamic json) {
    if (json['contact_us_data_list'] != null) {
      _contactUsDataList = [];
      json['contact_us_data_list'].forEach((v) {
        _contactUsDataList?.add(ItemContactUsDataList.fromJson(v));
      });
    }
  }
  List<ItemContactUsDataList>? _contactUsDataList;

  List<ItemContactUsDataList> get contactUsDataList => _contactUsDataList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_contactUsDataList != null) {
      map['contact_us_data_list'] = _contactUsDataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// item_id : 1
/// item_icon : "assets/svg/help_and_support_icon.svg"
/// item_title : "Customer Service"

class ItemContactUsDataList {
  ItemContactUsDataList({
    int? itemId,
    String? itemIcon,
    String? itemTitle,}){
    _itemId = itemId;
    _itemIcon = itemIcon;
    _itemTitle = itemTitle;
  }

  ItemContactUsDataList.fromJson(dynamic json) {
    _itemId = json['item_id'];
    _itemIcon = json['item_icon'];
    _itemTitle = json['item_title'];
  }
  int? _itemId;
  String? _itemIcon;
  String? _itemTitle;

  int get itemId => _itemId ?? 0;
  String get itemIcon => _itemIcon ?? "";
  String get itemTitle => _itemTitle ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_id'] = _itemId;
    map['item_icon'] = _itemIcon;
    map['item_title'] = _itemTitle;
    return map;
  }

}