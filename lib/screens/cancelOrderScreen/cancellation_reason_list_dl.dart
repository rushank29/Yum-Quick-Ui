/// cancellation_reason_list : [{"reason_id":1,"reason_message":"Lorem ipsum dolor sit amet","is_reason_selected":0},{"reason_id":2,"reason_message":"Lorem ipsum dolor sit amet","is_reason_selected":0},{"reason_id":3,"reason_message":"Lorem ipsum dolor sit amet","is_reason_selected":0},{"reason_id":4,"reason_message":"Lorem ipsum dolor sit amet","is_reason_selected":0},{"reason_id":5,"reason_message":"Lorem ipsum dolor sit amet","is_reason_selected":0}]

class CancellationReasonListPojo {
  CancellationReasonListPojo({
    List<ItemCancellationReasonList>? cancellationReasonList,
  }) {
    _cancellationReasonList = cancellationReasonList;
  }

  CancellationReasonListPojo.fromJson(dynamic json) {
    if (json['cancellation_reason_list'] != null) {
      _cancellationReasonList = [];
      json['cancellation_reason_list'].forEach((v) {
        _cancellationReasonList?.add(ItemCancellationReasonList.fromJson(v));
      });
    }
  }

  List<ItemCancellationReasonList>? _cancellationReasonList;

  List<ItemCancellationReasonList> get cancellationReasonList => _cancellationReasonList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_cancellationReasonList != null) {
      map['cancellation_reason_list'] = _cancellationReasonList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// reason_id : 1
/// reason_message : "Lorem ipsum dolor sit amet"
/// is_reason_selected : 0

class ItemCancellationReasonList {
  ItemCancellationReasonList({
    int? reasonId,
    String? reasonMessage,
    int? showTextField,
    bool isReasonSelected = false,
  }) {
    _reasonId = reasonId;
    _reasonMessage = reasonMessage;
  }

  ItemCancellationReasonList.fromJson(dynamic json) {
    _reasonId = json['reason_id'];
    _reasonMessage = json['reason_message'];
    _showTextField = json['show_text_field'];
  }

  int? _reasonId;
  String? _reasonMessage;
  int? _showTextField;

  int get reasonId => _reasonId ?? 0;

  String get reasonMessage => _reasonMessage ?? "";

  int get showTextField => _showTextField ?? 0;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reason_id'] = _reasonId;
    map['reason_message'] = _reasonMessage;
    map['show_text_field'] = _showTextField;
    return map;
  }
}
