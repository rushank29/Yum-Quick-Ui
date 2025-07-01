import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../customWidget/custom_image.dart';
import '../../customWidget/no_record_found.dart';
import '../../main.dart';
import '../../utils/response_util.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import '../../constant/constant.dart';
import 'best_seller_bloc.dart';
import 'best_seller_dl.dart';
import 'best_seller_shimmer.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  BestSellerBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= BestSellerBloc();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: languages.bestSeller,
      bodyWidget: Column(
        children: [
          Text(
            languages.discoverPopularDishes,
            style: bodyText(
              fontSize: textSize20px,
              fontWeight: FontWeight.w500,
              textColor: colorPrimary,
            ),
          ),
          SizedBox(height: commonPadding24px),
          StreamBuilder<ResponseUtil<BestSellerPojo>>(
            stream: _bloc?.subject,
            builder: (context, snapshot) {
              BestSellerPojo? data = snapshot.data?.data;
              switch (snapshot.data?.status ?? Status.loading) {
                case Status.loading:
                  return const BestSellerShimmer();
                case Status.completed:
                  return _bestSellerBody(data);
                case Status.error:
                  return const NoRecordFound();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _bestSellerBody(BestSellerPojo? data) {
    List<ItemBestSellerList> bestSellers = data?.bestSellerList ?? [];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: commonPadding10px,
        mainAxisSpacing: commonPadding10px,
        childAspectRatio: 0.635,
      ),
      itemCount: bestSellers.length,
      itemBuilder: (context, index) {
        ItemBestSellerList itemBestSellers = bestSellers[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                CustomImage(
                  imagePath: itemBestSellers.productImage,
                  width: deviceWidth,
                  height: deviceHeight * 0.2,
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
                  child: getFoodCategoryTypeIcon(itemBestSellers.foodCategoryType),
                ),
                Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: Container(
                    margin: EdgeInsetsDirectional.only(top: commonPadding10px, end: commonPadding10px),
                    padding: EdgeInsetsDirectional.all(commonSize10px * 0.5),
                    decoration: BoxDecoration(
                      color: colorWhite,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      itemBestSellers.isFavorite == 1 ? Icons.favorite : Icons.favorite_border,
                      color: colorPrimary,
                      size: iconSize15px,
                    ),
                  ),
                ),
                Positioned(
                  bottom: commonPadding10px * 1.2,
                  right: -commonPadding10px * 0.132,
                  child: Container(
                    padding: EdgeInsetsDirectional.all(commonPadding10px * 0.5),
                    decoration: BoxDecoration(
                      color: colorPrimary,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(borderRadius30px),
                        bottomStart: Radius.circular(borderRadius30px),
                      ),
                    ),
                    child: Text(
                      getAmountWithCurrency(itemBestSellers.productPrice),
                      style: bodyText(fontSize: textSize12px),
                    ),
                  ),
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
                    itemBestSellers.productName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: bodyText(
                      fontSize: textSize18px,
                      textColor: colorCommonBrown,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.0075),
                  margin: EdgeInsetsDirectional.only(start: deviceWidth * 0.02),
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadiusDirectional.circular(borderRadius30px),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${itemBestSellers.productRating}",
                        style: bodyText(
                          fontSize: textSize12px,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(width: deviceWidth * 0.01),
                      Container(
                        padding: EdgeInsetsDirectional.only(
                          bottom: deviceHeight * 0.005,
                        ),
                        child: SvgPicture.asset(
                          "assets/svg/rating_star_filled.svg",
                          colorFilter: ColorFilter.mode(colorRatingStar, BlendMode.srcIn),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    itemBestSellers.productDescription,
                    maxLines: itemBestSellers.productName.length >= 15 ? 2 : 3,
                    overflow: TextOverflow.ellipsis,
                    style: bodyText(
                      fontSize: textSize12px,
                      textColor: colorCommonBrown,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    selectedDrawerIndexSubject.sink.add(3);
                  },
                  child: commonHomeHeaderIcon("assets/svg/cart.svg", revertBg: true),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
