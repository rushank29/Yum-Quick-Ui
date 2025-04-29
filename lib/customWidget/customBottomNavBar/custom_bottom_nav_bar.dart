import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import 'custom_nav_bar_dl.dart';

class CustomBottomNavBar extends StatelessWidget {
  final List<ItemBottomNavBar> bottomNavBarList;
  final int currentIndex;
  const CustomBottomNavBar({super.key, required this.bottomNavBarList, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorMainBackground,
      // margin: EdgeInsetsDirectional.only(top: commonPadding10px),
      child: ClipRRect(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(borderRadius30px),
          topEnd: Radius.circular(borderRadius30px),
        ),
        child: BottomAppBar(
          color: colorPrimary,
          shape: const CircularNotchedRectangle(),
          notchMargin: commonPadding10px * 0.8,
          child: Container(
            color: Colors.transparent,
            height: commonSize45px,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(bottomNavBarList.length, (index) {
                final item = bottomNavBarList[index];
                return Expanded(
                  child: GestureDetector(
                    onTap: item.onTap,
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: SvgPicture.asset(
                        item.iconPath,
                        colorFilter: ColorFilter.mode(
                          currentIndex == index ? colorCommonBackground : colorTextCommon,
                          BlendMode.srcIn,
                        ),
                        height: iconSize24px,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
