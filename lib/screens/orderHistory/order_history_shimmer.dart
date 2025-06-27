import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../utils/utils.dart';

class OrderHistoryShimmer extends StatelessWidget {
  const OrderHistoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBase,
      highlightColor: colorShimmerHighlight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.zero,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.symmetric(vertical: commonPadding24px),
                    child: Divider(color: colorPrimaryLight),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: commonSize28px,
                            width: commonSize128px,
                            color: colorBlack,
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                              top: commonPadding10px,
                              bottom: commonPadding10px,
                            ),
                            height: commonSize16px,
                            width: commonSize45px,
                            color: colorBlack,
                          ),
                          getOrderStatusWidget(0),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: commonSize16px,
                            width: commonSize80px,
                            color: colorBlack,
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                              top: commonPadding10px,
                              bottom: commonPadding10px,
                            ),
                            height: commonSize16px,
                            width: commonSize75px,
                            color: colorBlack,
                          ),
                          Container(
                            height: commonSize28px,
                            width: commonSize75px,
                            padding: EdgeInsetsDirectional.only(top: commonPadding10px),
                            decoration: BoxDecoration(
                                color: colorBlack,
                                borderRadius: BorderRadiusDirectional.circular(
                                  deviceAvgScreenSize * 0.1789,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          SizedBox(height: commonPadding24px),
          Divider(color: colorPrimaryLight),
        ],
      ),
    );
  }
}
