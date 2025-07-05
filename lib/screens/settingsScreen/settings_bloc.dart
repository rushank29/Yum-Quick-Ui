import 'package:flutter/material.dart';
import 'package:food_ui/screens/settingsScreen/passwordSettingScreen/password_setting_screen.dart';
import '../../constant/colors.dart';
import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/customBottomNavBar/custom_nav_bar_dl.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../main.dart';
import '../../utils/text_style.dart';
import 'notificationSettingScreen/notification_setting_screen.dart';

import '../../utils/utils.dart';

class SettingsBloc {
  final BuildContext context;

  SettingsBloc(this.context);

  List<ItemSettings> getSettingsList() {
    return [
      itemSettings(SettingItem.notificationSetting),
      itemSettings(SettingItem.passwordSetting),
      itemSettings(SettingItem.deleteAccount),
    ];
  }

  ItemSettings itemSettings(SettingItem item) {
    switch (item) {
      case SettingItem.notificationSetting:
        return ItemSettings(
          title: languages.notificationSetting,
          iconPath: "assets/svg/bell.svg",
          onTap: () {
            openScreen(context: context, screen: const NotificationSettingScreen());
          },
        );
      case SettingItem.passwordSetting:
        return ItemSettings(
          title: languages.passwordSetting,
          iconPath: "assets/svg/password_key_icon.svg",
          onTap: () {
            openScreen(context: context, screen: const PasswordSettingScreen());
          },
        );
      case SettingItem.deleteAccount:
        return ItemSettings(
          title: languages.deleteAccount,
          iconPath: "assets/svg/person.svg",
          onTap: () {
            deleteAccountBottomSheet();
          },
        );
    }
  }

  void deleteAccountBottomSheet() {
    showModalBottomSheet(
      backgroundColor: colorMainBackground,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
            topStart: Radius.circular(borderRadius20px),
            topEnd: Radius.circular(borderRadius20px),
          )),
      builder: (context) {
        return Container(
          width: deviceWidth,
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(
                  top: commonPadding300px * 0.15,
                  start: deviceAvgScreenSize * 0.146725,
                  end: deviceAvgScreenSize * 0.146725,
                ),
                child: Text(
                  languages.deleteAccountMsg,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: bodyText(
                    fontWeight: FontWeight.w500,
                    fontSize: textSize20px,
                    textColor: colorBlack,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomRoundedButton(
                      buttonText: languages.cancel,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      fontSize: textSize20px,
                      fontWeight: FontWeight.w400,
                      backgroundColor: colorPrimaryLight,
                      textColor: colorPrimary,
                      borderColor: colorPrimaryLight,
                      margin: EdgeInsetsDirectional.only(start: commonPadding35px),
                      minBtnHeight: 0.048,
                      minBtnWidth: 0.35,
                    ),
                  ),
                  SizedBox(width: deviceAvgScreenSize * 0.0268425),
                  Expanded(
                    child: CustomRoundedButton(
                      buttonText: languages.deleteConfirm,
                      onPressed: () {
                        deleteAccount(context);
                      },
                      fontSize: textSize20px,
                      margin: EdgeInsetsDirectional.only(end: commonPadding35px),
                      minBtnHeight: 0.048,
                      minBtnWidth: 0.35,
                    ),
                  ),
                ],
              ),
              SizedBox(height: commonPadding300px * 0.15),
            ],
          ),
        );
      },
    );
  }

  void dispose() {}
}
