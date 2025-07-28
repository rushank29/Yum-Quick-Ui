import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import '../../shared_pref_util/shared_pref_util.dart';
import '../../shared_pref_util/shared_pref_constants.dart';
import '../../utils/utils.dart';
import '../homeMainV1/home_main_v1.dart';
import '../../utils/response_util.dart';
import '../welcomeScreen/welcome_screen.dart';
import 'splash_json.dart';
import 'splash_dl.dart';

class SplashBloc {
  BuildContext context;
  final subject = BehaviorSubject<ResponseUtil<SplashPojo>>();

  SplashBloc(this.context) {
    getSplashData();
  }

  void getSplashData() {
    subject.sink.add(ResponseUtil.loading());
    try {
      var response = SplashPojo.fromJson(splashJson);
      subject.sink.add(ResponseUtil.completed(response));
      splashAction();
    } catch (error) {
      subject.sink.add(ResponseUtil.error(error.toString()));
    }
  }

  void splashAction() {
    final currentUser = FirebaseAuth.instance.currentUser;
    Timer(const Duration(seconds: 3), () {
      if (getBool(prefIsUserLoggedIn) == true && currentUser != null) {
        openScreenWithReplacePrevious(context: context, screen: const HomeMainV1());
      } else {
        openScreenWithReplacePrevious(
          context: context,
          screen: const WelcomeScreen(),
        );
      }
    });
  }

  void dispose() {
    subject.close();
  }
}
