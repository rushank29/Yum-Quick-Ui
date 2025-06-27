/// best_seller_list : [{"product_name":"Sunny Bruschetta","product_image":"assets/images/sunny_bruschetta.png","is_favorite":1,"product_rating":5.0,"product_price":15.00,"food_category_type":1,"product_description":"Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."},{"product_name":"Gourmet Grilled Skewers","product_image":"assets/images/pork_skewer.png","is_favorite":0,"product_rating":4.5,"product_price":13.45,"food_category_type":1,"product_description":"Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."},{"product_name":"Barbecue tacos","product_image":"assets/images/barbeque_taco.png","is_favorite":1,"product_rating":3.5,"product_price":13.45,"food_category_type":2,"product_description":"Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."},{"product_name":"Broccoli lasagna","product_image":"assets/images/bestseller3.png","is_favorite":1,"product_rating":4.0,"product_price":19.68,"food_category_type":3,"product_description":"Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."},{"product_name":"Iced Latte","product_image":"assets/images/creamy_coffee.png","is_favorite":1,"product_rating":4.5,"product_price":12.19,"food_category_type":4,"product_description":"Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."},{"product_name":"Strawberry Cheesecake","product_image":"assets/images/strawberry_cheesecake.png","is_favorite":0,"product_rating":5.0,"product_price":18.29,"food_category_type":5,"product_description":"Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."}]

class BestSellerPojo {
  BestSellerPojo({
      List<ItemBestSellerList>? bestSellerList,}){
    _bestSellerList = bestSellerList;
}

  BestSellerPojo.fromJson(dynamic json) {
    if (json['best_seller_list'] != null) {
      _bestSellerList = [];
      json['best_seller_list'].forEach((v) {
        _bestSellerList?.add(ItemBestSellerList.fromJson(v));
      });
    }
  }
  List<ItemBestSellerList>? _bestSellerList;

  List<ItemBestSellerList>? get bestSellerList => _bestSellerList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bestSellerList != null) {
      map['best_seller_list'] = _bestSellerList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// product_name : "Sunny Bruschetta"
/// product_image : "assets/images/sunny_bruschetta.png"
/// is_favorite : 1
/// product_rating : 5.0
/// product_price : 15.00
/// food_category_type : 1
/// product_description : "Lorem ipsum dolor sit amet, conse ctetur  adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."

class ItemBestSellerList {
  ItemBestSellerList({
    String? productName,
    String? productImage,
    int? isFavorite,
    num? productRating,
    num? productPrice,
    int? foodCategoryType,
    String? productDescription,}){
    _productName = productName;
    _productImage = productImage;
    _isFavorite = isFavorite;
    _productRating = productRating;
    _productPrice = productPrice;
    _foodCategoryType = foodCategoryType;
    _productDescription = productDescription;
  }

  ItemBestSellerList.fromJson(dynamic json) {
    _productName = json['product_name'];
    _productImage = json['product_image'];
    _isFavorite = json['is_favorite'];
    _productRating = json['product_rating'];
    _productPrice = json['product_price'];
    _foodCategoryType = json['food_category_type'];
    _productDescription = json['product_description'];
  }
  String? _productName;
  String? _productImage;
  int? _isFavorite;
  num? _productRating;
  num? _productPrice;
  int? _foodCategoryType;
  String? _productDescription;

  String get productName => _productName ?? "";

  String get productImage => _productImage ?? "";

  int get isFavorite => _isFavorite ?? 0;

  num get productRating => _productRating ?? 0.0;

  num get productPrice => _productPrice ?? 0.0;

  int get foodCategoryType => _foodCategoryType ?? 0;

  String get productDescription => _productDescription ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_name'] = _productName;
    map['product_image'] = _productImage;
    map['is_favorite'] = _isFavorite;
    map['product_rating'] = _productRating;
    map['product_price'] = _productPrice;
    map['food_category_type'] = _foodCategoryType;
    map['product_description'] = _productDescription;
    return map;
  }

}