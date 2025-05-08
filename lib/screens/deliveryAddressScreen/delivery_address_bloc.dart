import 'package:flutter/material.dart';
import 'package:food_ui/shared_pref_util/shared_pref_constants.dart';
import 'package:food_ui/utils/response_util.dart';
import '../../shared_pref_util/shared_pref_util.dart';
import 'addNewAddressScreen/add_new_address_screen.dart';
import 'delivery_address_dl.dart';
import 'delivery_address_json.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/utils.dart';

class DeliveryAddressBloc {
  final BuildContext context;
  final subject = BehaviorSubject<ResponseUtil<DeliveryAddressPojo>>();
  final selectedDeliveryAddressSubject = BehaviorSubject<ItemDeliveryAddressList?>();

  DeliveryAddressBloc(this.context) {
    getDeliveryAddressList();
    loadAddress();
  }

  void getDeliveryAddressList({ItemDeliveryAddressList? newAddress, bool isAddressToBeAdded = false}) async {
    try {
      subject.sink.add(ResponseUtil.loading());
      await Future.delayed(const Duration(seconds: 1));

      var response = DeliveryAddressPojo.fromJson(deliveryAddressJson);
      subject.sink.add(ResponseUtil.completed(response));
      if (newAddress != null && isAddressToBeAdded) {
        subject.valueOrNull?.data?.deliveryAddressList.add(newAddress);
        subject.sink.add(ResponseUtil.completed(subject.valueOrNull?.data));
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
    await Future.delayed(const Duration(seconds: 1));
    final ItemDeliveryAddressList? savedAddress = await getObjectFromPrefs<ItemDeliveryAddressList>(
      prefSavedAddress,
      (json) => ItemDeliveryAddressList.fromJson(json),
    );

    if (savedAddress != null) {
      print("savedAddress ==============> ${savedAddress.addressName}");
      if (!(subject.valueOrNull?.data?.deliveryAddressList ?? []).contains(savedAddress)) {
        subject.valueOrNull?.data?.deliveryAddressList.add(savedAddress);
      }
      selectedDeliveryAddressSubject.sink.add(savedAddress);
    } else {
      print('No address found');
    }
  }

  void dispose() {
    selectedDeliveryAddressSubject.close();
    subject.close();
  }
}
