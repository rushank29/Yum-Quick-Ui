import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/main.dart';
import 'package:food_ui/screens/signUpScreen/sign_up_dl.dart';
import 'package:food_ui/screens/splashScreen/splash_screen.dart';
import 'package:food_ui/shared_pref_util/shared_pref_constants.dart';
import 'package:food_ui/utils/text_style.dart';
import 'package:intl/intl.dart';

import '../customWidget/custom_rounded_button.dart';
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

Future<dynamic> openScreenWithResult({required BuildContext context, required Widget screen}) async {
  return await Navigator.of(context, rootNavigator: true).push(
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

void setUserDataInPref(int loginType, User currentUser, {SignUpPojo? signUpPojo}) {
  prefs?.setBool(prefIsUserLoggedIn, true);
  prefs?.setString(prefCurrentUserId, currentUser.uid);
  prefs?.setString(prefUserEmail, currentUser.email ?? signUpPojo?.userEmail ?? "dummy@gmail.com");
  prefs?.setString(prefUserName, signUpPojo?.userName ?? currentUser.displayName ?? "");
  prefs?.setString(prefUserProfilePic, signUpPojo?.userProfilePic ?? currentUser.photoURL ?? "");
  prefs?.setString(prefUserMobileNo, signUpPojo?.userMobile ?? "");
  prefs?.setString(prefUserMobileNo, signUpPojo?.userBirthDate ?? "");
  prefs?.setString(prefUserCountryCode, signUpPojo?.userCountryCode ?? "");
  prefs?.setInt(prefUserLoginType, loginType);
}

String getAmountWithCurrency(dynamic amount) {
  return "\$ $amount";
}

void logout(BuildContext context) {
  FirebaseAuth.instance.signOut();
  clearPrefWithSomeRemainingData();
  openScreenWithClearPrevious(context: context, screen: const SplashScreen());
}

Future<void> deleteAccount(BuildContext context) async {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref("${FirebaseAuth.instance.currentUser?.uid}");
  await dbRef.remove();
  FirebaseAuth.instance.currentUser?.delete();
  clearPrefWithSomeRemainingData();
  if (!context.mounted) return;
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

void showDateSelector({
  required BuildContext context,
  required TextEditingController controller,
  String format = 'dd-MM-yyyy',
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  Function(String value)? onDateSelected,
}) async {
  DateFormat formatter = DateFormat(format);
  DateTime now = DateTime.now();

  DateTime? selectedDateTime =
      controller.text.isNotEmpty ? formatter.parse(controller.text) : (initialDate ?? DateTime(2000));

  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: selectedDateTime,
    firstDate: firstDate ?? DateTime(1900),
    lastDate: lastDate ?? now,
  );

  if (pickedDate != null) {
    controller.text = formatter.format(pickedDate);
    onDateSelected?.call(formatter.format(pickedDate));
  } else {
    debugPrint("Date is not selected");
  }
}

String getPaymentMethodName(int paymentType, {String cardNumber = ""}) {
  switch (paymentType) {
    case 1:
      return cardNumber.isNotEmpty ? getArrangedCardNumber(cardNumber) : "Credit Card";
    case 2:
      return "Apple Pay";
    case 3:
      return "Paypal";
    case 4:
      return "Google Play";
    default:
      return "Google Play";
  }
}

String getArrangedCardNumber(String cardNumber, {bool mask = true}) {
  if (cardNumber.isEmpty) return cardNumber;

  String processed = cardNumber;

  if (mask && cardNumber.length > 2) {
    int visibleDigits = 2;
    int totalLength = cardNumber.length;
    int hiddenLength = totalLength - visibleDigits;

    // Mask all digits except the last two
    processed = List.filled(hiddenLength, "*").join() + cardNumber.substring(totalLength - visibleDigits);
  }

  // Group into chunks of 3 for both masked and unmasked
  List<String> grouped = [];
  for (int i = 0; i < processed.length; i = i + 3) {
    grouped.add(
      processed.substring(i, i + 3 > processed.length ? processed.length : i + 3),
    );
  }

  return grouped.join(" ");
}

SvgPicture getPaymentMethodIcon(int paymentType) {
  String paymentTypeIcon;
  switch (paymentType) {
    case 1:
      paymentTypeIcon = "assets/svg/card_icon.svg";
    case 2:
      paymentTypeIcon = "assets/svg/apple_pay_icon.svg";
    case 3:
      paymentTypeIcon = "assets/svg/paypal_icon.svg";
    case 4:
      paymentTypeIcon = "assets/svg/google_play_icon.svg";
    default:
      paymentTypeIcon = "assets/svg/google_play_icon.svg";
  }
  return SvgPicture.asset(
    paymentTypeIcon,
    height: iconSize28px,
    width: iconSize40px,
  );
}

Widget commonTabWidget(
  bool isTabSelected,
  String tabTitle, {
  required void Function()? onPressed,
  double? fontSize,
}) {
  return CustomRoundedButton(
    buttonText: tabTitle,
    onPressed: onPressed,
    fontSize: fontSize,
    fontWeight: isTabSelected ? FontWeight.w500 : FontWeight.w400,
    backgroundColor: isTabSelected ? colorPrimary : colorPrimaryLight,
    textColor: isTabSelected ? colorWhite : colorPrimary,
    borderColor: isTabSelected ? colorPrimary : colorPrimaryLight,
    padding: EdgeInsetsDirectional.symmetric(vertical: commonPadding10px * 0.6),
  );
}
