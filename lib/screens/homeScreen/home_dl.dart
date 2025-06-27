
import '../dishesScreen/dishes_dl.dart';

/// greeting_message_main : "greetingMessage1"
/// greeting_message_sub : "greetingMessage2"
/// food_categories : [{"category_id":1,"category_name":"Snacks","category_icon":"assets/svg/snacks.svg"},{"category_id":2,"category_name":"Meal","category_icon":"assets/svg/meals.svg"},{"category_id":3,"category_name":"Vegan","category_icon":"assets/svg/vegan.svg"},{"category_id":4,"category_name":"Dessert","category_icon":"assets/svg/desserts.svg"},{"category_id":5,"category_name":"Drinks","category_icon":"assets/svg/drinks.svg"}]
/// best_seller_food_items : [{"item_id":1,"item_name":"Sushi","item_image":"assets/images/bestseller1.png","item_price":103},{"item_id":2,"item_name":"Paneer Makhani & Rice","item_image":"assets/images/bestseller2.png","item_price":50},{"item_id":3,"item_name":"Lasagna","item_image":"assets/images/bestseller3.png","item_price":12.99},{"item_id":4,"item_name":"Berry cup-cake","item_image":"assets/images/bestseller4.png","item_price":8.20}]
/// home_page_slider : [{"slider_id":1,"slider_image":"assets/images/home_page_slider.png","slider_msg1":"Experience our delicious new dish","slider_msg2":"30% OFF"},{"slider_id":2,"slider_image":"assets/images/home_page_slider.png","slider_msg1":"Experience our delicious new dish","slider_msg2":"30% OFF"},{"slider_id":3,"slider_image":"assets/images/home_page_slider.png","slider_msg1":"Experience our delicious new dish","slider_msg2":"30% OFF"},{"slider_id":4,"slider_image":"assets/images/home_page_slider.png","slider_msg1":"Experience our delicious new dish","slider_msg2":"30% OFF"},{"slider_id":5,"slider_image":"assets/images/home_page_slider.png","slider_msg1":"Experience our delicious new dish","slider_msg2":"30% OFF"}]
/// recommended_food_items : [{"item_id":1,"item_name":"Cheesy Mexican Burger","item_image":"assets/images/home_burger.png","item_price":13.89,"item_rating":4.75},{"item_id":2,"item_name":"Vietnamese Spring Roll","item_image":"assets/images/home_spring_roll.png","item_price":18.79,"item_rating":4.27},{"item_id":3,"item_name":"Chinese Spring Roll","item_image":"assets/images/home_spring_roll.png","item_price":12.39,"item_rating":3.97},{"item_id":4,"item_name":"Cheesy Aloo Tikki Burger","item_image":"assets/images/home_burger.png","item_price":10,"item_rating":4}]

class HomePojo {
  HomePojo({
      String? greetingMessageMain, 
      String? greetingMessageSub, 
      List<FoodCategories>? foodCategories, 
      List<BestSellerFoodItems>? bestSellerFoodItems, 
      List<HomePageSlider>? homePageSlider, 
      List<RecommendedFoodItems>? recommendedFoodItems,}){
    _greetingMessageMain = greetingMessageMain;
    _greetingMessageSub = greetingMessageSub;
    _foodCategories = foodCategories;
    _bestSellerFoodItems = bestSellerFoodItems;
    _homePageSlider = homePageSlider;
    _recommendedFoodItems = recommendedFoodItems;
}

  HomePojo.fromJson(dynamic json) {
    _greetingMessageMain = json['greeting_message_main'];
    _greetingMessageSub = json['greeting_message_sub'];
    if (json['food_categories'] != null) {
      _foodCategories = [];
      json['food_categories'].forEach((v) {
        _foodCategories?.add(FoodCategories.fromJson(v));
      });
    }
    if (json['best_seller_food_items'] != null) {
      _bestSellerFoodItems = [];
      json['best_seller_food_items'].forEach((v) {
        _bestSellerFoodItems?.add(BestSellerFoodItems.fromJson(v));
      });
    }
    if (json['home_page_slider'] != null) {
      _homePageSlider = [];
      json['home_page_slider'].forEach((v) {
        _homePageSlider?.add(HomePageSlider.fromJson(v));
      });
    }
    if (json['recommended_food_items'] != null) {
      _recommendedFoodItems = [];
      json['recommended_food_items'].forEach((v) {
        _recommendedFoodItems?.add(RecommendedFoodItems.fromJson(v));
      });
    }
  }
  String? _greetingMessageMain;
  String? _greetingMessageSub;
  List<FoodCategories>? _foodCategories;
  List<BestSellerFoodItems>? _bestSellerFoodItems;
  List<HomePageSlider>? _homePageSlider;
  List<RecommendedFoodItems>? _recommendedFoodItems;

  String get greetingMessageMain => _greetingMessageMain ?? "";
  String get greetingMessageSub => _greetingMessageSub ?? "";
  List<FoodCategories> get foodCategories => _foodCategories ?? [];
  List<BestSellerFoodItems> get bestSellerFoodItems => _bestSellerFoodItems ?? [];
  List<HomePageSlider> get homePageSlider => _homePageSlider ?? [];
  List<RecommendedFoodItems> get recommendedFoodItems => _recommendedFoodItems ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['greeting_message_main'] = _greetingMessageMain;
    map['greeting_message_sub'] = _greetingMessageSub;
    if (_foodCategories != null) {
      map['food_categories'] = _foodCategories?.map((v) => v.toJson()).toList();
    }
    if (_bestSellerFoodItems != null) {
      map['best_seller_food_items'] = _bestSellerFoodItems?.map((v) => v.toJson()).toList();
    }
    if (_homePageSlider != null) {
      map['home_page_slider'] = _homePageSlider?.map((v) => v.toJson()).toList();
    }
    if (_recommendedFoodItems != null) {
      map['recommended_food_items'] = _recommendedFoodItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// item_id : 1
/// item_name : "Cheesy Mexican Burger"
/// item_image : "assets/images/home_burger.png"
/// item_price : 13.89
/// item_rating : 4.75

class RecommendedFoodItems {
  RecommendedFoodItems({
    int? itemId,
    String? itemName,
    String? itemImage,
    dynamic itemPrice,
    dynamic itemRating,}){
    _itemId = itemId;
    _itemName = itemName;
    _itemImage = itemImage;
    _itemPrice = itemPrice;
    _itemRating = itemRating;
  }

  RecommendedFoodItems.fromJson(dynamic json) {
    _itemId = json['item_id'];
    _itemName = json['item_name'];
    _itemImage = json['item_image'];
    _itemPrice = json['item_price'];
    _itemRating = json['item_rating'];
  }
  int? _itemId;
  String? _itemName;
  String? _itemImage;
  dynamic _itemPrice;
  dynamic _itemRating;

  int get itemId => _itemId ?? 0;
  String get itemName => _itemName ?? "";
  String get itemImage => _itemImage ?? "";
  dynamic get itemPrice => _itemPrice ?? 0;
  dynamic get itemRating => _itemRating ?? 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_id'] = _itemId;
    map['item_name'] = _itemName;
    map['item_image'] = _itemImage;
    map['item_price'] = _itemPrice;
    map['item_rating'] = _itemRating;
    return map;
  }

}

/// category_id : 5
/// category_name : "Drinks"
/// category_icon : "assets/svg/drinks.svg"
/// top_rated : 4
/// sub_categories : [{"id":1,"name":"Coffee"},{"id":2,"name":"Cocktail"},{"id":3,"name":"Juice"},{"id":4,"name":"Milkshake"},{"id":5,"name":"Wine"},{"id":6,"name":"Piña Colada"},{"id":7,"name":"Mojito"},{"id":8,"name":"Craft Beer"},{"id":9,"name":"Ice Tea"}]
/// selected_price : 100

class FoodCategories {
  FoodCategories({
    int? categoryId,
    String? categoryName,
    String? categoryIcon,
    dynamic topRated,
    List<SubCategories>? subCategories,
    dynamic selectedPrice,
  }) {
    _categoryId = categoryId;
    _categoryName = categoryName;
    _categoryIcon = categoryIcon;
    _topRated = topRated;
    _subCategories = subCategories;
    _selectedPrice = selectedPrice;
  }

  FoodCategories.fromJson(dynamic json) {
    _categoryId = json['category_id'];
    _categoryName = json['category_name'];
    _categoryIcon = json['category_icon'];
    _topRated = json['top_rated'];
    if (json['sub_categories'] != null) {
      _subCategories = [];
      json['sub_categories'].forEach((v) {
        _subCategories?.add(SubCategories.fromJson(v));
      });
    }
    _selectedPrice = json['selected_price'];
  }

  int? _categoryId;
  String? _categoryName;
  String? _categoryIcon;
  dynamic _topRated;
  List<SubCategories>? _subCategories;
  dynamic _selectedPrice;

  int get categoryId => _categoryId ?? 0;

  String get categoryName => _categoryName ?? "";

  String get categoryIcon => _categoryIcon ?? "";

  dynamic get topRated => _topRated ?? 0;

  List<SubCategories> get subCategories => _subCategories ?? [];

  dynamic get selectedPrice => _selectedPrice ?? 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category_id'] = _categoryId;
    map['category_name'] = _categoryName;
    map['category_icon'] = _categoryIcon;
    map['top_rated'] = _topRated;
    if (_subCategories != null) {
      map['sub_categories'] = _subCategories?.map((v) => v.toJson()).toList();
    }
    map['selected_price'] = _selectedPrice;
    return map;
  }
}

/// id : 1
/// name : "Coffee"

class SubCategories {
  SubCategories({
    int? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  SubCategories.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  int? _id;
  String? _name;

  int get id => _id??0;

  String get name => _name??"";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

/// item_id : 1
/// item_name : "Sushi"
/// item_image : "assets/images/bestseller1.png"
/// item_price : 103

class BestSellerFoodItems {
  BestSellerFoodItems({
    int? itemId,
    String? itemName,
    String? itemImage,
    dynamic itemPrice,}){
    _itemId = itemId;
    _itemName = itemName;
    _itemImage = itemImage;
    _itemPrice = itemPrice;
  }

  BestSellerFoodItems.fromJson(dynamic json) {
    _itemId = json['item_id'];
    _itemName = json['item_name'];
    _itemImage = json['item_image'];
    _itemPrice = json['item_price'];
  }
  int? _itemId;
  String? _itemName;
  String? _itemImage;
  dynamic _itemPrice;

  int get itemId => _itemId ?? 0;
  String get itemName => _itemName ?? "";
  String get itemImage => _itemImage ?? "";
  dynamic get itemPrice => _itemPrice ?? 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['item_id'] = _itemId;
    map['item_name'] = _itemName;
    map['item_image'] = _itemImage;
    map['item_price'] = _itemPrice;
    return map;
  }

}

/// slider_id : 1
/// slider_image : "assets/images/home_page_slider.png"
/// slider_msg1 : "Experience our delicious new dish"
/// slider_msg2 : "30% OFF"

class HomePageSlider {
  HomePageSlider({
    int? sliderId,
    String? sliderImage,
    String? sliderMsg1,
    String? sliderMsg2,List<ProductItem>? productItem,}){
    _sliderId = sliderId;
    _sliderImage = sliderImage;
    _sliderMsg1 = sliderMsg1;
    _sliderMsg2 = sliderMsg2;
    _productItem = productItem;
  }

  HomePageSlider.fromJson(dynamic json) {
    _sliderId = json['slider_id'];
    _sliderImage = json['slider_image'];
    _sliderMsg1 = json['slider_msg1'];
    _sliderMsg2 = json['slider_msg2'];
    if (json['product_item'] != null) {
      _productItem = [];
      json['product_item'].forEach((v) {
        _productItem?.add(ProductItem.fromJson(v));
      });
    }
  }
  int? _sliderId;
  String? _sliderImage;
  String? _sliderMsg1;
  String? _sliderMsg2;
  List<ProductItem>? _productItem;

  int get sliderId => _sliderId ?? 0;
  String get sliderImage => _sliderImage ?? "";
  String get sliderMsg1 => _sliderMsg1 ?? "";
  String get sliderMsg2 => _sliderMsg2 ?? "";
  List<ProductItem> get productItem => _productItem ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slider_id'] = _sliderId;
    map['slider_image'] = _sliderImage;
    map['slider_msg1'] = _sliderMsg1;
    map['slider_msg2'] = _sliderMsg2;
    if (_productItem != null) {
      map['product_item'] = _productItem?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}