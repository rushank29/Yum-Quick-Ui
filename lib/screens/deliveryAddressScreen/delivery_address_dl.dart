/// delivery_address_list : [{"address_id":1,"address_type":1,"address_name":"My home","address_description":"778 Locust View Drive Oakland, CA"},{"address_id":2,"address_type":1,"address_name":"My Office","address_description":"778 Locust View Drive Oakland, CA"},{"address_id":3,"address_type":1,"address_name":"Parent's House","address_description":"778 Locust View Drive Oakland, CA"}]

class DeliveryAddressPojo {
  DeliveryAddressPojo({
    List<ItemDeliveryAddressList>? deliveryAddressList,
  }) {
    _deliveryAddressList = deliveryAddressList;
  }

  DeliveryAddressPojo.fromJson(dynamic json) {
    if (json['delivery_address_list'] != null) {
      _deliveryAddressList = [];
      json['delivery_address_list'].forEach((v) {
        _deliveryAddressList?.add(ItemDeliveryAddressList.fromJson(v));
      });
    }
  }

  List<ItemDeliveryAddressList>? _deliveryAddressList;

  List<ItemDeliveryAddressList> get deliveryAddressList => _deliveryAddressList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_deliveryAddressList != null) {
      map['delivery_address_list'] = _deliveryAddressList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// address_id : 1
/// address_type : 1
/// address_name : "My home"
/// address_description : "778 Locust View Drive Oakland, CA"

class ItemDeliveryAddressList {
  ItemDeliveryAddressList({
    int? addressId,
    int? addressType,
    String? addressName,
    String? addressDescription,
  }) {
    _addressId = addressId;
    _addressType = addressType;
    _addressName = addressName;
    _addressDescription = addressDescription;
  }

  ItemDeliveryAddressList.fromJson(dynamic json) {
    _addressId = json['address_id'];
    _addressType = json['address_type'];
    _addressName = json['address_name'];
    _addressDescription = json['address_description'];
  }

  int? _addressId;
  int? _addressType;
  String? _addressName;
  String? _addressDescription;

  int get addressId => _addressId ?? 0;

  int get addressType => _addressType ?? 0;

  String get addressName => _addressName ?? '';

  String get addressDescription => _addressDescription ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_id'] = _addressId;
    map['address_type'] = _addressType;
    map['address_name'] = _addressName;
    map['address_description'] = _addressDescription;
    return map;
  }

  // Override equality and hashCode for proper comparison
  //
  // This ensures two delivery addresses are considered the same if their `id` matches,
  // even if they are different instances (useful for list operations, Radio button selection, etc.).
  // Without this, `Radio` groupValue comparison may fail due to object reference mismatch.
  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ItemDeliveryAddressList && other.addressId == addressId;

  @override
  int get hashCode => addressId.hashCode;
}
