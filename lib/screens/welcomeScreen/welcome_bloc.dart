import 'package:flutter/material.dart';
import 'package:food_ui/utils/response_util.dart';
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
  final subject = BehaviorSubject<ResponseUtil<WelcomePojo>>();

  WelcomeBloc(this.context) {
    getWelcomeData();
  }

  void getWelcomeData() {
    subject.sink.add(ResponseUtil.loading());
    try {
      var response = WelcomePojo.fromJson(welcomeJson);
      subject.sink.add(ResponseUtil.completed(response));
    } catch (error) {
      subject.sink.add(ResponseUtil.error(error.toString()));
    }
  }

  void onButtonClickedEvent(bool isLoginClicked) {
    if (!getBool(prefIsOnBoardingVisited)) {
      openScreen(
        context: context,
        screen: OnBoardingScreen(
          isRedirectedToLogin: isLoginClicked,
        ),
      );
    } else if (isLoginClicked) {
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
