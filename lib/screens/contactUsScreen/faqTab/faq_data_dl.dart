/// faq_data_list : [{"item_id":1,"_item_subtitle":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam.","item_title":"Lorem ipsum dolor sit amet?"},{"item_id":2,"_item_subtitle":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam.","item_title":"Lorem ipsum dolor sit amet?"},{"item_id":3,"_item_subtitle":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam.","item_title":"Lorem ipsum dolor sit amet?"},{"item_id":4,"_item_subtitle":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam.","item_title":"Lorem ipsum dolor sit amet?"},{"item_id":5,"_item_subtitle":"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam.","item_title":"Lorem ipsum dolor sit amet?"}]

class FaqDataPojo {
  FaqDataPojo({
      List<ItemFaqDataList>? faqDataList,}){
    _faqDataList = faqDataList;
}

  FaqDataPojo.fromJson(dynamic json) {
    if (json['faq_data_list'] != null) {
      _faqDataList = [];
      json['faq_data_list'].forEach((v) {
        _faqDataList?.add(ItemFaqDataList.fromJson(v));
      });
    }
  }
  List<ItemFaqDataList>? _faqDataList;

  List<ItemFaqDataList> get faqDataList => _faqDataList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_faqDataList != null) {
      map['faq_data_list'] = _faqDataList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// item_id : 1
/// _item_subtitle : "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor placerat a. Proin ac diam quam. Aenean in sagittis magna, ut feugiat diam."
/// item_title : "Lorem ipsum dolor sit amet?"

class ItemFaqDataList {
  ItemFaqDataList({
    int? itemId,
    String? itemSubtitle,
    String? itemTitle,}){
    _itemId = itemId;
    _itemSubtitle = itemSubtitle;
    _itemTitle = itemTitle;
  }

  ItemFaqDataList.fromJson(dynamic json) {
    _itemId = json['item_id'];
    _itemSubtitle = json['_item_subtitle'];
    _itemTitle = json['item_title'];
  }
  int? _itemId;
  String? _itemSubtitle;
  String? _itemTitle;

  int get itemId => _itemId ?? 0;
  String get itemSubtitle => _itemSubtitle ?? "";
  String get itemTitle => _itemTitle ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_id'] = _itemId;
    map['_item_subtitle'] = _itemSubtitle;
    map['item_title'] = _itemTitle;
    return map;
  }

}