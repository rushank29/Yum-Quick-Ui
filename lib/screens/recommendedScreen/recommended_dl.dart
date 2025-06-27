/// recommended_list : [{"product_name":"Chocolate and Fresh Fruit Crepes","product_price":15.0,"product_description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit.","product_quantity":1,"product_image":"assets/images/chocolate_and_fresh_fruit_crepe.png","food_category_type":4},{"product_name":"Bean and vegetable burger","product_price":11.39,"product_description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit.","product_quantity":1,"product_image":"assets/images/bean_and_vegetable_burger.png","food_category_type":3},{"product_name":"Creamy milkshakes","product_price":14.45,"product_description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit.","product_quantity":1,"product_image":"assets/images/milkshakes.png","food_category_type":5},{"product_name":"Rajma Chawal","product_price":17.75,"product_description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit.","product_quantity":1,"product_image":"assets/images/bestseller2.png","food_category_type":2},{"product_name":"Chicken Curry","product_price":12.0,"product_description":"Lorem ipsum dolor sit amet, consectetur adipiscing elit.","product_quantity":1,"product_image":"assets/images/chicken_curry.png","food_category_type":2}]

class RecommendedPojo {
  RecommendedPojo({
      List<ItemRecommendedList>? recommendedList,}){
    _recommendedList = recommendedList;
}

  RecommendedPojo.fromJson(dynamic json) {
    if (json['recommended_list'] != null) {
      _recommendedList = [];
      json['recommended_list'].forEach((v) {
        _recommendedList?.add(ItemRecommendedList.fromJson(v));
      });
    }
  }
  List<ItemRecommendedList>? _recommendedList;

  List<ItemRecommendedList> get recommendedList => _recommendedList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_recommendedList != null) {
      map['recommended_list'] = _recommendedList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_name : "Chocolate and Fresh Fruit Crepes"
/// product_price : 15.0
/// product_description : "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
/// product_quantity : 1
/// product_image : "assets/images/chocolate_and_fresh_fruit_crepe.png"
/// food_category_type : 4

class ItemRecommendedList {
  ItemRecommendedList({
    String? productName,
    dynamic productPrice,
    String? productDescription,
    int? productQuantity,
    String? productImage,
    int? foodCategoryType,}){
    _productName = productName;
    _productPrice = productPrice;
    _productDescription = productDescription;
    _productQuantity = productQuantity;
    _productImage = productImage;
    _foodCategoryType = foodCategoryType;
  }

  ItemRecommendedList.fromJson(dynamic json) {
    _productName = json['product_name'];
    _productPrice = json['product_price'];
    _productDescription = json['product_description'];
    _productQuantity = json['product_quantity'];
    _productImage = json['product_image'];
    _foodCategoryType = json['food_category_type'];
  }
  String? _productName;
  dynamic _productPrice;
  String? _productDescription;
  int? _productQuantity;
  String? _productImage;
  int? _foodCategoryType;

  String get productName => _productName ?? "";
  dynamic get productPrice => _productPrice ?? 0;
  String get productDescription => _productDescription ?? "";
  int get productQuantity => _productQuantity ?? 0;
  String get productImage => _productImage ?? "";
  int get foodCategoryType => _foodCategoryType ?? 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_name'] = _productName;
    map['product_price'] = _productPrice;
    map['product_description'] = _productDescription;
    map['product_quantity'] = _productQuantity;
    map['product_image'] = _productImage;
    map['food_category_type'] = _foodCategoryType;
    return map;
  }

}