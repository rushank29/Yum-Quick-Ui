import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ui/screens/homeMainV1/home_main_v1.dart';
import 'package:food_ui/screens/splashScreen/splash_json.dart';
import 'package:food_ui/shared_pref_util/shared_pref_constants.dart';
import 'package:food_ui/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared_pref_util/shared_pref_util.dart';
import '../welcomeScreen/welcome_screen.dart';
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
