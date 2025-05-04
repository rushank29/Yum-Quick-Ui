import 'dart:async';

import 'package:flutter/material.dart';
import 'home_dl.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';
import 'home_json.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc {
  final BuildContext context;

  HomeBloc(this.context) {
    setGettingMessage();
    getHomeData();
  }

  void getHomeData() async {
    try {
      subject.sink.add(ResponseUtil.loading());
      await Future.delayed(const Duration(seconds: 2));
      var response = HomePojo.fromJson(homeJson);
      subject.sink.add(ResponseUtil.completed(response));
    } catch (error) {
      subject.sink.add(ResponseUtil.error(error.toString()));
      openSimpleSnackBar(error.toString());
    }
  }

  final selectedIndexSubject = BehaviorSubject<int>();
  final subject = BehaviorSubject<ResponseUtil<HomePojo>>();

  void dispose() {
    selectedIndexSubject.close();
    subject.close();
  }
}
