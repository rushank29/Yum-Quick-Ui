import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class MyProfileShimmer extends StatelessWidget {
  const MyProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBase,
      highlightColor: colorShimmerHighlight,
      child: Column(
        children: [
          Container(
            width: commonSize128px,
            height: commonSize128px,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(height: commonPadding35px),
          ...List.generate(
            4,
            (_) => Padding(
              padding: EdgeInsets.only(bottom: commonPadding20px),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: deviceAvgScreenSize * 0.0268425,
                    width: deviceWidth * 0.25,
                    margin: EdgeInsetsDirectional.only(bottom: commonPadding10px),
                      color: colorBlack,
                  ),
                  Container(
                    height: commonSize50px,
                    decoration: BoxDecoration(
                      color: colorBlack,
                      borderRadius: BorderRadius.circular(borderRadius13px),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: commonPadding32px),
          // Button shimmer
          Container(
            height: commonSize45px,
            width: deviceWidth * 0.4,
            decoration: BoxDecoration(
              color: colorBlack,
              borderRadius: BorderRadius.circular(borderRadius30px),
            ),
          ),
        ],
      ),
    );
  }
}
