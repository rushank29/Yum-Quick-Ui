/// order_history : [{"item_image":"assets/images/bestseller2.png","item_name":"Chicken Curry","order_amount":50.00,"order_date_time":"29-11-2024, 13:20","order_item_count":2},{"item_image":"assets/images/home_burger.png","item_name":"Bean and Vegetable Burger","order_amount":50.00,"order_date_time":"10-11-2024, 18:05","order_item_count":2},{"item_image":"assets/images/coffee_latte.png","item_name":"Bean and Vegetable Burger","order_amount":8.00,"order_date_time":"10-11-2024, 08:30","order_item_count":1},{"item_image":"assets/images/strawberry_cheesecake.png","item_name":"Bean and Vegetable Burger","order_amount":22.00,"order_date_time":"03-10-2024, 15:40","order_item_count":2}]

class MyOrdersPojo {
  MyOrdersPojo({
    List<ItemOrderHistory>? itemOrderHistory,
  }) {
    _itemOrderHistory = itemOrderHistory;
  }

  MyOrdersPojo.fromJson(dynamic json) {
    if (json['order_history'] != null) {
      _itemOrderHistory = [];
      json['order_history'].forEach((v) {
        _itemOrderHistory?.add(ItemOrderHistory.fromJson(v));
      });
    }
  }

  List<ItemOrderHistory>? _itemOrderHistory;

  List<ItemOrderHistory> get itemOrderHistory => _itemOrderHistory ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_itemOrderHistory != null) {
      map['order_history'] = _itemOrderHistory?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// item_image : "assets/images/bestseller2.png"
/// item_name : "Chicken Curry"
/// order_amount : 50.00
/// order_date_time : "29-11-2024, 13:20"
/// order_item_count : 2

class ItemOrderHistory {
  ItemOrderHistory({
    String? itemImage,
    String? itemName,
    dynamic orderAmount,
    String? orderDateTime,
    int? orderItemCount,
  }) {
    _itemImage = itemImage;
    _itemName = itemName;
    _orderAmount = orderAmount;
    _orderDateTime = orderDateTime;
    _orderItemCount = orderItemCount;
  }

  ItemOrderHistory.fromJson(dynamic json) {
    _itemImage = json['item_image'];
    _itemName = json['item_name'];
    _orderAmount = json['order_amount'];
    _orderDateTime = json['order_date_time'];
    _orderItemCount = json['order_item_count'];
  }

  String? _itemImage;
  String? _itemName;
  dynamic _orderAmount;
  String? _orderDateTime;
  int? _orderItemCount;

  String get itemImage => _itemImage ?? "";

  String get itemName => _itemName ?? "";

  dynamic get orderAmount => _orderAmount ?? 0;

  String get orderDateTime => _orderDateTime ?? "";

  int get orderItemCount => _orderItemCount ?? 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_image'] = _itemImage;
    map['item_name'] = _itemName;
    map['order_amount'] = _orderAmount;
    map['order_date_time'] = _orderDateTime;
    map['order_item_count'] = _orderItemCount;
    return map;
  }
}
