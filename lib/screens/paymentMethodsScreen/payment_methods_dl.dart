/// payment_methods_list : [{"id":1,"payment_type":1,"card_number":"43858726943"},{"id":2,"payment_type":2,"card_number":""},{"id":3,"payment_type":3,"card_number":""},{"id":4,"payment_type":4,"card_number":""}]

class PaymentMethodsPojo {
  PaymentMethodsPojo({
    List<ItemPaymentMethodsList>? paymentMethodsList,
  }) {
    _paymentMethodsList = paymentMethodsList;
  }

  PaymentMethodsPojo.fromJson(dynamic json) {
    if (json['payment_methods_list'] != null) {
      _paymentMethodsList = [];
      json['payment_methods_list'].forEach((v) {
        _paymentMethodsList?.add(ItemPaymentMethodsList.fromJson(v));
      });
    }
  }

  List<ItemPaymentMethodsList>? _paymentMethodsList;

  List<ItemPaymentMethodsList> get paymentMethodsList => _paymentMethodsList ?? [];

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_paymentMethodsList != null) {
      map['payment_methods_list'] = _paymentMethodsList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// payment_type : 1
/// card_number : "43858726943"

class ItemPaymentMethodsList {
  ItemPaymentMethodsList({
    int? id,
    int? paymentType,
    String? cardNumber,
  }) {
    _id = id;
    _paymentType = paymentType;
    _cardNumber = cardNumber;
  }

  ItemPaymentMethodsList.fromJson(dynamic json) {
    _id = json['id'];
    _paymentType = json['payment_type'];
    _cardNumber = json['card_number'];
  }

  int? _id;
  int? _paymentType;
  String? _cardNumber;
  bool isPaymentMethodSelected = false;

  int get id => _id ?? 0;

  int get paymentType => _paymentType ?? 0;

  String get cardNumber => _cardNumber ?? "";

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['payment_type'] = _paymentType;
    map['card_number'] = _cardNumber;
    return map;
  }

  // Override equality and hashCode for proper comparison
  //
  // This ensures two payment methods are considered the same if their `id` matches,
  // even if they are different instances (useful for list operations, Radio button selection, etc.).
  // Without this, `Radio` groupValue comparison may fail due to object reference mismatch.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemPaymentMethodsList && runtimeType == other.runtimeType && _id == other.id;

  @override
  int get hashCode => id.hashCode;
}
