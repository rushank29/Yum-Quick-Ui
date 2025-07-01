import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../customWidget/custom_image.dart';
import '../../../customWidget/custom_rounded_button.dart';
import '../../../customWidget/keyValuePair/item_key_value_list.dart';
import '../../../customWidget/keyValuePair/item_key_value_pair_dl.dart';
import '../../../main.dart';
import '../../confirmOrderScreen/confirm_order_screen.dart';
import 'cart_data_dl.dart';
import 'drawer_cart_bloc.dart';
import '../../../utils/response_util.dart';
import '../../../utils/text_style.dart';
import '../../../utils/utils.dart';

class DrawerCartScreen extends StatefulWidget {
  const DrawerCartScreen({super.key});

  @override
  State<DrawerCartScreen> createState() => _DrawerCartScreenState();
}

class _DrawerCartScreenState extends State<DrawerCartScreen> {
  DrawerCartBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= DrawerCartBloc(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResponseUtil<CartDataPojo>>(
      stream: _bloc?.subjectCartData,
      builder: (context, snapCartData) {
        List<ItemCartList> cartList = snapCartData.data?.data?.cartList ?? [];
        return cartList.isEmpty ? _emptyCart() : _cart(cartList);
      },
    );
  }

  Widget _emptyCart() {
    return Column(
      children: [
        SizedBox(height: commonPadding10px),
        Text(
          languages.emptyCartMsg,
          style: bodyText(fontSize: textSize20px, fontWeight: FontWeight.w500),
        ),
        Column(
          children: [
            SizedBox(height: deviceHeight * 0.22),
            Container(
              padding: EdgeInsetsDirectional.all(commonPadding20px),
              margin: EdgeInsetsDirectional.only(bottom: deviceHeight * 0.02),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: colorTextCommon),
              ),
              child: Icon(
                CupertinoIcons.add,
                size: commonSize45px,
                color: colorTextCommon,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: deviceAvgScreenSize * 0.009),
              child: Text(
                languages.addSomething,
                textAlign: TextAlign.center,
                style: bodyText(
                  fontSize: textSize24px,
                  fontWeight: FontWeight.w700,
                  textColor: colorWhite,
                ),
              ),
            ),
            SizedBox(height: deviceHeight * 0.22),
          ],
        ),
      ],
    );
  }

  Widget _cart(List<ItemCartList> cartList) {
    return Column(
      children: [
        SizedBox(height: commonPadding10px),
        Text(
          languages.noOfItemsInCart(cartList.length),
          style: bodyText(fontSize: textSize20px, fontWeight: FontWeight.w500),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: cartList.length,
          itemBuilder: (context, index) {
            ItemCartList cartItem = cartList[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsetsDirectional.only(end: commonPadding10px),
                      child: CustomImage(
                        imagePath: cartItem.cartItemImage,
                        height: commonSize80px,
                        width: commonSize80px,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              margin: EdgeInsetsDirectional.only(end: commonPadding10px * 0.75),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem.cartItemName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: bodyText(fontWeight: FontWeight.w500, fontSize: textSize15px),
                                  ),
                                  Text(
                                    getAmountWithCurrency(cartItem.itemPrice * cartItem.itemQuantity),
                                    style: bodyText(fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                getFormattedDateTime(
                                  inputDateTime: cartItem.itemAddingDate,
                                  format: "dd-MM-yyyy",
                                  returnFormat: "dd/MM/yy",
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: bodyText(fontWeight: FontWeight.w500, fontSize: textSize13px),
                              ),
                              Text(
                                cartItem.itemAddingTime,
                                style: bodyText(fontWeight: FontWeight.w500, fontSize: textSize13px),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _bloc!.updateCartItemQuantity(cartItem, false);
                                    },
                                    child: Icon(
                                      CupertinoIcons.minus_circle_fill,
                                      color: colorTextCommon,
                                      size: iconSize15px,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsetsDirectional.symmetric(
                                      horizontal: commonPadding10px * 0.5,
                                    ),
                                    child: Text(
                                      "${cartItem.itemQuantity}",
                                      style: bodyText(fontSize: textSize13px),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _bloc!.updateCartItemQuantity(cartItem, true);
                                    },
                                    child: Icon(
                                      CupertinoIcons.add_circled_solid,
                                      color: colorTextCommon,
                                      size: iconSize15px,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsetsDirectional.symmetric(vertical: commonPadding10px),
                  child: Divider(color: colorTextCommon),
                ),
              ],
            );
          },
        ),
        SizedBox(height: commonPadding32px),
        StreamBuilder<List<ItemKeyValuePair>>(
          stream: _bloc?.subjectKeyValueList,
          builder: (context, snapKeyValueList) {
            List<ItemKeyValuePair> keyValueList = snapKeyValueList.data ?? [];
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: keyValueList.length,
              padding: EdgeInsetsDirectional.zero,
              itemBuilder: (context, index) {
                ItemKeyValuePair itemKeyValue = keyValueList[index];
                return ItemKeyValueList(itemKeyValue: itemKeyValue);
              },
            );
          },
        ),
        CustomRoundedButton(
          buttonText: languages.checkOut,
          onPressed: () {
            openScreen(
              context: context,
              screen: ConfirmOrderScreen(
                subjectCartData: _bloc?.subjectCartData,
                subjectKeyValueList: _bloc?.subjectKeyValueList,
              ),
            );
          },
          fontSize: textSize24px,
          backgroundColor: colorPeach,
          textColor: colorPrimary,
          margin: EdgeInsetsDirectional.symmetric(vertical: commonPadding35px),
          padding: EdgeInsetsDirectional.only(
            start: commonPadding10px,
            end: commonPadding10px,
          ),
        )
      ],
    );
  }
}
