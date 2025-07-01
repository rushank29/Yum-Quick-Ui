import 'package:flutter/material.dart';
import 'package:food_ui/main.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared_pref_util/shared_pref_constants.dart';
import '../../utils/response_util.dart';
import '../../shared_pref_util/shared_pref_util.dart';
import '../../utils/utils.dart';
import 'addNewAddressScreen/add_new_address_screen.dart';
import 'delivery_address_dl.dart';
import 'delivery_address_json.dart';

class DeliveryAddressBloc {
  final BuildContext context;
  final subject = BehaviorSubject<ResponseUtil<DeliveryAddressPojo>>();
  final selectedDeliveryAddressSubject = BehaviorSubject<ItemDeliveryAddressList?>();

  DeliveryAddressBloc(this.context) {
    getDeliveryAddressList().then((_) => loadAddress());
  }

  Future<void> getDeliveryAddressList({ItemDeliveryAddressList? newAddress, bool isAddressToBeAdded = false}) async {
    try {
      subject.sink.add(ResponseUtil.loading());
      await Future.delayed(const Duration(seconds: 1));

      var response = DeliveryAddressPojo.fromJson(deliveryAddressJson);
      subject.sink.add(ResponseUtil.completed(response));

      if (newAddress != null && isAddressToBeAdded) {
        final list = subject.valueOrNull?.data?.deliveryAddressList;
        final exists = list?.any((addr) => addr.addressId == newAddress.addressId) ?? false;

        if (!exists) {
          list?.add(newAddress);
          subject.sink.add(ResponseUtil.completed(subject.valueOrNull?.data));
        }

        // Save and set the new address as selected
        await setJsonString(prefSavedAddress, newAddress);
        selectedDeliveryAddressSubject.sink.add(newAddress);
      }
    } catch (error) {
      subject.sink.add(ResponseUtil.error(error.toString()));
      openSimpleSnackBar(error.toString());
    }
  }

  void openAddAddressScreen() {
    openScreenWithResult(
      context: context,
      screen: AddNewAddressScreen(
        deliveryAddressListLength: subject.valueOrNull?.data?.deliveryAddressList.length ?? 0,
      ),
    ).then(
      (value) async {
        if (value != null) {
          ItemDeliveryAddressList newAddress = ItemDeliveryAddressList.fromJson(value);
          getDeliveryAddressList(newAddress: newAddress, isAddressToBeAdded: true);
          await loadAddress();
        }
      },
    );
  }

  Future<void> loadAddress() async {
    final savedAddress = await getObjectFromPrefs<ItemDeliveryAddressList>(
      prefSavedAddress,
          (json) => ItemDeliveryAddressList.fromJson(json),
    );

    final deliveryList = subject.valueOrNull?.data?.deliveryAddressList;

    if (savedAddress != null && deliveryList != null) {
      final existingIndex = deliveryList.indexWhere(
            (item) => item.addressId == savedAddress.addressId,
      );

      if (existingIndex == -1) {
        deliveryList.add(savedAddress);
        subject.sink.add(ResponseUtil.completed(subject.valueOrNull?.data));
      }

      selectedDeliveryAddressSubject.sink.add(savedAddress);
    } else {
      print(languages.noAddressFoundInPref);
      openSimpleSnackBar(languages.noAddressFoundInPref);
    }
  }

  void dispose() {
    selectedDeliveryAddressSubject.close();
    subject.close();
  }
}
