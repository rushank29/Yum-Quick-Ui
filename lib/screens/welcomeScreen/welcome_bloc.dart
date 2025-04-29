import 'package:flutter/material.dart';
import 'package:food_ui/screens/onBoardingScreen/on_boarding_screen.dart';
import 'package:food_ui/screens/welcomeScreen/welcome_dl.dart';
import 'package:food_ui/screens/welcomeScreen/welcome_json.dart';
import 'package:food_ui/shared_pref_util/shared_pref_constants.dart';
import 'package:food_ui/shared_pref_util/shared_pref_util.dart';
import 'package:food_ui/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../loginScreen/login_screen.dart';
import '../signUpScreen/sign_up_screen.dart';

class WelcomeBloc {
  BuildContext context;
  final subject = BehaviorSubject<WelcomePojo>();

  WelcomeBloc(this.context) {
    getWelcomeData();
  }

  void getWelcomeData() {
    var response = WelcomePojo.fromJson(welcomeJson);
    subject.sink.add(response);
  }

  void onButtonClickedEvent(bool isLoginClicked) {
    if (!getBool(prefIsOnBoardingVisited)) {
      openScreen(
        context: context,
        screen: OnBoardingScreen(
          isRedirectedToLogin: isLoginClicked,
        ),
      );
    } else if(isLoginClicked) {
      openScreen(
        context: context,
        screen: const LoginScreen(),
      );
    } else {
      openScreen(
        context: context,
        screen: const SignUpScreen(),
      );
    }
  }

  void dispose() {
    subject.close();
  }
}
