/// favorite_list : [{"product_name":"Chicken Curry","product_image":"assets/images/bestseller2.png","food_category_type":2,"product_description":"Lorem ipsum dolor sit amet, consectetur."},{"product_name":"Chicken Burger","product_image":"assets/images/home_burger.png","food_category_type":2,"product_description":"Lorem ipsum dolor sit amet, consectetur."},{"product_name":"Broccoli Lasagna","product_image":"assets/images/bestseller3.png","food_category_type":3,"product_description":"Lorem ipsum dolor sit amet, consectetur."},{"product_name":"Mexican Appetizer","product_image":"assets/images/mexican_appetizer.png","food_category_type":1,"product_description":"Lorem ipsum dolor sit amet, consectetur."},{"product_name":"Baked Chicken Wings","product_image":"assets/images/baked_chicken_wings.png","food_category_type":3,"product_description":"Lorem ipsum dolor sit amet, consectetur."},{"product_name":"Milkshakes","product_image":"assets/images/milkshakes.png","food_category_type":1,"product_description":"Lorem ipsum dolor sit amet, consectetur."}]

class FavoritesPojo {
  FavoritesPojo({
    List<ItemFavoriteList>? favoriteList,
  }) {
    _favoriteList = favoriteList;
  }

  FavoritesPojo.fromJson(dynamic json) {
    if (json['favorite_list'] != null) {
      _favoriteList = [];
      json['favorite_list'].forEach((v) {
        _favoriteList?.add(ItemFavoriteList.fromJson(v));
      });
    }
  }

  List<ItemFavoriteList>? _favoriteList;

  List<ItemFavoriteList> get favoriteList => _favoriteList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_favoriteList != null) {
      map['favorite_list'] = _favoriteList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// product_name : "Chicken Curry"
/// product_image : "assets/images/bestseller2.png"
/// food_category_type : 2
/// product_description : "Lorem ipsum dolor sit amet, consectetur."

class ItemFavoriteList {
  ItemFavoriteList({
    String? productName,
    String? productImage,
    int? foodCategoryType,
    String? productDescription,
  }) {
    _productName = productName;
    _productImage = productImage;
    _foodCategoryType = foodCategoryType;
    _productDescription = productDescription;
  }

  ItemFavoriteList.fromJson(dynamic json) {
    _productName = json['product_name'];
    _productImage = json['product_image'];
    _foodCategoryType = json['food_category_type'];
    _productDescription = json['product_description'];
  }

  String? _productName;
  String? _productImage;
  int? _foodCategoryType;
  String? _productDescription;

  String get productName => _productName ?? "";

  String get productImage => _productImage ?? "";

  int get foodCategoryType => _foodCategoryType ?? 0;

  String get productDescription => _productDescription ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_name'] = _productName;
    map['product_image'] = _productImage;
    map['food_category_type'] = _foodCategoryType;
    map['product_description'] = _productDescription;
    return map;
  }
}
