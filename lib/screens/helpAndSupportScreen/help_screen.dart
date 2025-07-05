import 'package:flutter/material.dart';
import 'package:food_ui/screens/helpAndSupportScreen/support_screen.dart';
import 'package:food_ui/utils/utils.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../main.dart';
import '../../utils/text_style.dart';
import 'help_dl.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      showBackButton: false,
      pageTitle: languages.help,
      bodyWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            languages.loremIpsum,
            style: bodyText(
              fontSize: textSize14px,
              fontWeight: FontWeight.w300,
              textColor: colorCommonBrown,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: commonPadding24px),
            child: Divider(color: colorPrimaryLight),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.zero,
            itemCount: helpAndSupportList.length,
            itemBuilder: (context, index) {
              return _itemHelpSupportList(helpAndSupportList, index);
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: commonPadding16px),
                child: Divider(color: colorPrimaryLight),
              );
            },
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: commonPadding16px),
            child: Divider(color: colorPrimaryLight),
          )
        ],
      ),
    );
  }

  Widget _itemHelpSupportList(List<ItemHelpList> helpAndSupportList, int index) {
    return GestureDetector(
      onTap: () {
        openScreen(context: context, screen: const SupportScreen());
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  helpAndSupportList[index].title,
                  style: bodyText(
                    fontSize: textSize20px,
                    fontWeight: FontWeight.w500,
                    textColor: colorCommonBrown,
                  ),
                ),
                Text(
                  helpAndSupportList[index].subTitle,
                  style: bodyText(
                    fontSize: textSize14px,
                    fontWeight: FontWeight.w300,
                    textColor: colorCommonBrown,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colorPrimary,
              size: iconSize24px,
            ),
          ],
        ),
      ),
    );
  }

  List<ItemHelpList> helpAndSupportList = [
    ItemHelpList(title: languages.helpWithTheOrder, subTitle: languages.support),
    ItemHelpList(title: languages.helpCenter, subTitle: languages.generalInformation),
  ];
}
