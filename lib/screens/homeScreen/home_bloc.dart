import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_ui/constant/constant.dart';
import 'package:food_ui/screens/homeScreen/home_dl.dart';
import 'package:food_ui/utils/utils.dart';
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
      subjectStatus.sink.add(Status.loading);
      await Future.delayed(const Duration(seconds: 2));
      var response = HomePojo.fromJson(homeJson);
      subject.sink.add(response);
      subjectStatus.sink.add(Status.completed);
    } catch (error) {
      subjectStatus.sink.add(Status.error);
      openSimpleSnackBar(error.toString());
    }
  }

  final selectedIndexSubject = BehaviorSubject<int>();
  final subjectStatus = BehaviorSubject<Status>();
  final subject = BehaviorSubject<HomePojo>();

  void dispose() {
    selectedIndexSubject.close();
    subjectStatus.close();
    subject.close();
  }
}
