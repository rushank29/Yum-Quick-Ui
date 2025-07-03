import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../main.dart';
import '../favoritesScreen/favorites_screen.dart';
import '../helpAndSupportScreen/help_screen.dart';
import '../orderHistory/order_history_screen.dart';
import '../../utils/response_util.dart';
import '../../constant/colors.dart';
import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_image.dart';
import '../../shared_pref_util/shared_pref_constants.dart';
import '../../shared_pref_util/shared_pref_util.dart';
import '../../utils/text_style.dart';
import '../../customWidget/customBottomNavBar/custom_bottom_nav_bar.dart';
import '../../customWidget/customBottomNavBar/custom_nav_bar_dl.dart';
import '../dishesScreen/dishes_screen.dart';
import '../homeScreen/home_screen.dart';
import 'drawerCart/drawer_cart_screen.dart';
import 'drawerNotification/drawer_notification.dart';
import 'drawerNotification/drawer_notification_dl.dart';
import 'home_main_v1_bloc.dart';

class HomeMainV1 extends StatefulWidget {
  const HomeMainV1({super.key});

  @override
  State<HomeMainV1> createState() => _HomeMainV1State();
}

class _HomeMainV1State extends State<HomeMainV1> {
  HomeMainV1Bloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= HomeMainV1Bloc(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _bloc?.currentNavBarIndexSubject,
      builder: (context, snapCurrentIndex) {
        List<ItemBottomNavBar> bottomNavBarList = _bloc?.getBottomNavBarList(
              onSelected: (index) {
                _bloc?.currentNavBarIndexSubject.sink.add(index);
              },
            ) ??
            [];
        List<ItemDrawer> drawerList = _bloc?.getDrawerList() ?? [];
        int currentNavBarIndex = snapCurrentIndex.data ?? 0;
        final currentUser = FirebaseAuth.instance.currentUser;
        String userDisplayName = (currentUser?.displayName != null && currentUser!.displayName!.isNotEmpty)
            ? currentUser.displayName!
            : prefs!.getString(prefUserName)!;
        return Scaffold(
          endDrawer: StreamBuilder<int>(
              stream: selectedDrawerIndexSubject,
              builder: (context, snapDrawerIndex) {
                int selectedDrawerIndex = snapDrawerIndex.data ?? 1;
                print("selectedDrawerIndex ================> $selectedDrawerIndex");
                return _getDrawerData(currentUser, drawerList, userDisplayName, selectedDrawerIndex);
              }),
          body: <Widget>[
            const HomeScreen(),
            const DishesScreen(),
            const FavoritesScreen(),
            const OrderHistoryScreen(),
            const HelpScreen(),
          ][currentNavBarIndex],
          bottomNavigationBar: CustomBottomNavBar(
            bottomNavBarList: bottomNavBarList,
            currentIndex: currentNavBarIndex,
          ),
        );
      },
    );
  }

  Widget _getDrawerData(
      User? currentUser, List<ItemDrawer> drawerList, String userDisplayName, int selectedDrawerIndex) {
    return Drawer(
      backgroundColor: colorPrimary,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(borderRadius30px),
          bottomStart: Radius.circular(borderRadius30px),
        ),
      ),
      child: (selectedDrawerIndex == 1)
          ? _profileDrawer(currentUser, drawerList, userDisplayName)
          : (selectedDrawerIndex == 2)
              ? _notificationDrawer()
              : _cartDrawer(),
    );
  }

  Widget _cartDrawer() {
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.only(start: commonPadding32px, end: commonPadding32px),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: deviceAvgScreenSize * 0.10737,
              bottom: deviceAvgScreenSize * 0.07158,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.010737),
                  decoration: BoxDecoration(
                    color: colorMainBackground,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    "assets/svg/cart.svg",
                    height: iconSize33px,
                    width: iconSize24px,
                    colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                  ),
                ),
                SizedBox(width: commonPadding10px),
                Text(
                  languages.cart,
                  style: bodyText(
                    fontSize: textSize24px,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: colorPeach),
          const DrawerCartScreen(),
        ],
      ),
    );
  }

  Widget _notificationDrawer() {
    return SingleChildScrollView(
      padding: EdgeInsetsDirectional.only(start: commonPadding32px, end: commonPadding32px),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: deviceAvgScreenSize * 0.10737,
              bottom: deviceAvgScreenSize * 0.07158,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/svg/bell.svg",
                  height: iconSize33px,
                  width: iconSize24px,
                  colorFilter: ColorFilter.mode(colorTextCommon, BlendMode.srcIn),
                ),
                SizedBox(width: commonPadding10px),
                Text(
                  languages.notifications,
                  style: bodyText(
                    fontSize: textSize24px,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Divider(color: colorDividerOrange),
          StreamBuilder<ResponseUtil<DrawerNotificationPojo>>(
              stream: _bloc?.subjectDrawerNotification,
              builder: (context, snapDrawerNotification) {
                List<ItemDrawerNotificationList> drawerNotificationList =
                    snapDrawerNotification.data?.data?.drawerNotificationList ?? [];
                return DrawerNotification(drawerNotificationList: drawerNotificationList);
              }),
        ],
      ),
    );
  }

  Widget _profileDrawer(User? currentUser, List<ItemDrawer> drawerList, String userDisplayName) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: deviceAvgScreenSize * 0.10737,
              bottom: deviceAvgScreenSize * 0.07158,
              start: commonPadding32px,
              end: deviceAvgScreenSize * 0.0268425,
            ),
            child: Row(
              children: [
                CustomImage(
                  imagePath: currentUser?.photoURL ?? "",
                  showDefaultImage: true,
                  width: commonSize50px,
                  height: commonSize50px,
                ),
                SizedBox(width: commonPadding10px),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          userDisplayName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: bodyText(
                            fontSize: textSize32px,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          currentUser?.email ?? prefs!.getString(prefUserEmail)!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: bodyText(
                              fontSize: textSize16px,
                              fontWeight: FontWeight.w500,
                              textColor: colorFormFieldBg),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: drawerList.asMap().entries.map((entry) {
              int drawerIndex = entry.key;
              ItemDrawer item = entry.value;
              return Container(
                color: Colors.transparent,
                margin: EdgeInsets.symmetric(
                  horizontal: commonPadding16px,
                ),
                child: GestureDetector(
                  onTap: item.onTap,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(commonPadding10px),
                              decoration: BoxDecoration(
                                color: colorMainBackground,
                                borderRadius: BorderRadius.circular(borderRadius15px),
                              ),
                              child: SvgPicture.asset(
                                item.iconPath,
                                height: iconSize24px,
                                width: iconSize24px,
                              ),
                            ),
                            SizedBox(width: commonPadding16px),
                            Text(
                              item.title,
                              style: bodyText(
                                fontSize: textSize24px,
                                fontWeight: FontWeight.w500,
                                textColor: colorFormFieldBg,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: commonPadding10px,
                        ),
                        child: (drawerIndex != drawerList.length - 1)
                            ? Divider(color: colorDividerOrange)
                            : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
