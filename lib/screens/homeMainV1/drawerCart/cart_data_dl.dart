/// cart_list : [{"cart_item_image":"assets/images/strawberry_shake.png","cart_item_name":"Strawberry shake","item_price":10,"item_adding_date":"29-11-2024","item_quantity":2},{"cart_item_image":"assets/images/assets/images/bestseller3.png","cart_item_name":"Broccoli Lasagna","item_price":12.5,"item_adding_date":"29-11-2024","item_quantity":1}]
/// subtotal : 32.5
/// tax_and_fees : 4.5
/// delivery_fees : 3.5
/// total : 40.5

class CartDataPojo {
  CartDataPojo({
    List<ItemCartList>? cartList,
    dynamic subtotal,
    dynamic taxAndFees,
    dynamic deliveryFees,
    dynamic total,
    String? estimatedDelivery,
  }) {
    _cartList = cartList;
    _subtotal = subtotal;
    _taxAndFees = taxAndFees;
    _deliveryFees = deliveryFees;
    _total = total;
    _estimatedDelivery = estimatedDelivery;
  }

  CartDataPojo.fromJson(dynamic json) {
    if (json['cart_list'] != null) {
      _cartList = [];
      json['cart_list'].forEach((v) {
        _cartList?.add(ItemCartList.fromJson(v));
      });
    }
    _subtotal = json['subtotal'];
    _taxAndFees = json['tax_and_fees'];
    _deliveryFees = json['delivery_fees'];
    _total = json['total'];
    _estimatedDelivery = json['estimated_delivery'];
  }

  List<ItemCartList>? _cartList;
  dynamic _subtotal;
  dynamic _taxAndFees;
  dynamic _deliveryFees;
  dynamic _total;
  String? _estimatedDelivery;

  List<ItemCartList>? get cartList => _cartList;

  dynamic get subtotal => _subtotal ?? 0;

  dynamic get taxAndFees => _taxAndFees ?? 0;

  dynamic get deliveryFees => _deliveryFees ?? 0;

  dynamic get total => _total ?? 0;
  String get estimatedDelivery => _estimatedDelivery ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cartList != null) {
      map['cart_list'] = _cartList?.map((v) => v.toJson()).toList();
    }
    map['subtotal'] = _subtotal;
    map['tax_and_fees'] = _taxAndFees;
    map['delivery_fees'] = _deliveryFees;
    map['total'] = _total;
    map['estimated_delivery'] = _estimatedDelivery;
    return map;
  }
}

/// cart_item_image : "assets/images/strawberry_shake.png"
/// cart_item_name : "Strawberry shake"
/// item_price : 10
/// item_adding_date : "29-11-2024"
/// item_quantity : 2

class ItemCartList {
  ItemCartList({
    int? cartItemId,
    String? cartItemImage,
    String? cartItemName,
    dynamic itemPrice,
    String? itemAddingDate,
    String? itemAddingTime,
    int? itemQuantity,
  }) {
    _cartItemId = cartItemId;
    _cartItemImage = cartItemImage;
    _cartItemName = cartItemName;
    _itemPrice = itemPrice;
    _itemAddingDate = itemAddingDate;
    _itemAddingTime = itemAddingTime;
    _itemQuantity = itemQuantity;
  }

  ItemCartList.fromJson(dynamic json) {
    _cartItemId = json['cart_item_id'];
    _cartItemImage = json['cart_item_image'];
    _cartItemName = json['cart_item_name'];
    _itemPrice = json['item_price'];
    _itemAddingDate = json['item_adding_date'];
    _itemAddingTime = json['item_adding_time'];
    _itemQuantity = json['item_quantity'];
  }

  int? _cartItemId;
  String? _cartItemImage;
  String? _cartItemName;
  dynamic _itemPrice;
  String? _itemAddingDate;
  String? _itemAddingTime;
  int? _itemQuantity;

  int get cartItemId => _cartItemId ?? 0;
  String get cartItemImage => _cartItemImage ?? "";

  String get cartItemName => _cartItemName ?? "";

  dynamic get itemPrice => _itemPrice ?? 0;

  String get itemAddingDate => _itemAddingDate ?? "";

  String get itemAddingTime => _itemAddingTime ?? "";

  int get itemQuantity => _itemQuantity ?? 0;

  void setItemQuantity(int quantity) {
    _itemQuantity = quantity;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cart_item_id'] = _cartItemId;
    map['cart_item_image'] = _cartItemImage;
    map['cart_item_name'] = _cartItemName;
    map['item_price'] = _itemPrice;
    map['item_adding_date'] = _itemAddingDate;
    map['item_adding_time'] = _itemAddingTime;
    map['item_quantity'] = _itemQuantity;
    return map;
  }
}
