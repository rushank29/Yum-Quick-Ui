/// notification_setting_list : [{"notification_setting_id":1,"notification_setting_name":"General Notification","is_setting_enabled":1,"is_setting_changeable":1},{"notification_setting_id":2,"notification_setting_name":"Sound","is_setting_enabled":1,"is_setting_changeable":1},{"notification_setting_id":3,"notification_setting_name":"Sound Call","is_setting_enabled":1,"is_setting_changeable":1},{"notification_setting_id":4,"notification_setting_name":"Vibrate","is_setting_enabled":1,"is_setting_changeable":0},{"notification_setting_id":5,"notification_setting_name":"Special Offers","is_setting_enabled":1,"is_setting_changeable":0},{"notification_setting_id":6,"notification_setting_name":"Payments","is_setting_enabled":1,"is_setting_changeable":0},{"notification_setting_id":7,"notification_setting_name":"Promo and discount","is_setting_enabled":1,"is_setting_changeable":0},{"notification_setting_id":8,"notification_setting_name":"Cashback","is_setting_enabled":1,"is_setting_changeable":0},null]

class NotificationSettingListPojo {
  NotificationSettingListPojo({
      List<ItemNotificationSettingList>? notificationSettingList,}){
    _notificationSettingList = notificationSettingList;
}

  NotificationSettingListPojo.fromJson(dynamic json) {
    if (json['notification_setting_list'] != null) {
      _notificationSettingList = [];
      json['notification_setting_list'].forEach((v) {
        _notificationSettingList?.add(ItemNotificationSettingList.fromJson(v));
      });
    }
  }
  List<ItemNotificationSettingList>? _notificationSettingList;

  List<ItemNotificationSettingList> get notificationSettingList => _notificationSettingList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_notificationSettingList != null) {
      map['notification_setting_list'] = _notificationSettingList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// notification_setting_id : 1
/// notification_setting_name : "General Notification"
/// is_setting_enabled : 1
/// is_setting_changeable : 1

class ItemNotificationSettingList {
  ItemNotificationSettingList({
    int? notificationSettingId,
    String? notificationSettingName,
    int? isSettingEnabled,
    int? isSettingChangeable,}){
    _notificationSettingId = notificationSettingId;
    _notificationSettingName = notificationSettingName;
    _isSettingEnabled = isSettingEnabled;
    _isSettingChangeable = isSettingChangeable;
  }

  ItemNotificationSettingList.fromJson(dynamic json) {
    _notificationSettingId = json['notification_setting_id'];
    _notificationSettingName = json['notification_setting_name'];
    _isSettingEnabled = json['is_setting_enabled'];
    _isSettingChangeable = json['is_setting_changeable'];
  }
  int? _notificationSettingId;
  String? _notificationSettingName;
  int? _isSettingEnabled;
  int? _isSettingChangeable;

  int get notificationSettingId => _notificationSettingId ?? 0;
  String get notificationSettingName => _notificationSettingName ?? "";
  int get isSettingEnabled => _isSettingEnabled ?? 0;
  int get isSettingChangeable => _isSettingChangeable ?? 0;

  set setSettingEnabled(int isEnabled) {
    _isSettingEnabled = isEnabled;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notification_setting_id'] = _notificationSettingId;
    map['notification_setting_name'] = _notificationSettingName;
    map['is_setting_enabled'] = _isSettingEnabled;
    map['is_setting_changeable'] = _isSettingChangeable;
    return map;
  }

}