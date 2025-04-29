import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constant/colors.dart';
import '../constant/dimensions.dart';
import '../utils/text_style.dart';

class NoRecordFound extends StatelessWidget {
  final String? message;
  final double? height;
  const NoRecordFound({super.key, this.message, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? deviceHeight * 0.6,
      alignment: AlignmentDirectional.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/svg/transfer_doc_icon.svg",
            height: deviceHeight * 0.22164,
            width: deviceWidth * 0.38889,
            colorFilter: ColorFilter.mode(colorPrimaryLight, BlendMode.srcIn),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(
              start: deviceWidth * 0.15278,
              end: deviceWidth * 0.15278,
            ),
            child: Text(
              message ?? "You don't have any active orders at this time",
              textAlign: TextAlign.center,
              style: bodyText(
                fontSize: textSize30px,
                fontWeight: FontWeight.w500,
                textColor: colorPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
