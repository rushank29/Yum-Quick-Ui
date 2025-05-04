import 'package:flutter/material.dart';
import 'package:food_ui/screens/myOrdersScreen/my_orders_dl.dart';
import 'package:food_ui/screens/myOrdersScreen/my_orders_json.dart';
import 'package:food_ui/utils/response_util.dart';
import 'package:rxdart/rxdart.dart';

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
