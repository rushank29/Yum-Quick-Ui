import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_image.dart';
import '../../shared_pref_util/shared_pref_constants.dart';
import '../../shared_pref_util/shared_pref_util.dart';
import '../../utils/text_style.dart';
import '../../customWidget/customBottomNavBar/custom_bottom_nav_bar.dart';
import '../../customWidget/customBottomNavBar/custom_nav_bar_dl.dart';
import 'home_main_v1_bloc.dart';

import '../homeScreen/home_screen.dart';

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
          endDrawer: Drawer(
            backgroundColor: colorPrimary,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                topStart: Radius.circular(borderRadius30px),
                bottomStart: Radius.circular(borderRadius30px),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: commonPadding300px * 0.2,
                      bottom: commonPadding20px * 2,
                      start: commonPadding32px,
                      end: commonPadding10px * 1.5,
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
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(commonPadding10px),
                                    decoration: BoxDecoration(
                                      color: colorMainBackground,
                                      borderRadius: BorderRadius.circular(borderRadius30px * 0.5),
                                    ),
                                    child: SvgPicture.asset(
                                      item.iconPath,
                                      height: commonSize45px * 0.5,
                                      width: commonSize45px * 0.5,
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
            ),
          ),
          body: <Widget>[
            const HomeScreen(),
            Container(),
            Container(),
            Container(),
            Container(),
          ][currentNavBarIndex],
          bottomNavigationBar: CustomBottomNavBar(
            bottomNavBarList: bottomNavBarList,
            currentIndex: currentNavBarIndex,
          ),
        );
      },
    );
  }
}
