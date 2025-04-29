import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class CancelOrderShimmer extends StatelessWidget {
  const CancelOrderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
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
                      Container(
                        height: commonSize45px * 0.5,
                        width: (position == 5) ? deviceWidth * 0.3 : deviceWidth * 0.5,
                        margin: (position == 5)
                            ? EdgeInsetsDirectional.symmetric(vertical: commonPadding10px * 0.75)
                            : null,
                        color: colorBlack,
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
                  if (position == 5) ...[
                    Container(
                      height: commonSize120px * 0.75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(borderRadius20px),
                        color: colorBlack,
                      ),
                    )
                  ]
                ],
              );
            },
          ),
          Container(
            height: deviceAvgScreenSize * 0.0644,
            width: deviceWidth* 0.35,
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
