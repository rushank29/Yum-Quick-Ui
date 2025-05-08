import 'package:flutter/material.dart';
import '../../constant/constant.dart';
import '../../customWidget/customBottomNavBar/custom_nav_bar_dl.dart';
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
          title: "Notification Setting",
          iconPath: "assets/svg/bell.svg",
          onTap: () {
            openScreen(context: context, screen: const NotificationSettingScreen());
          },
        );
      case SettingItem.passwordSetting:
        return ItemSettings(
          title: "Password Setting",
          iconPath: "assets/svg/password_key_icon.svg",
          onTap: () {
            // openScreen(context: context, screen: const MyProfileScreen());
          },
        );
      case SettingItem.deleteAccount:
        return ItemSettings(
          title: "Delete Account",
          iconPath: "assets/svg/person.svg",
          onTap: () {
            // openScreen(context: context, screen: const DeliveryAddressScreen());
          },
        );
    }
  }

  void dispose() {}
}
