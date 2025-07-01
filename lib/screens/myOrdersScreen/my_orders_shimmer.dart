import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:shimmer/shimmer.dart';

class MyOrdersShimmer extends StatelessWidget {
  const MyOrdersShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsetsDirectional.zero,
        separatorBuilder: (_, __) => Divider(color: colorBlack),
        itemBuilder: (context, index) {
          return Column(
            children: [
              if (index == 0) Divider(color: colorBlack),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: deviceHeight * 0.15,
                    width: deviceWidth * 0.2,
                    decoration: BoxDecoration(
                      color: colorBlack,
                      borderRadius: BorderRadiusDirectional.all(Radius.circular(borderRadius30px)),
                    ),
                  ),
                  SizedBox(width: commonPadding10px),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: deviceAvgScreenSize * 0.0268425,
                                color: colorBlack,
                                width: double.infinity,
                              ),
                            ),
                            SizedBox(width: commonPadding20px),
                            Expanded(
                              child: Container(
                                height: deviceAvgScreenSize * 0.0268425,
                                color: colorBlack,
                                width: double.infinity,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: commonPadding10px * 0.4),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  height: commonPadding10px * 1.4, color: colorBlack, width: double.infinity),
                            ),
                            SizedBox(width: commonPadding20px),
                            Expanded(
                              child: Container(
                                  height: commonPadding10px * 1.4, color: colorBlack, width: double.infinity),
                            ),
                          ],
                        ),
                        SizedBox(height: commonPadding10px * 0.4),
                        Container(
                          height: commonPadding10px * 1.4,
                          color: colorBlack,
                          width: deviceAvgScreenSize * 0.10737,
                        ),
                        SizedBox(height: commonPadding10px * 0.8),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: commonSize50px * 0.6,
                                decoration: BoxDecoration(
                                  color: colorBlack,
                                  borderRadius: BorderRadiusDirectional.circular(borderRadius20px),
                                ),
                              ),
                            ),
                            SizedBox(width: commonPadding10px),
                            Expanded(
                              child: Container(
                                height: commonSize50px * 0.6,
                                decoration: BoxDecoration(
                                  color: colorBlack,
                                  borderRadius: BorderRadiusDirectional.circular(borderRadius20px),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (index == 3) Divider(color: Colors.grey.shade300),
            ],
          );
        },
      ),
    );
  }
}
