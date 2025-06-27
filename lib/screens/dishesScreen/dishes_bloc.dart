import 'package:flutter/material.dart';
import 'package:food_ui/screens/dishesScreen/dishes_json.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/response_util.dart';
import '../../utils/utils.dart';
import 'dishes_dl.dart';

class DishesBloc {
  final BuildContext context;

  DishesBloc(this.context) {
    getDishesData();
  }

  final subject = BehaviorSubject<ResponseUtil<DishesPojo>>();
  final selectedIndexSubject = BehaviorSubject<int>();
  final currentIndexSubject = BehaviorSubject<int>();

  void getDishesData() async {
    try {
      subject.sink.add(ResponseUtil.loading());
      await Future.delayed(const Duration(seconds: 2));
      var response = DishesPojo.fromJson(dishesJson);
      subject.sink.add(ResponseUtil.completed(response));
    } catch (error) {
      subject.sink.add(ResponseUtil.error(error.toString()));
      openSimpleSnackBar(error.toString());
    }
  }

  void dispose() {
    subject.close();
    selectedIndexSubject.close();
  }
}
