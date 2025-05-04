import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/customWidget/custom_rounded_button.dart';
import 'package:food_ui/screens/deliveryAddressScreen/delivery_address_screen.dart';
import 'package:food_ui/screens/myOrdersScreen/my_orders_screen.dart';
import 'package:food_ui/screens/myProfileScreen/my_profile_screen.dart';
import 'package:food_ui/utils/text_style.dart';
import 'package:food_ui/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

import '../../constant/constant.dart';
import '../../customWidget/customBottomNavBar/custom_nav_bar_dl.dart';

class HomeMainV1Bloc {
  final BuildContext context;

  HomeMainV1Bloc(this.context);

  final currentNavBarIndexSubject = BehaviorSubject<int>();

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
      itemDrawer(DrawerItem.helpAndFAQs),
      itemDrawer(DrawerItem.settings),
      itemDrawer(DrawerItem.logOut),
    ];
  }

  ItemDrawer itemDrawer(DrawerItem item) {
    switch (item) {
      case DrawerItem.myOrders:
        return ItemDrawer(
          title: "My Orders",
          iconPath: "assets/svg/my_orders_icon.svg",
          onTap: () {
            openScreen(context: context, screen: const MyOrdersScreen());
          },
        );
      case DrawerItem.myProfile:
        return ItemDrawer(
          title: "My Profile",
          iconPath: "assets/svg/person.svg",
          onTap: () {
            openScreen(context: context, screen: const MyProfileScreen());
          },
        );
      case DrawerItem.deliveryAddress:
        return ItemDrawer(
          title: "Delivery Address",
          iconPath: "assets/svg/delivery_address_icon.svg",
          onTap: () {
            openScreen(context: context, screen: const DeliveryAddressScreen());
          },
        );
      case DrawerItem.paymentMethods:
        return ItemDrawer(
          title: "Payment Methods",
          iconPath: "assets/svg/card_icon.svg",
          onTap: () {
            // openScreen(context: context, screen: OrderHistoryScreen());
          },
        );
      case DrawerItem.contactUs:
        return ItemDrawer(
          title: "Contact Us",
          iconPath: "assets/svg/contact_us.svg",
          onTap: () {
            // openScreen(context: context, screen: OrderHistoryScreen());
          },
        );
      case DrawerItem.helpAndFAQs:
        return ItemDrawer(
          title: "Help and FAQs",
          iconPath: "assets/svg/help_and_faq_icon.svg",
          onTap: () {
            // openScreen(context: context, screen: OrderHistoryScreen());
          },
        );
      case DrawerItem.settings:
        return ItemDrawer(
          title: "Settings",
          iconPath: "assets/svg/settings_icon.svg",
          onTap: () {
            // openScreen(context: context, screen: OrderHistoryScreen());
          },
        );
      case DrawerItem.logOut:
        return ItemDrawer(
          title: "Logout",
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
                  start: commonPadding300px * 0.25,
                  end: commonPadding300px * 0.25,
                ),
                child: Text(
                  "Are you sure you want to log out?",
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
                      buttonText: "Cancel",
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      fontSize: textSize20px,
                      fontWeight: FontWeight.w400,
                      backgroundColor: colorPrimaryLight,
                      textColor: colorPrimary,
                      borderColor: colorPrimaryLight,
                      margin: EdgeInsetsDirectional.only(start: commonPadding35px),
                      padding: EdgeInsetsDirectional.only(
                        start: commonPadding10px,
                        end: commonPadding10px,
                      ),
                    ),
                  ),
                  SizedBox(width: commonPadding10px * 1.5),
                  Expanded(
                    child: CustomRoundedButton(
                      buttonText: "Yes, logout",
                      onPressed: () {
                        logout(context);
                      },
                      fontSize: textSize20px,
                      margin: EdgeInsetsDirectional.only(end: commonPadding35px),
                      padding: EdgeInsetsDirectional.only(
                        start: commonPadding10px,
                        end: commonPadding10px,
                      ),
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

  void dispose() {
    currentNavBarIndexSubject.close();
  }
}
