import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                    "Hello!",
                    style: bodyText(
                      fontWeight: FontWeight.w300,
                      textColor: colorCommonBrown,
                    ),
                  ),
                ], "09:00", true),
                chatMsgWidget([
                  Text(
                    "Hello!, please choose the number corresponding to your needs for a more efficient service.",
                    style: bodyText(
                      fontWeight: FontWeight.w300,
                      textColor: colorCommonBrown,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: '1. ',
                      style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w500),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Order Management',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: '\n2. ',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: 'Payments Management',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: '\n3. ',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: 'Account management and profile',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: '\n4. ',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: 'About order tracking',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                        ),
                        TextSpan(
                          text: '\n5. ',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w500),
                        ),
                        TextSpan(
                          text: 'Safety',
                          style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ], "09:00", false),
                chatMsgWidget([
                  Text(
                    "1",
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
                            text: 'You have a current order Strawberry Shake and Broccoli Lasagna',
                            style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300),
                            children: <TextSpan>[
                              TextSpan(
                                text: '\nOrder No. 0054752 \n29 Nov, 01:20 pm',
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
                                "Order Issues",
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
                                "Order not received",
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
                    "2",
                    style: bodyText(
                      fontWeight: FontWeight.w300,
                      textColor: colorCommonBrown,
                    ),
                  ),
                ], "09:07", true),
              ],
            ),
          ),
          Container(
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
                    hintText: "Write here...",
                    suffixPadding: EdgeInsetsDirectional.all(commonPadding10px * 0.5),
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
          )
        ],
      ),
    );
  }
}
