/// drawer_notification_list : [{"notification_icon":"assets/svg/restaurant_cutlery.svg","notification_message":"We have added a product you might like."},{"notification_icon":"assets/svg/delivery_boy_icon.svg","notification_message":"One of your favorite is on promotion."},{"notification_icon":"assets/svg/delivery_boy_icon.svg","notification_message":"The delivery is on his way"},{"notification_icon":"assets/svg/bag.svg","notification_message":"Your order has been delivered"}]

class DrawerNotificationPojo {
  DrawerNotificationPojo({
      List<ItemDrawerNotificationList>? drawerNotificationList,}){
    _drawerNotificationList = drawerNotificationList;
}

  DrawerNotificationPojo.fromJson(dynamic json) {
    if (json['drawer_notification_list'] != null) {
      _drawerNotificationList = [];
      json['drawer_notification_list'].forEach((v) {
        _drawerNotificationList?.add(ItemDrawerNotificationList.fromJson(v));
      });
    }
  }
  List<ItemDrawerNotificationList>? _drawerNotificationList;

  List<ItemDrawerNotificationList> get drawerNotificationList => _drawerNotificationList??[];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_drawerNotificationList != null) {
      map['drawer_notification_list'] = _drawerNotificationList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// notification_icon : "assets/svg/restaurant_cutlery.svg"
/// notification_message : "We have added a product you might like."

class ItemDrawerNotificationList {
  ItemDrawerNotificationList({
    String? notificationIcon,
    String? notificationMessage,}){
    _notificationIcon = notificationIcon;
    _notificationMessage = notificationMessage;
  }

  ItemDrawerNotificationList.fromJson(dynamic json) {
    _notificationIcon = json['notification_icon'];
    _notificationMessage = json['notification_message'];
  }
  String? _notificationIcon;
  String? _notificationMessage;

  String get notificationIcon => _notificationIcon?? "";
  String get notificationMessage => _notificationMessage?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notification_icon'] = _notificationIcon;
    map['notification_message'] = _notificationMessage;
    return map;
  }

}