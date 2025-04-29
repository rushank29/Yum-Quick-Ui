import 'package:flutter/material.dart';
import 'package:food_ui/screens/cancelOrderScreen/cancellation_reason_list_dl.dart';
import 'package:food_ui/screens/cancelOrderScreen/cancellation_reason_json.dart';
import 'package:food_ui/screens/cancelOrderScreen/cancelled_order_screen.dart';
import 'package:rxdart/rxdart.dart';

import '../../constant/constant.dart';
import '../../utils/utils.dart';

class CancelOrderBloc {
  final BuildContext context;
  final subjectStatus = BehaviorSubject<Status>();
  final subject = BehaviorSubject<CancellationReasonListPojo>();
  final selectedReasonSubject = BehaviorSubject<ItemCancellationReasonList?>();
  final otherReasonController = TextEditingController();

  CancelOrderBloc(this.context) {
    getMyOrders();
  }

  void getMyOrders() async {
    try {
      subjectStatus.sink.add(Status.loading);
      await Future.delayed(const Duration(seconds: 2));
      var response = CancellationReasonListPojo.fromJson(cancellationReasonJson);
      subject.sink.add(response);
      subjectStatus.sink.add(Status.completed);
    } catch (error) {
      subjectStatus.sink.add(Status.error);
      openSimpleSnackBar(error.toString());
    }
  }

  void onSubmitCancelledReason() {
    if ((!selectedReasonSubject.hasValue && otherReasonController.text
        .trim()
        .isEmpty) || (selectedReasonSubject.valueOrNull == null && otherReasonController.text
        .trim()
        .isEmpty)) {
      openSimpleSnackBar("Please select the cancellation reason or enter the one!");
    } else {
      openScreenWithReplacePrevious(context: context, screen: const CancelledOrderScreen());
    }
  }

  void dispose() {
    subjectStatus.close();
    subject.close();
  }
}
