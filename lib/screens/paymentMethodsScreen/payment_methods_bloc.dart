import 'package:flutter/material.dart';
import 'package:food_ui/screens/paymentMethodsScreen/payment_methods_dl.dart';
import 'package:food_ui/screens/paymentMethodsScreen/payment_methods_json.dart';
import 'package:food_ui/utils/response_util.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/utils.dart';
import 'addNewCardScreen/add_new_card_screen.dart';

class PaymentMethodsBloc {
  final BuildContext context;
  final subject = BehaviorSubject<ResponseUtil<PaymentMethodsPojo>>();
  final selectedPaymentMethodSubject = BehaviorSubject<ItemPaymentMethodsList?>();

  PaymentMethodsBloc(this.context) {
    getPaymentMethods();
  }

  void getPaymentMethods({ItemPaymentMethodsList? newPaymentMethod, bool isMethodToBeAdded = false}) async {
    try {
      subject.sink.add(ResponseUtil.loading());
      await Future.delayed(const Duration(seconds: 1));

      var response = PaymentMethodsPojo.fromJson(paymentMethodsJson);
      subject.sink.add(ResponseUtil.completed(response));
      if (newPaymentMethod != null && isMethodToBeAdded) {
        if(!subject.value.data!.paymentMethodsList.contains(newPaymentMethod)) {
          subject.valueOrNull?.data?.paymentMethodsList.add(newPaymentMethod);
        }
        subject.sink.add(ResponseUtil.completed(subject.valueOrNull?.data));
      }
    } catch (error) {
      subject.sink.add(ResponseUtil.error(error.toString()));
      openSimpleSnackBar(error.toString());
    }
  }

  // void getPaymentMethods() async {
  //   try {
  //     subject.sink.add(ResponseUtil.loading());
  //     await Future.delayed(const Duration(seconds: 1));
  //     var response = PaymentMethodsPojo.fromJson(paymentMethodsJson);
  //     subject.sink.add(ResponseUtil.completed(response));
  //   } catch (error) {
  //     subject.sink.add(ResponseUtil.error(error.toString()));
  //     openSimpleSnackBar(error.toString());
  //   }
  // }

  void addNewCardScreen() {
    openScreenWithResult(
      context: context,
      screen: AddNewCardScreen(
        paymentTypeListLength: subject.valueOrNull?.data?.paymentMethodsList.length ?? 0,
      ),
    ).then((value) async {
      if (value != null) {
        ItemPaymentMethodsList newPaymentMethod = ItemPaymentMethodsList.fromJson(value);
        getPaymentMethods(newPaymentMethod: newPaymentMethod, isMethodToBeAdded: true);
      }
    },);
  }

  void dispose() {
    subject.close();
    selectedPaymentMethodSubject.close();
  }
}
