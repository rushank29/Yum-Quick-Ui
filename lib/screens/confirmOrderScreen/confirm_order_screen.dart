import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/screens/paymentConfirmationScreen/payment_confirmation_screen.dart';
import 'package:rxdart/rxdart.dart';
import '../../customWidget/custom_image.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../customWidget/keyValuePair/item_key_value_list.dart';
import '../../customWidget/keyValuePair/item_key_value_pair_dl.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';
import '../deliveryAddressScreen/delivery_address_dl.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../utils/text_style.dart';
import '../homeMainV1/drawerCart/cart_data_dl.dart';
import 'confirm_order_bloc.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final BehaviorSubject<ResponseUtil<CartDataPojo>>? subjectCartData;
  final BehaviorSubject<List<ItemKeyValuePair>>? subjectKeyValueList;

  const ConfirmOrderScreen({super.key, required this.subjectCartData, required this.subjectKeyValueList});

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  ConfirmOrderBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= ConfirmOrderBloc(context, widget.subjectCartData, widget.subjectKeyValueList);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "Confirm Order",
      bodyWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Shipping Address",
                style: bodyText(
                  fontWeight: FontWeight.w700,
                  fontSize: textSize24px,
                  textColor: colorCommonBrown,
                ),
              ),
              SizedBox(width: commonPadding10px),
              GestureDetector(
                onTap: () {
                  _bloc?.changeDeliveryAddress();
                },
                child: SvgPicture.asset(
                  "assets/svg/edit_pen_icon.svg",
                  height: iconSize15px,
                  width: iconSize15px,
                ),
              ),
            ],
          ),
          Container(
            width: double.maxFinite,
            padding: EdgeInsetsDirectional.all(commonPadding10px),
            decoration: BoxDecoration(
              color: colorPeach,
              borderRadius: BorderRadiusDirectional.circular(borderRadius20px),
            ),
            child: StreamBuilder<ItemDeliveryAddressList?>(
              stream: _bloc?.savedAddressSubject,
              builder: (context, snapSavedAddress) {
                return Text(
                  snapSavedAddress.data?.addressDescription ?? "",
                  style: bodyText(fontSize: textSize16px, textColor: colorCommonBrown),
                );
              },
            ),
          ),
          SizedBox(height: commonPadding50px),
          Text(
            "Order Summary",
            style: bodyText(
              fontSize: textSize20px,
              fontWeight: FontWeight.w500,
              textColor: colorCommonBrown,
            ),
          ),
          SizedBox(height: commonPadding16px),
          Divider(color: colorDividerOrange),
          StreamBuilder<ResponseUtil<CartDataPojo>>(
            stream: widget.subjectCartData,
            builder: (context, snapCartData) {
              List<ItemCartList> cartList = snapCartData.data?.data?.cartList ?? [];
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsetsDirectional.only(top: commonPadding10px),
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
                              height: deviceAvgScreenSize * 0.1932,
                              width: deviceAvgScreenSize * 0.1288,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsetsDirectional.only(end: commonPadding10px * 0.75),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItem.cartItemName,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: bodyText(
                                            fontWeight: FontWeight.w500,
                                            fontSize: textSize20px,
                                            textColor: colorCommonBrown,
                                          ),
                                        ),
                                        Text(
                                          getFormattedDateTime(
                                            inputDateTime:
                                                "${cartItem.itemAddingDate} ${cartItem.itemAddingTime}",
                                            format: "dd-MM-yyyy hh:mm",
                                            returnFormat: "dd MMM, hh:mm a",
                                          ),
                                          style: bodyText(
                                            fontWeight: FontWeight.w300,
                                            fontSize: textSize14px,
                                            textColor: colorCommonBrown,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      getAmountWithCurrency(cartItem.itemPrice * cartItem.itemQuantity),
                                      style: bodyText(
                                        fontWeight: FontWeight.w500,
                                        fontSize: textSize20px,
                                        textColor: colorPrimary,
                                      ),
                                    ),
                                    Text(
                                      "${cartItem.itemQuantity} items",
                                      style: bodyText(
                                        fontWeight: FontWeight.w300,
                                        textColor: colorCommonBrown,
                                      ),
                                    ),
                                    SizedBox(height: commonPadding10px * 0.6), // optional spacing
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () => _bloc!.updateCartItemQuantity(cartItem, false),
                                          child: Icon(
                                            CupertinoIcons.minus_circle_fill,
                                            color:
                                                cartItem.itemQuantity == 1 ? colorPrimaryLight : colorPrimary,
                                            size: iconSize20px,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: commonPadding10px * 0.5),
                                          child: Text(
                                            "${cartItem.itemQuantity}",
                                            style: bodyText(
                                              fontSize: textSize18px,
                                              textColor: colorCommonBrown,
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => _bloc!.updateCartItemQuantity(cartItem, true),
                                          child: Icon(
                                            CupertinoIcons.add_circled_solid,
                                            color: colorPrimary,
                                            size: iconSize20px,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsetsDirectional.symmetric(vertical: commonPadding10px),
                        child: Divider(color: colorPrimaryLight),
                      ),
                    ],
                  );
                },
              );
            },
          ),
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
                  return ItemKeyValueList(
                    itemKeyValue: itemKeyValue,
                    fontStyle: bodyText(
                      fontSize: textSize20px,
                      fontWeight: FontWeight.w500,
                      textColor: colorCommonBrown,
                    ),
                    dividerColor: colorPrimaryLight,
                  );
                },
              );
            },
          ),
          Center(
            child: CustomRoundedButton(
              buttonText: "Place Order",
              onPressed: () {
                openScreen(
                  context: context,
                  screen: PaymentConfirmationScreen(
                    savedDeliveryAddress: _bloc?.savedAddressSubject.valueOrNull?.addressDescription ?? "",
                    subjectCartData: widget.subjectCartData,
                    subjectKeyValueList: widget.subjectKeyValueList,
                  ),
                );
              },
              fontSize: textSize20px,
              fontWeight: FontWeight.w400,
              backgroundColor: colorPrimaryLight,
              textColor: colorPrimary,
              borderColor: colorPrimaryLight,
              margin: EdgeInsetsDirectional.only(top: commonPadding32px),
              padding: EdgeInsetsDirectional.only(
                start: commonPadding10px,
                end: commonPadding10px,
                top: commonPadding10px,
                bottom: commonPadding10px,
              ),
            ),
          )
        ],
      ),
    );
  }
}
