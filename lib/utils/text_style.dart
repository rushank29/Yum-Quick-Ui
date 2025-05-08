import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle bodyText({double? fontSize, FontWeight? fontWeight, Color? textColor}) {
  return GoogleFonts.leagueSpartan(
    fontSize: fontSize ?? textSize14px,
    fontWeight: fontWeight ?? FontWeight.normal,
    color: textColor ?? colorTextCommon,
  );
}

TextStyle headerText({double? fontSize, FontWeight? fontWeight, Color? textColor}) {
  return GoogleFonts.inter(
    fontSize: fontSize ?? textSize24px,
    fontWeight: fontWeight ?? FontWeight.w900,
    color: textColor ?? colorPrimary,
  );
}

TextStyle formFieldStyle() {
  return bodyText(textColor: colorCommonBrown, fontSize: textSize20px);
}
