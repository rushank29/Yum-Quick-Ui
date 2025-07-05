import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import '../../shared_pref_util/shared_pref_util.dart';
import '../../shared_pref_util/shared_pref_constants.dart';
import '../../utils/utils.dart';
import '../homeMainV1/home_main_v1.dart';
import '../welcomeScreen/welcome_screen.dart';
import 'splash_json.dart';
import 'splash_dl.dart';

class SplashBloc {
  BuildContext context;
  final subject = BehaviorSubject<SplashPojo>();

  SplashBloc(this.context) {
    getSplashData();
  }

  void getSplashData() {
    var response = SplashPojo.fromJson(splashJson);
    subject.sink.add(response);
    splashAction();
  }

  void splashAction() {
    final currentUser = FirebaseAuth.instance.currentUser;
    Timer(const Duration(seconds: 3), () {
      if (prefs?.getBool(prefIsUserLoggedIn) == true && currentUser != null) {
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
