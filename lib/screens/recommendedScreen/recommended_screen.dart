import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/constant/constant.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/custom_image.dart';
import 'package:food_ui/customWidget/no_record_found.dart';
import 'package:food_ui/screens/bestSeller/best_seller_shimmer.dart';
import 'package:food_ui/screens/recommendedScreen/recommended_bloc.dart';
import 'package:food_ui/screens/recommendedScreen/recommended_dl.dart';
import 'package:food_ui/utils/utils.dart';

import '../../constant/colors.dart';
import '../../utils/text_style.dart';

class RecommendedScreen extends StatefulWidget {
  const RecommendedScreen({super.key});

  @override
  State<RecommendedScreen> createState() => _RecommendedScreenState();
}

class _RecommendedScreenState extends State<RecommendedScreen> {
  RecommendedBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= RecommendedBloc();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "Recommendations",
      bodyWidget: Column(
        children: [
          Text(
            "Discover the dishes recommended by the chef.",
            textAlign: TextAlign.center,
            style: bodyText(
              fontWeight: FontWeight.w500,
              textColor: colorPrimary,
              fontSize: textSize20px,
            ),
          ),
          StreamBuilder(
            stream: _bloc?.subject,
            builder: (context, snapshot) {
              switch (snapshot.data?.status ?? Status.loading) {
                case Status.loading:
                  return const BestSellerShimmer();
                case Status.completed:
                  RecommendedPojo? data = snapshot.data?.data;
                  return _recommendedData(data);
                case Status.error:
                  return const NoRecordFound();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _recommendedData(RecommendedPojo? data) {
    List<ItemRecommendedList> recommendedList = data?.recommendedList ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomImage(
                  imagePath: recommendedList.first.productImage,
                  height: deviceAvgScreenSize * 0.2375,
                  width: deviceAvgScreenSize * 0.2375,
                  fit: BoxFit.cover,
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: commonPadding10px, start: commonPadding10px),
                  padding: EdgeInsetsDirectional.all(commonSize10px * 0.5),
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadiusDirectional.circular(borderRadius10px),
                  ),
                  child: getFoodCategoryTypeIcon(recommendedList.first.foodCategoryType),
                ),
              ],
            ),
            SizedBox(width: commonPadding10px),
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset("assets/svg/container_trapezium.svg"),
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: commonPadding10px, top: deviceHeight * 0.003),
                        child: Text(
                          "New Product",
                          textAlign: TextAlign.center,
                          style: bodyText(
                            fontWeight: FontWeight.w500,
                            fontSize: textSize16px,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      recommendedList.first.productName,
                      style: bodyText(
                        fontWeight: FontWeight.w500,
                        fontSize: textSize16px,
                        textColor: colorCommonBrown,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      recommendedList.first.productDescription,
                      style: bodyText(
                        fontWeight: FontWeight.w300,
                        fontSize: textSize12px,
                        textColor: colorCommonBrown,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        getAmountWithCurrency(recommendedList.first.productPrice),
                        textAlign: TextAlign.center,
                        style: bodyText(
                          fontWeight: FontWeight.w500,
                          fontSize: textSize20px,
                          textColor: colorPrimary,
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              CupertinoIcons.minus_circle_fill,
                              color: recommendedList.first.productQuantity == 1
                                  ? colorPrimaryLight
                                  : colorPrimary,
                              size: iconSize15px,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.symmetric(
                              horizontal: commonPadding10px * 0.5,
                            ),
                            child: Text(
                              "${recommendedList.first.productQuantity}",
                              style: bodyText(fontSize: textSize15px, textColor: colorCommonBrown),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Icon(
                              CupertinoIcons.add_circled_solid,
                              color: colorPrimary,
                              size: iconSize15px,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              selectedDrawerIndexSubject.sink.add(3);
                            },
                            child: Container(
                              margin: EdgeInsetsDirectional.only(start: commonPadding10px * 0.7),
                              padding: EdgeInsetsDirectional.all(commonPadding10px * 0.5),
                              decoration: BoxDecoration(
                                color: colorPrimary,
                                borderRadius: BorderRadiusDirectional.all(Radius.circular(borderRadius10px)),
                              ),
                              child: SvgPicture.asset(
                                "assets/svg/cart.svg",
                                height: iconSize15px,
                                width: iconSize15px,
                                colorFilter: ColorFilter.mode(colorWhite, BlendMode.srcIn),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: commonPadding24px),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsetsDirectional.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: commonPadding10px,
            mainAxisSpacing: commonPadding10px,
            childAspectRatio: 0.635,
          ),
          itemCount: recommendedList.length-1,
          itemBuilder: (context, index) {
            ItemRecommendedList itemRecommendedList = recommendedList[index+1];
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    CustomImage(
                      imagePath: itemRecommendedList.productImage,
                      height: deviceAvgScreenSize * 0.2375,
                      width: deviceWidth,
                      borderRadius: BorderRadius.circular(borderRadius20px),
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(top: commonPadding10px, start: commonPadding10px),
                      padding: EdgeInsetsDirectional.all(commonSize10px * 0.5),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadiusDirectional.circular(borderRadius10px),
                      ),
                      child: getFoodCategoryTypeIcon(itemRecommendedList.foodCategoryType),
                    ),
                  ],
                ),
                SizedBox(height: commonPadding10px),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        itemRecommendedList.productName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: bodyText(
                          fontSize: textSize18px,
                          textColor: colorCommonBrown,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        itemRecommendedList.productDescription,
                        maxLines: itemRecommendedList.productName.length >= 15 ? 2 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: bodyText(
                          fontSize: textSize12px,
                          textColor: colorCommonBrown,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      getAmountWithCurrency(itemRecommendedList.productPrice),
                      textAlign: TextAlign.center,
                      style: bodyText(
                        fontWeight: FontWeight.w500,
                        fontSize: textSize20px,
                        textColor: colorPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            CupertinoIcons.minus_circle_fill,
                            color: recommendedList.first.productQuantity == 1
                                ? colorPrimaryLight
                                : colorPrimary,
                            size: iconSize15px,
                          ),
                        ),
                        Container(
                          margin: EdgeInsetsDirectional.symmetric(
                            horizontal: commonPadding10px * 0.5,
                          ),
                          child: Text(
                            "${recommendedList.first.productQuantity}",
                            style: bodyText(fontSize: textSize15px, textColor: colorCommonBrown),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Icon(
                            CupertinoIcons.add_circled_solid,
                            color: colorPrimary,
                            size: iconSize15px,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            selectedDrawerIndexSubject.sink.add(3);
                          },
                          child: Container(
                            margin: EdgeInsetsDirectional.only(start: commonPadding10px * 0.7),
                            padding: EdgeInsetsDirectional.all(commonPadding10px * 0.5),
                            decoration: BoxDecoration(
                              color: colorPrimary,
                              borderRadius: BorderRadiusDirectional.all(Radius.circular(borderRadius10px)),
                            ),
                            child: SvgPicture.asset(
                              "assets/svg/cart.svg",
                              height: iconSize15px,
                              width: iconSize15px,
                              colorFilter: ColorFilter.mode(colorWhite, BlendMode.srcIn),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
