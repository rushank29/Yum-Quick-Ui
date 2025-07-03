import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'my_orders_dl.dart';
import 'my_orders_json.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';

class MyOrdersBloc {
  final BuildContext context;

  MyOrdersBloc(this.context) {
    getMyOrders();
  }

  final selectedTabIndex = BehaviorSubject<int>();
  final subject = BehaviorSubject<ResponseUtil<MyOrdersPojo>>();

  void getMyOrders() async {
    try {
      subject.sink.add(ResponseUtil.loading());
      await Future.delayed(const Duration(seconds: 3));
      var response = MyOrdersPojo.fromJson(myOrdersJson(selectedTabIndex.valueOrNull ?? 0));
      subject.sink.add(ResponseUtil.completed(response));
    } catch (error) {
      subject.sink.add(ResponseUtil.error(error.toString()));
      openSimpleSnackBar(error.toString());
    }
  }

  void dispose() {
    selectedTabIndex.close();
    subject.close();
  }
}
