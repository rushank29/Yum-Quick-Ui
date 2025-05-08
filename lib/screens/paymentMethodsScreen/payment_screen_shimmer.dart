import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/dimensions.dart';

class PaymentScreenShimmer extends StatelessWidget {
  const PaymentScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorShimmerBase,
      highlightColor: colorShimmerHighlight,
      child: Column(
        children: [
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.zero,
            itemCount: 6,
            separatorBuilder: (_, __) => Divider(color: colorBlack),
            itemBuilder: (_, position) {
              return Column(
                children: [
                  if (position == 0) Divider(color: colorBlack),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: commonSize45px * 0.65,
                            width: commonSize45px,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(borderRadius10px),
                              color: colorBlack,
                            ),
                          ),
                          SizedBox(width: commonPadding16px),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: commonSize45px * 0.5,
                                width: deviceWidth * 0.3,
                                margin: EdgeInsetsDirectional.symmetric(vertical: commonPadding10px * 0.75),
                                color: colorBlack,
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (position != 5) ...[
                        Radio<int>(
                          value: 0,
                          groupValue: 1,
                          onChanged: (value) {},
                        )
                      ],
                    ],
                  ),
                ],
              );
            },
          ),
          Container(
            height: deviceAvgScreenSize * 0.0644,
            width: deviceWidth * 0.35,
            margin: EdgeInsetsDirectional.only(top: commonPadding20px),
            decoration: BoxDecoration(
              color: colorBlack,
              borderRadius: BorderRadiusDirectional.circular(borderRadius30px),
            ),
          )
        ],
      ),
    );
  }
}
