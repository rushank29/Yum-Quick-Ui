import 'package:flutter/material.dart';
import 'package:food_ui/customWidget/networkConnectivityChecker/internet_service.dart';

import 'cancellation_reason_list_dl.dart';
import 'cancellation_reason_json.dart';
import 'cancelled_confirmed_order_screen.dart';
import '../../utils/response_util.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/utils.dart';
import '../../main.dart';

class CancelOrderBloc {
  final BuildContext context;
  final subject = BehaviorSubject<ResponseUtil<CancellationReasonListPojo>>();
  final selectedReasonSubject = BehaviorSubject<ItemCancellationReasonList?>();
  final otherReasonController = TextEditingController();

  CancelOrderBloc(this.context) {
    getOrderCancellationList();
  }

  void getOrderCancellationList() async {
    InternetService().runWhenOnline(() async {
      try {
        subject.sink.add(ResponseUtil.loading());
        await Future.delayed(const Duration(seconds: 1));
        var response = CancellationReasonListPojo.fromJson(cancellationReasonJson);
        subject.sink.add(ResponseUtil.completed(response));
      } catch (error) {
        subject.sink.add(ResponseUtil.error(error.toString()));
        openSimpleSnackBar(error.toString());
      }
    });
  }

  void onSubmitCancelledReason() {
    if ((!selectedReasonSubject.hasValue && otherReasonController.text.trim().isEmpty) ||
        (selectedReasonSubject.valueOrNull == null && otherReasonController.text.trim().isEmpty)) {
      openSimpleSnackBar(languages.selectOrEnterCancellationReason);
    } else {
      openScreenWithReplacePrevious(
        context: context,
        screen: const CancelledOrConfirmedOrderScreen(),
      );
    }
  }

  void dispose() {
    subject.close();
    selectedReasonSubject.close();
    otherReasonController.dispose();
  }
}
