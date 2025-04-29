import 'package:flutter/material.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/utils/text_style.dart';

import '../../constant/colors.dart';
import '../../customWidget/rotating_circle_animation.dart';

class CancelledOrderScreen extends StatefulWidget {
  const CancelledOrderScreen({super.key});

  @override
  State<CancelledOrderScreen> createState() => _CancelledOrderScreenState();
}

class _CancelledOrderScreenState extends State<CancelledOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
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
              const RotatingCircleAnimation(),
              SizedBox(height: commonPadding35px),
              Text(
                "¡Order Cancelled!",
                style: bodyText(
                  fontWeight: FontWeight.w900,
                  fontSize: textSize24px,
                  textColor: colorCommonBrown,
                ),
              ),
              SizedBox(height: commonPadding10px * 1.5),
              Text(
                "Your order has been successfully cancelled",
                textAlign: TextAlign.center,
                style: bodyText(
                  fontWeight: FontWeight.w600,
                  fontSize: textSize15px,
                  textColor: colorCommonBrown,
                ),
              ),
            ],
          ),
          Text(
            "If you have any question reach directly to our customer support",
            textAlign: TextAlign.center,
            style: bodyText(
              fontWeight: FontWeight.w500,
              fontSize: textSize16px,
              textColor: colorCommonBrown,
            ),
          ),
        ],
      ),
    );
  }
}
