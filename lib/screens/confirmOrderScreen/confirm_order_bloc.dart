import 'package:flutter/material.dart';
import '../../customWidget/keyValuePair/item_key_value_pair_dl.dart';
import '../../utils/response_util.dart';
import '../deliveryAddressScreen/delivery_address_screen.dart';
import '../../utils/utils.dart';
import 'package:rxdart/subjects.dart';
import '../deliveryAddressScreen/delivery_address_dl.dart';

import '../../shared_pref_util/shared_pref_constants.dart';
import '../../shared_pref_util/shared_pref_util.dart';
import '../homeMainV1/drawerCart/cart_data_dl.dart';

class ConfirmOrderBloc {
  final BuildContext context;
  final BehaviorSubject<ResponseUtil<CartDataPojo>>? subjectCartData;
  final savedAddressSubject = BehaviorSubject<ItemDeliveryAddressList?>();
  final BehaviorSubject<List<ItemKeyValuePair>>? subjectKeyValueList;

  ConfirmOrderBloc(this.context, this.subjectCartData, this.subjectKeyValueList) {
    getSavedDeliveryAddress();
    setKeyValueData();
  }

  void getSavedDeliveryAddress() async {
    ItemDeliveryAddressList? savedAddress = await getObjectFromPrefs<ItemDeliveryAddressList>(
      prefSavedAddress,
      (json) => ItemDeliveryAddressList.fromJson(json),
    );
    savedAddressSubject.sink.add(savedAddress);
  }

  void changeDeliveryAddress() {
    openScreenWithResult(context: context, screen: const DeliveryAddressScreen()).then(
      (value) {
        getSavedDeliveryAddress();
      },
    );
  }

  void updateCartItemQuantity(ItemCartList updatedItem, bool isIncrement) {
    List<ItemCartList> currentList = subjectCartData?.valueOrNull?.data?.cartList ?? [];
    int index = currentList.indexWhere((item) => item.cartItemId == updatedItem.cartItemId);
    if (index != -1) {
      int newQuantity = currentList[index].itemQuantity;
      if (isIncrement) {
        newQuantity++;
      } else if (newQuantity > 1) {
        newQuantity--;
      }
      currentList[index].setItemQuantity(newQuantity);
      subjectCartData?.sink.add(
        ResponseUtil.completed(
          CartDataPojo(
            subtotal: subjectCartData?.valueOrNull?.data?.subtotal ?? 0,
            deliveryFees: subjectCartData?.valueOrNull?.data?.deliveryFees ?? 0,
            taxAndFees: subjectCartData?.valueOrNull?.data?.taxAndFees ?? 0,
            total: subjectCartData?.valueOrNull?.data?.total ?? 0,
            estimatedDelivery: subjectCartData?.valueOrNull?.data?.estimatedDelivery ?? "",
            cartList: List<ItemCartList>.from(currentList),
          ),
        ),
      );
      setKeyValueData();
    }
  }

  void setKeyValueData() {
    List<ItemKeyValuePair> keyValueList = [];
    dynamic subtotal = subjectCartData?.valueOrNull?.data?.subtotal ?? 0;
    dynamic taxAndFees = subjectCartData?.valueOrNull?.data?.taxAndFees ?? 0;
    dynamic deliveryFees = subjectCartData?.valueOrNull?.data?.deliveryFees ?? 0;
    List<ItemCartList> cartList = subjectCartData?.valueOrNull?.data?.cartList ?? [];
    if (cartList.isNotEmpty) {
      subtotal = 0;
      for (int i = 0; i < cartList.length; i++) {
        subtotal = subtotal + (cartList[i].itemQuantity) * (cartList[i].itemPrice);
      }
    }
    dynamic total = subtotal + taxAndFees + deliveryFees;
    keyValueList.add(ItemKeyValuePair(title: "Subtotal", value: getAmountWithCurrency(subtotal)));
    keyValueList.add(
      ItemKeyValuePair(title: "Tax and Fees", value: getAmountWithCurrency(taxAndFees)),
    );
    keyValueList.add(
      ItemKeyValuePair(title: "Delivery", value: getAmountWithCurrency(deliveryFees)),
    );
    keyValueList.add(ItemKeyValuePair(title: "Total", value: "$total", showDivider: true));
    subjectKeyValueList?.sink.add(keyValueList);
  }
}
