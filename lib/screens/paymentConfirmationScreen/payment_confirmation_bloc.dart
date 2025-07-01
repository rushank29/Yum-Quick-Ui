import 'package:flutter/material.dart';
import 'package:food_ui/screens/paymentMethodsScreen/payment_methods_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/utils.dart';
import '../paymentMethodsScreen/payment_methods_dl.dart';
import '../../shared_pref_util/shared_pref_constants.dart';
import '../../shared_pref_util/shared_pref_util.dart';

class PaymentConfirmationBloc {
  final BuildContext context;

  PaymentConfirmationBloc(this.context) {
    getSavedPaymentMethod();
  }

  void changePaymentMethod() {
    openScreenWithResult(context: context, screen: const PaymentMethodsScreen()).then(
          (value) {
        getSavedPaymentMethod();
      },
    );
  }

  final savedPaymentMethodSubject = BehaviorSubject<ItemPaymentMethodsList?>();

  void getSavedPaymentMethod() async {
    ItemPaymentMethodsList? savedPaymentMethod = await getObjectFromPrefs<ItemPaymentMethodsList>(
      prefSavedPaymentType,
      (json) => ItemPaymentMethodsList.fromJson(json),
    );
    savedPaymentMethodSubject.sink.add(savedPaymentMethod);
  }

  void dispose() {
    savedPaymentMethodSubject.close();
  }
}
