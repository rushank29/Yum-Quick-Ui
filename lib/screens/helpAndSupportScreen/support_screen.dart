import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/main.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../customWidget/custom_text_form_field.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "Support",
      bodyPadding: EdgeInsetsDirectional.only(top: commonPadding24px),
      bodyWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: commonPadding24px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                chatMsgWidget([
                  Text(
                    languages.hello,
                    style: bodyText(
                      fontWeight: FontWeight.w300,
                      textColor: colorCommonBrown,
                    ),
                  ),
                ], "09:00", true),
                chatMsgWidget([
                  Text(
                    languages.helloPleaseChooseNumberCorresponding,
                    style: bodyText(
                      fontWeight: FontWeight.w300,
                      textColor: colorCommonBrown,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '${languages.one}. ',
                      style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: languages.orderManagement,
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: '\n${languages.two}. ',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: languages.paymentsManagement,
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: '\n${languages.three}. ',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: languages.accountManagementAndProfile,
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: '\n${languages.four}. ',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: languages.aboutOrderTracking,
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: '\n${languages.five}. ',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: languages.safety,
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ], "09:00", false),
                chatMsgWidget([
                  Text(
                    languages.one,
                    style: bodyText(
                      fontWeight: FontWeight.w300,
                      textColor: colorCommonBrown,
                    ),
                  ),
                ], "09:03", true),
                chatMsgWidget([
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.01),
                        child: RichText(
                          text: TextSpan(
                            text: languages.aboutCurrentOrder,
                            style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                            children: <TextSpan>[
                              TextSpan(
                                text: '\n${languages.orderNo} 0054752 \n29 Nov, 01:20 pm',
                                style: bodyText(
                                  textColor: colorCommonBrown,
                                  fontWeight: FontWeight.w500,
                                  fontSize: textSize12px,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                color: colorPrimaryLight,
                                borderRadius: BorderRadiusDirectional.circular(borderRadius20px),
                              ),
                              padding: EdgeInsetsDirectional.all(commonPadding10px),
                              child: Text(
                                languages.orderIssues,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: bodyText(fontSize: textSize12px, textColor: colorPrimary),
                              ),
                            ),
                          ),
                          SizedBox(width: deviceWidth * 0.01),
                          Flexible(
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              decoration: BoxDecoration(
                                color: colorPrimaryLight,
                                borderRadius: BorderRadiusDirectional.circular(borderRadius20px),
                              ),
                              padding: EdgeInsetsDirectional.all(commonPadding10px),
                              child: Text(
                                languages.orderNotReceived,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: bodyText(fontSize: textSize12px, textColor: colorPrimary),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ], "09:06", false),
                chatMsgWidget([
                  Text(
                    languages.two,
                    style: bodyText(
                      fontWeight: FontWeight.w300,
                      textColor: colorCommonBrown,
                    ),
                  ),
                ], "09:07", true),
              ],
            ),
          ),
          _bottomSection(),
        ],
      ),
    );
  }

  Widget _bottomSection() {
    return Container(
      decoration: BoxDecoration(color: colorLightOrange),
      padding: EdgeInsetsDirectional.all(commonPadding24px),
      margin: EdgeInsetsDirectional.only(top: commonPadding20px),
      child: Row(
        children: [
          Container(
            padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.01),
            margin: EdgeInsetsDirectional.only(end: deviceWidth * 0.015),
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadiusDirectional.circular(borderRadius10px),
            ),
            child: SvgPicture.asset(
              "assets/svg/attach_icon.svg",
              height: iconSize20px,
              width: iconSize20px,
              colorFilter: ColorFilter.mode(
                colorPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
          Expanded(
            child: CustomTextFormField(
              backgroundColor: colorWhite,
              formFieldHeight: deviceHeight * 0.04,
              hintText: languages.writeHere,
              suffixPadding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.008945),
              contentPadding: EdgeInsetsDirectional.symmetric(
                  horizontal: commonPadding10px, vertical: commonPadding10px * 0),
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.01),
            margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.015),
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadiusDirectional.circular(borderRadius10px),
            ),
            child: SvgPicture.asset(
              "assets/svg/microphone.svg",
              height: iconSize20px,
              width: iconSize20px,
              colorFilter: ColorFilter.mode(
                colorPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
          Container(
            padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.01),
            margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.015),
            decoration: BoxDecoration(
              color: colorWhite,
              borderRadius: BorderRadiusDirectional.circular(borderRadius10px),
            ),
            child: SvgPicture.asset(
              "assets/svg/share.svg",
              colorFilter: ColorFilter.mode(
                colorPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
