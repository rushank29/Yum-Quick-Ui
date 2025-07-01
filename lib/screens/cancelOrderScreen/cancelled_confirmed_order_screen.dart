import 'package:flutter/material.dart';
import 'package:food_ui/main.dart';
import 'package:intl/intl.dart';

import '../../constant/dimensions.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../utils/text_style.dart';
import '../../constant/colors.dart';
import '../../customWidget/rotating_circle_animation.dart';
import '../../utils/utils.dart';
import '../homeMainV1/home_main_v1.dart';

class CancelledOrConfirmedOrderScreen extends StatelessWidget {
  final bool isForPaymentConfirmation;
  final String eta;

  const CancelledOrConfirmedOrderScreen({super.key, this.isForPaymentConfirmation = false, this.eta = ""});

  @override
  Widget build(BuildContext context) {
    String weekday = "";
    String day = "";
    String daySuffix = "";
    String time = "";
    String getDaySuffix(int day) {
      if (day >= 11 && day <= 13) return 'th';
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    if (eta.isNotEmpty) {
      List<String> etaList = eta.split(" ");
      String finalEta = etaList.first.replaceAll("[]", "");
      DateTime futureTime = DateTime.now().add(Duration(minutes: int.parse(finalEta)));
      weekday = DateFormat('E').format(futureTime); // Thu
      day = DateFormat('d').format(futureTime); // 29
      daySuffix = getDaySuffix(futureTime.day); // th
      time = DateFormat('h:mm a').format(futureTime).toLowerCase(); // 4:00 pm
    }
    return PopScope(
      canPop: isForPaymentConfirmation ? false : true,
      onPopInvoked: (didPop) {
        if (didPop) return;
        openScreenWithClearPrevious(context: context, screen: const HomeMainV1());
      },
      child: CommonBackgroundWidget(
        onBackPressed: () {
          openScreenWithClearPrevious(context: context, screen: const HomeMainV1());
        },
        pageTitle: "",
        bodyPadding: EdgeInsetsDirectional.only(
          bottom: commonPadding35px,
          start: commonPadding35px,
          end: commonPadding35px,
        ),
        bodyBgColor: colorCommonBackground,
        bodyWidget: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RotatingCircleAnimation(isForPaymentConfirmation: isForPaymentConfirmation),
                SizedBox(height: commonPadding35px),
                Text(
                  isForPaymentConfirmation ? languages.orderConfirmed : languages.orderCancelled,
                  style: bodyText(
                    fontWeight: FontWeight.w900,
                    fontSize: textSize24px,
                    textColor: colorCommonBrown,
                  ),
                ),
                SizedBox(height: commonPadding16px),
                Text(
                  isForPaymentConfirmation
                      ? languages.orderPlacedSuccessful
                      : languages.orderSuccessfullyCancelled,
                  textAlign: TextAlign.center,
                  style: bodyText(
                    fontWeight: FontWeight.w600,
                    fontSize: textSize15px,
                    textColor: colorCommonBrown,
                  ),
                ),
                SizedBox(height: commonPadding16px),
                if (eta.isNotEmpty) ...[
                  Text(
                    '${languages.deliveryBy} $weekday, $day$daySuffix, $time',
                    textAlign: TextAlign.center,
                    style: bodyText(
                      fontWeight: FontWeight.w600,
                      fontSize: textSize15px,
                      textColor: colorCommonBrown,
                    ),
                  ),
                  SizedBox(height: commonPadding16px),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      languages.trackMyOrder,
                      textAlign: TextAlign.center,
                      style: bodyText(
                        fontWeight: FontWeight.w500,
                        fontSize: textSize20px,
                        textColor: colorPrimary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            Text(
              languages.ifQuestionsReachSupport,
              textAlign: TextAlign.center,
              style: bodyText(
                fontWeight: FontWeight.w500,
                fontSize: textSize16px,
                textColor: colorCommonBrown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
