import 'package:flutter/material.dart';
import 'package:food_ui/screens/deliveryAddressScreen/delivery_address_dl.dart';

class AddNewAddressBloc {
  final BuildContext context;
  final int deliveryAddressListLength;

  AddNewAddressBloc(this.context, this.deliveryAddressListLength);

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void addNewAddress() {
    Map<String, dynamic> deliveryAddressMap = mapDeliveryAddressData();
    Navigator.pop(context, deliveryAddressMap);
  }

  Map<String, dynamic> mapDeliveryAddressData() {
    ItemDeliveryAddressList itemDeliveryAddress = ItemDeliveryAddressList(
      addressId: deliveryAddressListLength + 1,
      addressName: nameController.text.trim(),
      addressDescription: descriptionController.text.trim(),
      addressType: 1,
    );
    return itemDeliveryAddress.toJson();
  }
}
