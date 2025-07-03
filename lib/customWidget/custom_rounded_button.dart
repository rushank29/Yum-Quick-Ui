import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../constant/dimensions.dart';
import '../utils/text_style.dart';

class CustomRoundedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? borderRadius;
  final double minBtnHeight;
  final double minBtnWidth;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color? borderColor;
  final Color? textColor;
  final EdgeInsetsDirectional padding;
  final EdgeInsetsDirectional? margin;
  final bool setProgress;
  final IconData? icon;
  final Widget? widget;
  final Color? iconColor;

  const CustomRoundedButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.backgroundColor,
    this.borderRadius,
    this.fontSize,
    this.fontWeight = FontWeight.w500,
    this.borderColor,
    this.textColor,
    this.padding = EdgeInsetsDirectional.zero,
    this.margin,
    this.setProgress = false,
    this.icon,
    this.iconColor,
    this.widget,
    this.minBtnHeight = 0,
    this.minBtnWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ElevatedButton(
        onPressed: setProgress ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(onPressed == null
              ? (backgroundColor?.withOpacity(0.3) ?? colorPrimaryLight)
              : backgroundColor ?? colorPrimary),
          minimumSize: MaterialStatePropertyAll(Size(deviceWidth * minBtnWidth, deviceHeight * minBtnHeight)),
          padding: MaterialStatePropertyAll(padding),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(
                borderRadius ?? deviceAvgScreenSize * 0.1789,
              ),
              side: BorderSide(
                color: borderColor ?? (backgroundColor ?? colorPrimary),
              ),
            ),
          ),
        ),
        child: setProgress
            ? SizedBox(
                height: progressSize20px,
                width: progressSize20px,
                child: CircularProgressIndicator(
                  strokeWidth: deviceAvgScreenSize * 0.0025,
                  color: (backgroundColor == null || backgroundColor == colorPrimary)
                      ? colorWhite
                      : colorPrimary,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    Flexible(
                      child: Container(
                        margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.02),
                        child: Icon(icon, color: iconColor),
                      ),
                    ),
                  if (widget != null) Flexible(child: widget!),
                  Flexible(
                    child: Text(
                      buttonText,
                      overflow: TextOverflow.ellipsis,
                      style: bodyText(
                        fontSize: fontSize ?? textSize17px,
                        fontWeight: fontWeight,
                        textColor: textColor,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
