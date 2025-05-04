import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';

class DeliveryAddressShimmer extends StatelessWidget {
  const DeliveryAddressShimmer({super.key});

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
                      Row(
                        children: [
                          Container(
                            height: commonSize45px,
                            width: commonSize45px,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.circular(borderRadius20px),
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
                              Container(
                                height: commonSize45px * 0.35,
                                width: deviceWidth * 0.5,
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
