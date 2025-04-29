import 'package:flutter/material.dart';
import 'package:food_ui/screens/myOrdersScreen/my_orders_dl.dart';
import 'package:food_ui/screens/myOrdersScreen/my_orders_json.dart';
import 'package:rxdart/rxdart.dart';

import '../../constant/constant.dart';
import '../../utils/utils.dart';

class MyOrdersBloc {
  final BuildContext context;

  MyOrdersBloc(this.context) {
    getMyOrders();
  }

  final selectedTabIndex = BehaviorSubject<int>();
  final subjectStatus = BehaviorSubject<Status>();
  final subject = BehaviorSubject<MyOrdersPojo>();

  void getMyOrders() async {
    try {
      subjectStatus.sink.add(Status.loading);
      await Future.delayed(const Duration(seconds: 2));
      var response = MyOrdersPojo.fromJson(myOrdersJson(selectedTabIndex.valueOrNull ?? 0));
      subject.sink.add(response);
      subjectStatus.sink.add(Status.completed);
    } catch (error) {
      subjectStatus.sink.add(Status.error);
      openSimpleSnackBar(error.toString());
    }
  }

  void dispose() {
    selectedTabIndex.close();
    subjectStatus.close();
  }
}
