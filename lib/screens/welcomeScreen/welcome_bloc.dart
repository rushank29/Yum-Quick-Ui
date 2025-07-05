import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../shared_pref_util/shared_pref_constants.dart';
import '../../shared_pref_util/shared_pref_util.dart';
import '../../utils/utils.dart';
import '../onBoardingScreen/on_boarding_screen.dart';
import '../signUpScreen/sign_up_screen.dart';
import '../loginScreen/login_screen.dart';
import 'welcome_json.dart';
import 'welcome_dl.dart';

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
