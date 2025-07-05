import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constant/colors.dart';
import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_image.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import 'best_seller_dl.dart';

class ItemBestSellerWidget extends StatelessWidget {
  final ItemBestSellerList itemBestSellers;
  const ItemBestSellerWidget({super.key, required this.itemBestSellers});

  @override
  Widget build(BuildContext context) {
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
              padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.008945),
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
                padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.008945),
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
              bottom: deviceAvgScreenSize * 0.021468,
              right: -commonPadding10px * 0.132,
              child: Container(
                padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.008945),
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
  }
}
