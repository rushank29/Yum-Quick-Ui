import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:shimmer/shimmer.dart';
import '../../constant/dimensions.dart';

class BestSellerShimmer extends StatelessWidget {
  const BestSellerShimmer({super.key});

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
          childAspectRatio: 0.635,
          mainAxisSpacing: commonPadding10px,
          crossAxisSpacing: commonPadding10px,
        ),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Container(
                      margin: EdgeInsetsDirectional.only(top: commonPadding10px),
                      height: commonSize16px,
                      width: commonSize75px,
                      color: colorBlack,
                    ),
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.0075),
                    margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02, top: commonPadding10px),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadiusDirectional.circular(borderRadius30px),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: commonSize16px,
                          width: commonSize45px,
                          color: colorBlack,
                        ),
                        SizedBox(width: deviceWidth * 0.01),
                        SvgPicture.asset(
                          "assets/svg/rating_star_filled.svg",
                          colorFilter: ColorFilter.mode(colorRatingStar, BlendMode.srcIn),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: commonPadding10px),
                height: commonSize16px,
                width: deviceWidth,
                color: colorBlack,
              ),
              Container(
                margin: EdgeInsetsDirectional.only(top: commonPadding10px),
                height: commonSize16px,
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
