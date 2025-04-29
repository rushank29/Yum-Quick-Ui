import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/main.dart';
import 'package:food_ui/screens/signUpScreen/sign_up_dl.dart';
import 'package:food_ui/screens/splashScreen/splash_screen.dart';
import 'package:food_ui/shared_pref_util/shared_pref_constants.dart';
import 'package:food_ui/utils/text_style.dart';
import 'package:intl/intl.dart';

import '../shared_pref_util/shared_pref_util.dart';

void openScreen({required BuildContext context, required Widget screen}) {
  Navigator.of(context, rootNavigator: true).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return slideTransition(animation: animation, screen: child);
      },
    ),
  );
}

Future<void> openScreenWithResult({required BuildContext context, required Widget screen}) async {
  Navigator.of(context, rootNavigator: true).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return slideTransition(animation: animation, screen: child);
      },
    ),
  );
}

void openScreenWithReplacePrevious({required BuildContext context, required Widget screen}) {
  Navigator.of(context, rootNavigator: true).pushReplacement(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return slideTransition(animation: animation, screen: child);
      },
    ),
  );
}

void openScreenWithClearPrevious({required BuildContext context, required Widget screen}) {
  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return slideTransition(animation: animation, screen: child);
      },
    ),
    (route) => false,
  );
}

SlideTransition slideTransition({required Animation<double> animation, required Widget screen}) {
  var begin = const Offset(1.0, 0.0);
  var end = Offset.zero;
  var curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: animation.drive(tween),
    child: screen,
  );
}

Widget customCarouselIndicator(int currentIndex, int total) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(total, (index) {
      bool isActive = index == currentIndex;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsetsDirectional.symmetric(horizontal: deviceAvgScreenSize * 0.01111),
        height: deviceAvgScreenSize * 0.01073,
        width: isActive ? iconSize20px : iconSize20px,
        decoration: BoxDecoration(
          color: isActive ? colorPrimary : colorPrimaryLight,
          borderRadius: BorderRadius.circular(deviceAvgScreenSize * 0.007155),
        ),
      );
    }),
  );
}

void openSimpleSnackBar(String message) {
  ScaffoldMessenger.of(navigatorKey.currentState!.context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: bodyText(),
    ),
  ));
}

void setUserDataInPref(User currentUser, {SignUpPojo? signUpPojo}) {
  prefs?.setBool(prefIsUserLoggedIn, true);
  prefs?.setString(prefCurrentUserId, currentUser.uid);
  prefs?.setString(prefUserEmail, currentUser.email ?? signUpPojo?.userEmail ?? "dummy@gmail.com");
  prefs?.setString(prefUserName, signUpPojo?.userName ?? currentUser.displayName ?? "");
  prefs?.setString(prefUserMobileNo, signUpPojo?.userMobile ?? "");
  prefs?.setString(prefUserMobileNo, signUpPojo?.userBirthDate ?? "");
  prefs?.setString(prefUserCountryCode, signUpPojo?.userCountryCode ?? "");
}

String getAmountWithCurrency(dynamic amount) {
  return "\$ $amount";
}

void logout(BuildContext context) {
  FirebaseAuth.instance.signOut();
  clearPrefWithSomeRemainingData();
  openScreenWithClearPrevious(context: context, screen: const SplashScreen());
}

String getFormattedDateTime({
  required String inputDateTime,
  String returnFormat = "dd MMM, hh:mm a",
  String format = "dd-MM-yyyy, hh:mm",
}) {
  final inputFormat = DateFormat(format);
  final outputFormat = DateFormat(returnFormat);
  DateTime dateTime = inputFormat.parse(inputDateTime);
  return outputFormat.format(dateTime);
}
