import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ui/screens/homeMainV1/drawerNotification/drawer_notification_dl.dart';

import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../utils/text_style.dart';

class DrawerNotification extends StatelessWidget {
  final List<ItemDrawerNotificationList> drawerNotificationList;

  const DrawerNotification({super.key, required this.drawerNotificationList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: drawerNotificationList.length,
      padding: EdgeInsetsDirectional.only(top: deviceAvgScreenSize * 0.07158),
      itemBuilder: (context, index) {
        ItemDrawerNotificationList item = drawerNotificationList[index];
        return Container(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(commonPadding10px),
                    decoration: BoxDecoration(
                      color: colorMainBackground,
                      borderRadius: BorderRadius.circular(borderRadius30px * 0.5),
                    ),
                    child: SvgPicture.asset(
                      item.notificationIcon,
                      height: commonSize45px * 0.5,
                      width: commonSize45px * 0.5,
                      colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                    ),
                  ),
                  SizedBox(width: commonPadding16px),
                  Flexible(
                    child: Container(
                      margin: EdgeInsetsDirectional.only(end: commonPadding300px * 0.25),
                      child: Text(
                        item.notificationMessage,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: bodyText(
                          fontSize: textSize15px,
                          fontWeight: FontWeight.w500,
                          textColor: colorFormFieldBg,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: commonPadding10px,
                ),
                child: (index != drawerNotificationList.length)
                    ? Divider(color: colorDividerOrange)
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }
}
