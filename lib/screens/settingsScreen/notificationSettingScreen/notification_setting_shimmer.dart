import 'package:flutter/material.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constant/colors.dart';

class NotificationSettingShimmer extends StatelessWidget {
  const NotificationSettingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBase,
      highlightColor: colorShimmerHighlight,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsetsDirectional.only(top: deviceAvgScreenSize * 0.008945),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsetsDirectional.only(bottom: commonPadding16px),
                height: commonSize45px * 0.5,
                width: commonSize128px * 1.5,
                color: colorBlack,
              ),
              Container(
                margin: EdgeInsetsDirectional.only(bottom: commonPadding16px),
                height: commonSize45px * 0.5,
                width: commonSize45px,
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(borderRadius20px),
                  color: colorBlack,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
