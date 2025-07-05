import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/dimensions.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(minHeight: deviceHeight),
        child: Column(
          children: [
            Container(
              padding: EdgeInsetsDirectional.symmetric(horizontal: deviceAvgScreenSize * 0.04),
              decoration: BoxDecoration(
                color: colorHomeBackground,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(deviceAvgScreenSize * 0.04),
                  topEnd: Radius.circular(deviceAvgScreenSize * 0.04),
                ),
              ),
              child: Shimmer.fromColors(
                baseColor: colorShimmerBase,
                highlightColor: colorShimmerHighlight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Food category shimmer
                    Container(
                      height: deviceHeight * 0.135,
                      margin: EdgeInsetsDirectional.only(top: commonPadding20px),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (_, __) => Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(end: commonPadding16px),
                              width: commonSize45px * 1.2,
                              height: commonSize62px,
                              decoration: BoxDecoration(
                                color: colorBlack,
                                borderRadius: BorderRadius.circular(borderRadius30px),
                              ),
                            ),
                            Container(
                              margin: EdgeInsetsDirectional.only(
                                top: commonPadding16px,
                                end: deviceAvgScreenSize * 0.008945,
                              ),
                              height: commonSize45px * 0.4,
                              width: commonSize62px * 1.12,
                              color: colorBlack,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsetsDirectional.only(
                            top: commonPadding16px,
                          ),
                          height: commonSize45px * 0.75,
                          width: commonSize120px,
                          color: colorBlack,
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.only(
                            top: commonPadding16px,
                            end: commonPadding16px,
                          ),
                          height: commonSize45px * 0.6,
                          width: commonSize75px,
                          color: colorBlack,
                        ),
                      ],
                    ),
                    SizedBox(height: commonPadding10px),
                    // Bestseller shimmer
                    Container(
                      height: commonSize120px,
                      margin: EdgeInsetsDirectional.only(bottom: deviceAvgScreenSize * 0.04),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (_, __) => Container(
                          margin: EdgeInsetsDirectional.only(end: deviceAvgScreenSize * 0.02),
                          height: commonSize120px,
                          width: commonSize75px,
                          decoration: BoxDecoration(
                            color: colorBlack,
                            borderRadius: BorderRadius.circular(deviceAvgScreenSize * 0.02),
                          ),
                        ),
                      ),
                    ),
                    // Slider shimmer
                    Container(
                      height: commonSize128px,
                      margin: EdgeInsetsDirectional.only(bottom: commonPadding10px * 0.75),
                      decoration: BoxDecoration(
                        color: colorBlack,
                        borderRadius: BorderRadius.circular(deviceAvgScreenSize * 0.02),
                      ),
                    ),
                    Container(
                      height: deviceAvgScreenSize * 0.01073,
                      margin: EdgeInsetsDirectional.only(bottom: deviceAvgScreenSize * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(4, (index) {
                            return Container(
                              margin: EdgeInsetsDirectional.only(end: deviceAvgScreenSize * 0.02),
                              height: deviceAvgScreenSize * 0.01073,
                              width: commonSize50px * 0.4,
                              decoration: BoxDecoration(
                                color: colorBlack,
                                borderRadius: BorderRadius.circular(deviceAvgScreenSize * 0.02),
                              ),
                            );
                          },),
                      ),
                    ),
                    // Recommended shimmer
                    GridView.builder(
                      itemCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsetsDirectional.only(top: deviceAvgScreenSize * 0.02),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: deviceAvgScreenSize * 0.02,
                        mainAxisSpacing: deviceAvgScreenSize * 0.03,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (_, __) => Container(
                        decoration: BoxDecoration(
                          color: colorBlack,
                          borderRadius: BorderRadius.circular(deviceAvgScreenSize * 0.02),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
