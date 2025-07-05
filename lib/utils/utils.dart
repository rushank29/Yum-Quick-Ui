import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../constant/colors.dart';
import '../constant/dimensions.dart';
import '../main.dart';
import '../screens/signUpScreen/sign_up_dl.dart';
import '../screens/splashScreen/splash_screen.dart';
import '../shared_pref_util/shared_pref_constants.dart';
import '../customWidget/custom_rounded_button.dart';
import '../shared_pref_util/shared_pref_util.dart';
import 'text_style.dart';

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
    minBtnHeight: 0.048,
    minBtnWidth: 0.4,
  );
}

Widget commonHomeHeaderIcon(String image, {bool revertBg = false}) {
  return Container(
    margin: EdgeInsetsDirectional.only(start: deviceAvgScreenSize * 0.012523),
    padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.008945),
    decoration: BoxDecoration(
      color: revertBg ? colorPrimary : colorWhite,
      borderRadius: BorderRadiusDirectional.all(Radius.circular(borderRadius10px)),
    ),
    child: SvgPicture.asset(
      image,
      height: iconSize20px,
      width: iconSize20px,
      colorFilter: ColorFilter.mode(revertBg ? colorWhite : colorPrimary, BlendMode.srcIn),
    ),
  );
}

SvgPicture getFoodCategoryTypeIcon(int foodCategoryType) {
  String icon;
  switch (foodCategoryType) {
    case 1:
      icon = "assets/svg/snacks.svg";
    case 2:
      icon = "assets/svg/meals.svg";
    case 3:
      icon = "assets/svg/vegan.svg";
    case 4:
      icon = "assets/svg/desserts.svg";
    case 5:
      icon = "assets/svg/drinks.svg";
    default:
      icon = "assets/svg/snacks.svg";
  }
  return SvgPicture.asset(
    icon,
    height: iconSize20px,
    width: iconSize20px,
    colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
  );
}

Widget getOrderStatusWidget(int orderStatus) {
  String text;
  String icon;
  switch (orderStatus) {
    case 1:
      text = languages.orderPending;
      icon = "assets/svg/order_delivered_tick.svg";
    case 2:
      text = languages.orderCancelledTxt;
      icon = "assets/svg/order_cancelled_cross.svg";
    case 3:
      text = languages.orderDelivered;
      icon = "assets/svg/order_delivered_tick.svg";
    default:
      text = languages.orderPending;
      icon = "assets/svg/order_delivered_tick.svg";
  }
  return Row(
    children: [
      SvgPicture.asset(
        icon,
        height: iconSize24px * 0.5,
        width: iconSize24px * 0.5,
      ),
      SizedBox(width: deviceAvgScreenSize * 0.008945),
      Text(
        text,
        style: bodyText(
          fontSize: textSize14px,
          fontWeight: FontWeight.w300,
          textColor: colorPrimary,
        ),
      )
    ],
  );
}

Widget chatMsgWidget(List<Widget> msgWidget, String msgTime, bool isSent) {
  return Align(
    alignment: isSent ? AlignmentDirectional.topEnd : AlignmentDirectional.topStart,
    child: Column(
          crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: List.generate(
            msgWidget.length,
            (index) {
              return Container(
                alignment: isSent ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart,
                width: isSent ? deviceWidth * 0.4 : deviceWidth * 0.6,
                padding: EdgeInsetsDirectional.all(commonPadding10px),
                margin: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.008),
                decoration: BoxDecoration(
                  color: isSent ? colorPeach : Colors.transparent,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(borderRadius10px),
                    topEnd: Radius.circular(borderRadius10px),
                    bottomStart: isSent ? Radius.circular(borderRadius10px) : Radius.zero,
                    bottomEnd: isSent ? Radius.zero : Radius.circular(borderRadius10px),
                  ),
                  border: isSent ? null : Border.fromBorderSide(BorderSide(color: colorPrimary)),
                ),
                child: msgWidget[index],
              );
            },
          ),
        ),
        Text(
          getFormattedDateTime(inputDateTime: msgTime, format: "HH:mm", returnFormat: "HH:mm"),
          style: bodyText(
            fontWeight: FontWeight.w300,
            textColor: colorCommonBrown,
          ),
        ),
      ],
    ),
  );
}

setChangedLanguage(BuildContext context, String languageCode, {Function()? nextAction}) {
  changeLanguage(context, languageCode).then((value) {
    selectedLocale = getLocale();
    if (selectedLocale != null) {
      AppLocalizations.delegate.load(selectedLocale!).then((value) {
        languages = value;
        if (nextAction != null) nextAction();
      });
    }
  });
}

Future changeLanguage(BuildContext context, String selectedLanguageCode) async {
  var locale = await setLocale(selectedLanguageCode);

  if (!context.mounted) return;
  MyApp.setLocale(context, locale);
}