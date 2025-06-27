import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';

class FavoritesShimmer extends StatelessWidget {
  const FavoritesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBase,
      highlightColor: colorShimmerHighlight,
      child: GridView.builder(
        itemCount: 6,
        shrinkWrap: true,
        padding: EdgeInsetsDirectional.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.667,
          mainAxisSpacing: commonPadding10px,
          crossAxisSpacing: commonPadding10px,
        ),
        itemBuilder: (context, index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius20px),
                  color: colorBlack,
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: commonPadding10px),
                height: commonSize16px,
                width: deviceWidth,
                color: colorBlack,
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: commonPadding10px),
                height: commonSize10px,
                width: deviceWidth,
                color: colorBlack,
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: commonPadding10px),
                height: commonSize10px,
                width: deviceWidth,
                color: colorBlack,
              ),
            ],
          );
        },
      ),
    );
  }
}
