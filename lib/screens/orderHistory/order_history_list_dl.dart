/// order_history : [{"order_no":"0980624","order_date_time":"01-02-2025 09:49","billing_amount":46.25,"order_items":[{"product_name":"Chocolate Brownie","product_image":"assets/images/chocolate_brownie.png","product_price":17,"product_quantity":3,"product_added_time":"01-02-2025 07:29"},{"product_name":"Chocolate Strawberry Cupcakes","product_image":"assets/images/bestseller4.png","product_price":12,"product_quantity":4,"product_added_time":"01-02-2025 08:12"},{"product_name":"Sunny Bruschetta","product_image":"assets/images/sunny_bruschetta.png","product_price":8.25,"product_quantity":5,"product_added_time":"01-02-2025 09:25"}],"sub_total":37.25,"tax_and_fees":6,"delivery_fees":3,"order_status":1},{"order_no":"0881990","order_date_time":"19-06-2024 18:38","billing_amount":43.5,"order_items":[{"product_name":"Fruit and Berry Tea","product_image":"assets/images/fruit_and_berry_tea.png","product_price":9,"product_quantity":2,"product_added_time":"19-06-2024 09:28"},{"product_name":"Mushroom Risotto","product_image":"assets/images/mushroom_risotto.png","product_price":14,"product_quantity":1,"product_added_time":"19-06-2024 10:53"},{"product_name":"Pizza","product_image":"assets/images/pizza.png","product_price":9.75,"product_quantity":1,"product_added_time":"19-06-2024 11:12"}],"sub_total":32.5,"tax_and_fees":8,"delivery_fees":3,"order_status":3},{"order_no":"0028762","order_date_time":"12-01-2024 18:38","billing_amount":55.5,"order_items":[{"product_name":"Bean And Vegetable Burger","product_image":"assets/images/bean_and_vegetable_burger.png","product_price":24,"product_quantity":3,"product_added_time":"12-01-2024 14:53"},{"product_name":"Barbeque Taco","product_image":"assets/images/barbeque_taco.png","product_price":7,"product_quantity":1,"product_added_time":"12-01-2024 11:12"},{"product_name":"Creamy Coffee","product_image":"assets/images/creamy_coffee.png","product_price":15.5,"product_quantity":2,"product_added_time":"12-01-2024 11:12"}],"sub_total":46.5,"tax_and_fees":6,"delivery_fees":3,"order_status":2},{"order_no":"0054752","order_date_time":"29-11-2023 13:20","billing_amount":40,"order_items":[{"product_name":"Strawberry Shake","product_image":"assets/images/strawberry_shake.png","product_price":20,"product_quantity":2,"product_added_time":"29-11-2023 15:00"},{"product_name":"Broccoli Lasagna","product_image":"assets/images/bestseller3.png","product_price":12,"product_quantity":1,"product_added_time":"29-11-2023 12:00"}],"sub_total":32,"tax_and_fees":5,"delivery_fees":3,"order_status":2}]

class OrderHistoryPojo {
  OrderHistoryPojo({
    List<ItemOrderList>? orderHistory,
  }) {
    _orderHistory = orderHistory;
  }

  OrderHistoryPojo.fromJson(dynamic json) {
    if (json['order_history'] != null) {
      _orderHistory = [];
      json['order_history'].forEach((v) {
        _orderHistory?.add(ItemOrderList.fromJson(v));
      });
    }
  }

  List<ItemOrderList>? _orderHistory;

  List<ItemOrderList> get orderHistory => _orderHistory ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_orderHistory != null) {
      map['order_history'] = _orderHistory?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// order_no : "0980624"
/// order_date_time : "01-02-2025 09:49"
/// billing_amount : 46.25
/// order_items : [{"product_name":"Chocolate Brownie","product_image":"assets/images/chocolate_brownie.png","product_price":17,"product_quantity":3,"product_added_time":"01-02-2025 07:29"},{"product_name":"Chocolate Strawberry Cupcakes","product_image":"assets/images/bestseller4.png","product_price":12,"product_quantity":4,"product_added_time":"01-02-2025 08:12"},{"product_name":"Sunny Bruschetta","product_image":"assets/images/sunny_bruschetta.png","product_price":8.25,"product_quantity":5,"product_added_time":"01-02-2025 09:25"}]
/// sub_total : 37.25
/// tax_and_fees : 6
/// delivery_fees : 3
/// order_status : 1

class ItemOrderList {
  ItemOrderList({
    String? orderNo,
    String? orderDateTime,
    dynamic billingAmount,
    List<OrderItems>? orderItems,
    dynamic subTotal,
    dynamic taxAndFees,
    dynamic deliveryFees,
    int? orderStatus,
  }) {
    _orderNo = orderNo;
    _orderDateTime = orderDateTime;
    _billingAmount = billingAmount;
    _orderItems = orderItems;
    _subTotal = subTotal;
    _taxAndFees = taxAndFees;
    _deliveryFees = deliveryFees;
    _orderStatus = orderStatus;
  }

  ItemOrderList.fromJson(dynamic json) {
    _orderNo = json['order_no'];
    _orderDateTime = json['order_date_time'];
    _billingAmount = json['billing_amount'];
    if (json['order_items'] != null) {
      _orderItems = [];
      json['order_items'].forEach((v) {
        _orderItems?.add(OrderItems.fromJson(v));
      });
    }
    _subTotal = json['sub_total'];
    _taxAndFees = json['tax_and_fees'];
    _deliveryFees = json['delivery_fees'];
    _orderStatus = json['order_status'];
  }

  String? _orderNo;
  String? _orderDateTime;
  dynamic _billingAmount;
  List<OrderItems>? _orderItems;
  dynamic _subTotal;
  dynamic _taxAndFees;
  dynamic _deliveryFees;
  int? _orderStatus;

  String get orderNo => _orderNo ?? "";

  String get orderDateTime => _orderDateTime ?? "";

  dynamic get billingAmount => _billingAmount ?? 0;

  List<OrderItems> get orderItems => _orderItems ?? [];

  dynamic get subTotal => _subTotal ?? 0;

  dynamic get taxAndFees => _taxAndFees ?? 0;

  dynamic get deliveryFees => _deliveryFees ?? 0;

  int get orderStatus => _orderStatus ?? 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_no'] = _orderNo;
    map['order_date_time'] = _orderDateTime;
    map['billing_amount'] = _billingAmount;
    if (_orderItems != null) {
      map['order_items'] = _orderItems?.map((v) => v.toJson()).toList();
    }
    map['sub_total'] = _subTotal;
    map['tax_and_fees'] = _taxAndFees;
    map['delivery_fees'] = _deliveryFees;
    map['order_status'] = _orderStatus;
    return map;
  }
}

/// product_name : "Chocolate Brownie"
/// product_image : "assets/images/chocolate_brownie.png"
/// product_price : 17
/// product_quantity : 3
/// product_added_time : "01-02-2025 07:29"

class OrderItems {
  OrderItems({
    String? productName,
    String? productImage,
    dynamic productPrice,
    int? productQuantity,
    String? productAddedTime,
  }) {
    _productName = productName;
    _productImage = productImage;
    _productPrice = productPrice;
    _productQuantity = productQuantity;
    _productAddedTime = productAddedTime;
  }

  OrderItems.fromJson(dynamic json) {
    _productName = json['product_name'];
    _productImage = json['product_image'];
    _productPrice = json['product_price'];
    _productQuantity = json['product_quantity'];
    _productAddedTime = json['product_added_time'];
  }

  String? _productName;
  String? _productImage;
  dynamic _productPrice;
  int? _productQuantity;
  String? _productAddedTime;

  String get productName => _productName ?? "";

  String get productImage => _productImage ?? "";

  dynamic get productPrice => _productPrice ?? 0;

  int get productQuantity => _productQuantity ?? 0;

  String get productAddedTime => _productAddedTime ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_name'] = _productName;
    map['product_image'] = _productImage;
    map['product_price'] = _productPrice;
    map['product_quantity'] = _productQuantity;
    map['product_added_time'] = _productAddedTime;
    return map;
  }
}
