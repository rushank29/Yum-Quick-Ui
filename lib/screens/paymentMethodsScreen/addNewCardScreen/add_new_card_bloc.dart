import 'package:flutter/material.dart';
import 'package:food_ui/screens/paymentMethodsScreen/payment_methods_dl.dart';
import 'package:rxdart/rxdart.dart';

class AddNewCardBloc {
  final BuildContext context;
  final int paymentTypeListLength;

  AddNewCardBloc(this.context, this.paymentTypeListLength);

  final cardHolderNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final cardNumberSubject = BehaviorSubject<String>();
  final cardHolderNameSubject = BehaviorSubject<String>();
  final expiryDateSubject = BehaviorSubject<String>();
  final cvvSubject = BehaviorSubject<String>();

  void addNewCard() {
    Map<String, dynamic> deliveryAddressMap = mapDeliveryAddressData();
    Navigator.pop(context, deliveryAddressMap);
  }

  Map<String, dynamic> mapDeliveryAddressData() {
    ItemPaymentMethodsList itemDeliveryAddress = ItemPaymentMethodsList(
      paymentType: 1,
      cardNumber: cardNumberController.text.trim(),
      id: paymentTypeListLength + 1,
    );
    return itemDeliveryAddress.toJson();
  }
}
