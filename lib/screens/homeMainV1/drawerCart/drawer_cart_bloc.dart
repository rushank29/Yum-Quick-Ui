import 'package:flutter/material.dart';
import '../../../customWidget/keyValuePair/item_key_value_pair_dl.dart';
import 'cart_data_dl.dart';
import 'drawer_cart_json.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/response_util.dart';
import '../../../utils/utils.dart';

class DrawerCartBloc {
  final BuildContext context;

  DrawerCartBloc(this.context) {
    getCartData();
  }

  final subjectCartData = BehaviorSubject<ResponseUtil<CartDataPojo>>();
  final subjectKeyValueList = BehaviorSubject<List<ItemKeyValuePair>>();

  void getCartData() async {
    try {
      subjectCartData.sink.add(ResponseUtil.loading());
      var response = CartDataPojo.fromJson(drawerCartJson);
      subjectCartData.sink.add(ResponseUtil.completed(response));
      setKeyValueData();
    } catch (error) {
      subjectCartData.sink.add(ResponseUtil.error(error.toString()));
      openSimpleSnackBar(error.toString());
    }
  }

  void updateCartItemQuantity(ItemCartList updatedItem, bool isIncrement) {
    List<ItemCartList> currentList = subjectCartData.valueOrNull?.data?.cartList ?? [];
    int index = currentList.indexWhere((item) => item.cartItemId == updatedItem.cartItemId);
    if (index != -1) {
      int newQuantity = currentList[index].itemQuantity;
      if (isIncrement) {
        newQuantity++;
      } else if (newQuantity > 1) {
        newQuantity--;
      }
      currentList[index].setItemQuantity(newQuantity);
      subjectCartData.sink.add(
        ResponseUtil.completed(
          CartDataPojo(
            subtotal: subjectCartData.valueOrNull?.data?.subtotal ?? 0,
            deliveryFees: subjectCartData.valueOrNull?.data?.deliveryFees ?? 0,
            taxAndFees: subjectCartData.valueOrNull?.data?.taxAndFees ?? 0,
            total: subjectCartData.valueOrNull?.data?.total ?? 0,
            estimatedDelivery: subjectCartData.valueOrNull?.data?.estimatedDelivery ?? "",
            cartList: List<ItemCartList>.from(currentList),
          ),
        ),
      );
      setKeyValueData();
    }
  }

  void setKeyValueData() {
    List<ItemKeyValuePair> keyValueList = [];
    dynamic subtotal = subjectCartData.valueOrNull?.data?.subtotal ?? 0;
    dynamic taxAndFees = subjectCartData.valueOrNull?.data?.taxAndFees ?? 0;
    dynamic deliveryFees = subjectCartData.valueOrNull?.data?.deliveryFees ?? 0;
    List<ItemCartList> cartList = subjectCartData.valueOrNull?.data?.cartList ?? [];
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
    subjectKeyValueList.sink.add(keyValueList);
  }

  void dispose() {
    subjectCartData.close();
    subjectKeyValueList.close();
  }
}
