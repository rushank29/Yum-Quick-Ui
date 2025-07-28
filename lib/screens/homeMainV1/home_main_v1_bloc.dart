import 'package:flutter/material.dart';
import 'package:food_ui/screens/homeMainV1/home_main_v1.dart';
import 'package:food_ui/shared_pref_util/shared_pref_constants.dart';
import 'package:rxdart/rxdart.dart';

import '../../constant/colors.dart';
import '../../customWidget/networkConnectivityChecker/internet_service.dart';
import '../../main.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../shared_pref_util/shared_pref_util.dart';
import '../../utils/response_util.dart';
import '../contactUsScreen/contact_us_screen.dart';
import '../deliveryAddressScreen/delivery_address_screen.dart';
import '../myOrdersScreen/my_orders_screen.dart';
import '../myProfileScreen/my_profile_screen.dart';
import '../paymentMethodsScreen/payment_methods_screen.dart';
import '../settingsScreen/settings_screen.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import '../../constant/constant.dart';
import '../../customWidget/customBottomNavBar/custom_nav_bar_dl.dart';
import 'drawerNotification/drawer_notification_dl.dart';
import 'drawerNotification/drawer_notification_json.dart';

class HomeMainV1Bloc {
  final BuildContext context;

  HomeMainV1Bloc(this.context) {
    getDrawerNotificationList();
  }

  final currentNavBarIndexSubject = BehaviorSubject<int>();
  final subjectDrawerNotification = BehaviorSubject<ResponseUtil<DrawerNotificationPojo>>();

  List<ItemBottomNavBar> getBottomNavBarList({required Function(int index) onSelected}) {
    return [
      itemBottomNavBar(BottomNavBarItem.home, onSelected: onSelected),
      itemBottomNavBar(BottomNavBarItem.dishes, onSelected: onSelected),
      itemBottomNavBar(BottomNavBarItem.favorite, onSelected: onSelected),
      itemBottomNavBar(BottomNavBarItem.orderHistory, onSelected: onSelected),
      itemBottomNavBar(BottomNavBarItem.helpAndSupport, onSelected: onSelected),
    ];
  }

  ItemBottomNavBar itemBottomNavBar(BottomNavBarItem item, {required Function(int index) onSelected}) {
    switch (item) {
      case BottomNavBarItem.home:
        return ItemBottomNavBar(
          iconPath: "assets/svg/home_icon.svg",
          onTap: () => onSelected(0),
        );
      case BottomNavBarItem.dishes:
        return ItemBottomNavBar(
          iconPath: "assets/svg/dishes_icon.svg",
          onTap: () => onSelected(1),
        );
      case BottomNavBarItem.favorite:
        return ItemBottomNavBar(
          iconPath: "assets/svg/favorite_icon.svg",
          onTap: () => onSelected(2),
        );
      case BottomNavBarItem.orderHistory:
        return ItemBottomNavBar(
          iconPath: "assets/svg/order_history_icon.svg",
          onTap: () => onSelected(3),
        );
      case BottomNavBarItem.helpAndSupport:
        return ItemBottomNavBar(
          iconPath: "assets/svg/help_and_support_icon.svg",
          onTap: () => onSelected(4),
        );
    }
  }

  List<ItemDrawer> getDrawerList() {
    return [
      itemDrawer(DrawerItem.myOrders),
      itemDrawer(DrawerItem.myProfile),
      itemDrawer(DrawerItem.deliveryAddress),
      itemDrawer(DrawerItem.paymentMethods),
      itemDrawer(DrawerItem.contactUs),
      itemDrawer(DrawerItem.selectLanguage),
      itemDrawer(DrawerItem.helpAndFAQs),
      itemDrawer(DrawerItem.settings),
      itemDrawer(DrawerItem.logOut),
    ];
  }

  ItemDrawer itemDrawer(DrawerItem item) {
    switch (item) {
      case DrawerItem.myOrders:
        return ItemDrawer(
          title: languages.myOrders,
          iconPath: "assets/svg/my_orders_icon.svg",
          onTap: () {
            openScreen(context: context, screen: const MyOrdersScreen());
          },
        );
      case DrawerItem.myProfile:
        return ItemDrawer(
          title: languages.myProfile,
          iconPath: "assets/svg/person.svg",
          onTap: () {
            openScreen(context: context, screen: const MyProfileScreen());
          },
        );
      case DrawerItem.deliveryAddress:
        return ItemDrawer(
          title: "${languages.delivery} ${languages.address}",
          iconPath: "assets/svg/delivery_address_icon.svg",
          onTap: () {
            openScreen(context: context, screen: const DeliveryAddressScreen());
          },
        );
      case DrawerItem.paymentMethods:
        return ItemDrawer(
          title: languages.paymentMethods,
          iconPath: "assets/svg/card_icon.svg",
          onTap: () {
            openScreen(context: context, screen: const PaymentMethodsScreen());
          },
        );
      case DrawerItem.selectLanguage:
        return ItemDrawer(
          title: languages.selectLanguage,
          iconPath: "assets/svg/settings_icon.svg",
          onTap: () {
            selectLanguageBottomSheet();
          },
        );
      case DrawerItem.contactUs:
        return ItemDrawer(
          title: languages.contactUs,
          iconPath: "assets/svg/contact_us.svg",
          onTap: () {
            openScreen(context: context, screen: const ContactUsScreen(selectedMainTab: 1));
          },
        );
      case DrawerItem.helpAndFAQs:
        return ItemDrawer(
          title: languages.helpAndFAQ,
          iconPath: "assets/svg/help_and_faq_icon.svg",
          onTap: () {
            openScreen(context: context, screen: const ContactUsScreen(selectedMainTab: 0));
          },
        );
      case DrawerItem.settings:
        return ItemDrawer(
          title: languages.settings,
          iconPath: "assets/svg/settings_icon.svg",
          onTap: () {
            openScreen(context: context, screen: const SettingsScreen());
          },
        );
      case DrawerItem.logOut:
        return ItemDrawer(
          title: languages.logOut,
          iconPath: "assets/svg/logout.svg",
          onTap: () {
            logoutBottomSheet();
          },
        );
    }
  }

  void logoutBottomSheet() {
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
                  languages.areYouSureWantToLogout,
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
                      buttonText: languages.confirmLogout,
                      onPressed: () {
                        logout(context);
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

  void selectLanguageBottomSheet() {
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
                  languages.selectLanguage,
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
                    child: languageSelection(
                      "Arabic",
                      "ar",
                      EdgeInsetsDirectional.only(start: commonPadding35px),
                    ),
                  ),
                  SizedBox(width: deviceAvgScreenSize * 0.0268425),
                  Expanded(
                    child: languageSelection(
                      "English",
                      "en",
                      EdgeInsetsDirectional.only(end: commonPadding35px),
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

  void getDrawerNotificationList() async {
    InternetService().runWhenOnline(() {
      try {
        subjectDrawerNotification.sink.add(ResponseUtil.loading());
        var response = DrawerNotificationPojo.fromJson(drawerNotificationJson);
        subjectDrawerNotification.sink.add(ResponseUtil.completed(response));
      } catch (error) {
        subjectDrawerNotification.sink.add(ResponseUtil.error(error.toString()));
        openSimpleSnackBar(error.toString());
      }
    });
  }

  Widget languageSelection(String languageName, String languageCode, EdgeInsetsDirectional margin) {
    bool isLanguageSelected =
        (getString(prefSelectedLanguageCode).isNotEmpty ? getString(prefSelectedLanguageCode) : "en") ==
            languageCode;
    return CustomRoundedButton(
      buttonText: languageName,
      onPressed: () {
        setChangedLanguage(
          context,
          languageCode,
          nextAction: () {
            openScreenWithClearPrevious(context: context, screen: const HomeMainV1());
          },
        );
      },
      fontSize: textSize20px,
      fontWeight: isLanguageSelected ? FontWeight.w500 : FontWeight.w400,
      margin: margin,
      backgroundColor: isLanguageSelected ? null : colorPrimaryLight,
      textColor: isLanguageSelected ? null : colorPrimary,
      borderColor: isLanguageSelected ? null : colorPrimaryLight,
      minBtnHeight: 0.048,
      minBtnWidth: 0.4,
    );
  }

  void dispose() {
    currentNavBarIndexSubject.close();
    subjectDrawerNotification.close();
  }
}
