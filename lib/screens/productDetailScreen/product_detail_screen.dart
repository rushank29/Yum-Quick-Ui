import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/main.dart';

import '../../constant/colors.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_image.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import '../dishesScreen/dishes_dl.dart';
import 'product_detail_bloc.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductItem productItem;

  const ProductDetailScreen({super.key, required this.productItem});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with SingleTickerProviderStateMixin {
  late ProductItem item;
  ProductDetailBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= ProductDetailBloc();
    item = widget.productItem;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  item.dishName,
                  textAlign: TextAlign.center,
                  style: bodyText(
                    fontWeight: FontWeight.w500,
                    fontSize: textSize20px,
                    textColor: colorCommonBrown,
                  ),
                ),
              ),
              SizedBox(width: deviceWidth * 0.01),
              Container(
                height: deviceAvgScreenSize * 0.005,
                width: deviceAvgScreenSize * 0.005,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorPrimary,
                ),
              ),
              SizedBox(width: deviceWidth * 0.01),
            ],
          ),
          Container(
            padding: EdgeInsetsDirectional.all(commonSize10px * 0.5),
            decoration: BoxDecoration(
              color: colorPrimary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              item.isFavorite == 1 ? Icons.favorite : Icons.favorite_border,
              color: colorWhite,
              size: deviceAvgScreenSize * 0.02,
            ),
          )
        ],
      ),
      bodyWidget: Padding(
        padding: EdgeInsetsDirectional.symmetric(horizontal: commonPadding10px),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(
              imagePath: item.dishImage,
              width: deviceWidth,
              height: deviceHeight * 0.3,
              borderRadius: BorderRadius.circular(borderRadius36px),
              fit: BoxFit.fill,
            ),
            Divider(color: colorPrimaryLight),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      getAmountWithCurrency(item.dishPrice),
                      style: bodyText(
                        fontSize: textSize24px,
                        fontWeight: FontWeight.w700,
                        textColor: colorPrimary,
                      ),
                    ),
                    if (item.dishFullPrice > 0) ...[
                      SizedBox(width: deviceWidth * 0.01),
                      Text(
                        getAmountWithCurrency(item.dishFullPrice),
                        style: bodyText(
                          fontSize: textSize15px,
                          fontWeight: FontWeight.w700,
                          textColor: colorCommonBackground,
                        ).copyWith(decoration: TextDecoration.lineThrough, decorationColor: colorPrimary),
                      )
                    ],
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        CupertinoIcons.minus_circle_fill,
                        color: colorPrimary,
                        size: iconSize24px,
                      ),
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.symmetric(
                        horizontal: commonPadding10px * 0.5,
                      ),
                      child: Text(
                        languages.one,
                        style: bodyText(fontSize: textSize24px, textColor: colorCommonBrown),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        CupertinoIcons.add_circled_solid,
                        color: colorPrimary,
                        size: iconSize24px,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Divider(color: colorPrimaryLight),
            SizedBox(height: commonPadding10px),
            Text(
              item.shortDescription,
              style: bodyText(fontSize: textSize16px, textColor: colorCommonBrown),
            ),
            Text(
              item.fullDescription,
              style: bodyText(
                fontSize: textSize12px,
                textColor: colorCommonBrown,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: commonPadding28px),
            Text(
              languages.addOnIngredients,
              style: bodyText(
                fontSize: textSize20px,
                textColor: colorCommonBrown,
                fontWeight: FontWeight.w500,
              ),
            ),
            ListView.builder(
              itemCount: item.toppingList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsetsDirectional.zero,
              itemBuilder: (context, index) {
                ItemToppingList itemToppingList = item.toppingList[index];
                return StreamBuilder<ItemToppingList?>(
                  stream: _bloc?.selectedToppingSubject,
                  builder: (context, snapSelectedTopping) {
                    return InkWell(
                      onTap: () {
                        _bloc?.selectedToppingSubject.sink.add(itemToppingList);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemToppingList.name,
                            style: bodyText(
                              fontSize: textSize14px,
                              fontWeight: FontWeight.w300,
                              textColor: colorCommonBrown,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsetsDirectional.symmetric(horizontal: deviceWidth * 0.0175),
                              child: DottedLine(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.center,
                                lineLength: double.infinity,
                                lineThickness: 1.0,
                                dashLength: deviceWidth * 0.015,
                                dashColor: colorPrimaryLight,
                                dashRadius: 0.0,
                                dashGapLength: deviceWidth * 0.01,
                                dashGapColor: Colors.transparent,
                                dashGapRadius: 0.0,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                getAmountWithCurrency(itemToppingList.price),
                                style: bodyText(
                                  fontSize: textSize12px,
                                  fontWeight: FontWeight.w300,
                                  textColor: colorCommonBrown,
                                ),
                              ),
                              Radio<ItemToppingList?>(
                                value: itemToppingList,
                                groupValue: snapSelectedTopping.data,
                                visualDensity: VisualDensity.compact,
                                onChanged: (value) {
                                  _bloc?.selectedToppingSubject.sink.add(value);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: CustomRoundedButton(
                buttonText: languages.addToCart,
                widget: Padding(
                  padding: EdgeInsetsDirectional.only(end: commonPadding10px),
                  child: SvgPicture.asset(
                    "assets/svg/bag.svg",
                    width: iconSize20px,
                    height: iconSize20px,
                    colorFilter: ColorFilter.mode(
                      colorWhite,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                onPressed: () {},
                minBtnHeight: 0.05,
                minBtnWidth: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
