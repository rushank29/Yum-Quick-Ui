import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tab_container/tab_container.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../utils/text_style.dart';

class DishesShimmer extends StatelessWidget {
  const DishesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBase,
      highlightColor: colorShimmerHighlight,
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsetsDirectional.only(top: commonPadding20px),
          child: TabContainer(
            tabEdge: TabEdge.top,
            tabsStart: 0.1,
            tabsEnd: 0.9,
            tabMaxLength: 400,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(borderRadius30px),
              bottomRight: Radius.circular(borderRadius30px),
            ),
            tabBorderRadius: BorderRadius.circular(borderRadius30px),
            // childPadding: EdgeInsets.all(commonPadding20px),
            selectedTextStyle: bodyText(
              fontSize: textSize12px,
              textColor: colorCommonBrown,
            ),
            unselectedTextStyle: bodyText(
              fontSize: textSize12px,
              textColor: colorCommonBrown,
            ),
            colors: [
              colorMainBackground.withOpacity(0.9),
              colorMainBackground.withOpacity(0.9),
              colorMainBackground.withOpacity(0.9),
              colorMainBackground.withOpacity(0.9),
              colorMainBackground.withOpacity(0.9),
            ],
            tabs: List.generate(
              5,
              (i) {
                return Container(
                  height: commonSize16px,
                  width: commonSize45px,
                  color: colorBlack,
                );
              },
            ),
            children: List.generate(5, (index) {
              return Container(
                width: deviceWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(borderRadius30px),
                    topEnd: Radius.circular(borderRadius30px),
                  ),
                ),
                padding: EdgeInsetsDirectional.only(
                    start: commonPadding32px, end: commonPadding32px, top: commonPadding20px),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              height: commonSize16px,
                              width: commonSize45px,
                              color: colorBlack,
                            ),
                            SizedBox(width: commonPadding10px),
                            Container(
                              height: commonSize16px,
                              width: commonSize45px,
                              color: colorBlack,
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.015),
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            "assets/svg/shuffle.svg",
                            height: deviceAvgScreenSize * 0.015,
                            width: deviceAvgScreenSize * 0.015,
                            colorFilter: ColorFilter.mode(colorWhite, BlendMode.srcIn),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: commonPadding16px),
                    ListView.separated(
                      itemCount: 3,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsetsDirectional.zero,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsetsDirectional.only(bottom: commonPadding10px),
                          child: Divider(color: colorBlack),
                        );
                      },
                      itemBuilder: (context, position) {
                        return Container(
                          margin: EdgeInsetsDirectional.only(bottom: commonPadding10px),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: deviceWidth,
                                height: deviceHeight * 0.2,
                                decoration: BoxDecoration(
                                  color: colorBlack,borderRadius: BorderRadius.circular(borderRadius36px),
                                ),
                              ),
                              SizedBox(height: commonPadding10px),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: commonSize16px,
                                            width: commonSize80px,
                                            color: colorBlack,
                                          ),
                                          Container(
                                            height: deviceAvgScreenSize * 0.008,
                                            width: deviceAvgScreenSize * 0.008,
                                            margin: EdgeInsetsDirectional.symmetric(
                                              horizontal: commonPadding10px,
                                            ),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colorPrimary,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.0075),
                                            decoration: BoxDecoration(
                                              color: colorPrimary,
                                              borderRadius:
                                                  BorderRadiusDirectional.circular(borderRadius30px),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: commonSize10px,
                                                  width: commonSize10px,
                                                  color: colorBlack,
                                                ),
                                                SizedBox(width: deviceWidth * 0.01),
                                                Container(
                                                  padding: EdgeInsetsDirectional.only(
                                                    bottom: deviceHeight * 0.005,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    "assets/svg/rating_star_filled.svg",
                                                    colorFilter:
                                                        ColorFilter.mode(colorRatingStar, BlendMode.srcIn),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: deviceHeight * 0.002),
                                      Container(
                                        height: commonSize16px,
                                        width: deviceWidth*0.6,
                                        color: colorBlack,
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: commonSize16px,
                                    width: commonSize45px,
                                    color: colorBlack,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
