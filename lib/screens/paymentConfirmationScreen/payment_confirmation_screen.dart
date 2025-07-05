import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../customWidget/common_bg_screen.dart';
import '../cancelOrderScreen/cancelled_confirmed_order_screen.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../customWidget/keyValuePair/item_key_value_pair_dl.dart';
import '../../utils/response_util.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import '../../main.dart';
import '../homeMainV1/drawerCart/cart_data_dl.dart';
import '../paymentMethodsScreen/payment_methods_dl.dart';
import 'payment_confirmation_bloc.dart';

class PaymentConfirmationScreen extends StatefulWidget {
  final String savedDeliveryAddress;
  final BehaviorSubject<ResponseUtil<CartDataPojo>>? subjectCartData;
  final BehaviorSubject<List<ItemKeyValuePair>>? subjectKeyValueList;

  const PaymentConfirmationScreen(
      {super.key,
      required this.savedDeliveryAddress,
      required this.subjectCartData,
      required this.subjectKeyValueList});

  @override
  State<PaymentConfirmationScreen> createState() => _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  PaymentConfirmationBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= PaymentConfirmationBloc(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: languages.payment,
      bodyWidget: StreamBuilder<ResponseUtil<CartDataPojo>>(
        stream: widget.subjectCartData,
        builder: (context, snapCart) {
          List<ItemCartList> cartList = snapCart.data?.data?.cartList ?? [];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _shippingAddressSection(),
              SizedBox(height: commonPadding50px),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    languages.orderSummary,
                    style: bodyText(
                      fontSize: textSize20px,
                      fontWeight: FontWeight.w500,
                      textColor: colorCommonBrown,
                    ),
                  ),
                  _commonEditBtn(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(height: commonPadding16px),
              Row(
                children: [
                  Flexible(
                    child: _cartListView(cartList),
                  ),
                  _cartTotal(),
                ],
              ),
              SizedBox(height: commonPadding16px),
              Divider(color: colorPrimaryLight),
              SizedBox(height: commonPadding16px),
              _paymentMethodWidget(),
              SizedBox(height: commonPadding16px),
              Divider(color: colorPrimaryLight),
              SizedBox(height: commonPadding16px),
              _deliveryTimeWidget(snapCart.data?.data?.estimatedDelivery ?? ""),
              SizedBox(height: commonPadding16px),
              Divider(color: colorPrimaryLight),
              _actionButton(snapCart.data?.data?.estimatedDelivery ?? ""),
            ],
          );
        },
      ),
    );
  }

  Widget _commonEditBtn({required void Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: commonPadding16px,
          vertical: commonPadding10px * 0.8,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.circular(borderRadius10px), color: colorPrimaryLight),
        child: Text(
          languages.edit,
          style: bodyText(
            textColor: colorPrimary,
            fontSize: textSize12px,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _shippingAddressSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          languages.shippingAddress,
          style: bodyText(
            fontWeight: FontWeight.w700,
            fontSize: textSize24px,
            textColor: colorCommonBrown,
          ),
        ),
        Container(
          width: double.maxFinite,
          padding: EdgeInsetsDirectional.all(commonPadding10px),
          decoration: BoxDecoration(
            color: colorPeach,
            borderRadius: BorderRadiusDirectional.circular(borderRadius20px),
          ),
          child: Text(
            widget.savedDeliveryAddress,
            style: bodyText(fontSize: textSize16px, textColor: colorCommonBrown),
          ),
        )
      ],
    );
  }

  Widget _cartListView(List<ItemCartList> cartList) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cartList.length,
      padding: EdgeInsetsDirectional.zero,
      itemBuilder: (context, index) {
        ItemCartList cartItem = cartList[index];
        return Row(
          children: [
            Text(
              cartItem.cartItemName,
              style: bodyText(
                fontSize: textSize14px,
                fontWeight: FontWeight.w300,
                textColor: colorCommonBrown,
              ),
            ),
            SizedBox(width: commonPadding16px),
            Text(
              "${cartItem.itemQuantity} ${languages.items}",
              style: bodyText(
                fontSize: textSize14px,
                fontWeight: FontWeight.w300,
                textColor: colorPrimary,
              ),
            )
          ],
        );
      },
    );
  }

  Widget _cartTotal() {
    return StreamBuilder<List<ItemKeyValuePair>>(
      stream: widget.subjectKeyValueList,
      builder: (context, snapKeyValueList) {
        return Text(
          getAmountWithCurrency(snapKeyValueList.data?.last.value ?? 0),
          style: bodyText(
            fontSize: textSize20px,
            fontWeight: FontWeight.w500,
            textColor: colorCommonBrown,
          ),
        );
      },
    );
  }

  Widget _deliveryTimeWidget(String estimatedDeliveryTime) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          languages.deliveryTime,
          style: bodyText(
            fontWeight: FontWeight.w500,
            fontSize: textSize20px,
            textColor: colorCommonBrown,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              languages.estimatedDelivery,
              style: bodyText(
                fontWeight: FontWeight.w300,
                textColor: colorCommonBrown,
              ),
            ),
            Text(
              estimatedDeliveryTime,
              style: bodyText(
                fontWeight: FontWeight.w500,
                fontSize: textSize20px,
                textColor: colorPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _paymentMethodWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              languages.paymentMethods,
              style: bodyText(
                fontWeight: FontWeight.w500,
                fontSize: textSize20px,
                textColor: colorCommonBrown,
              ),
            ),
            _commonEditBtn(
              onTap: () {
                _bloc?.changePaymentMethod();
              },
            )
          ],
        ),
        StreamBuilder<ItemPaymentMethodsList?>(
          stream: _bloc?.savedPaymentMethodSubject,
          builder: (context, snapSavedPaymentType) {
            int paymentType = snapSavedPaymentType.data?.paymentType ?? 0;
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: commonSize45px,
                      alignment: AlignmentDirectional.center,
                      child: getPaymentMethodIcon(paymentType),
                    ),
                    Text(
                      getPaymentMethodName(paymentType),
                      style: bodyText(fontSize: textSize16px, textColor: colorCommonBrown),
                    ),
                  ],
                ),
                paymentType == 1
                    ? Text(
                        getPaymentMethodName(
                          paymentType,
                          cardNumber: snapSavedPaymentType.data?.cardNumber ?? "",
                        ),
                        style: bodyText(fontSize: textSize16px, textColor: colorCommonBrown),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        )
      ],
    );
  }

  Widget _actionButton(String estimatedDeliveryTime) {
    return Center(
      child: CustomRoundedButton(
        buttonText: languages.payNow,
        onPressed: () {
          openScreen(
            context: context,
            screen: CancelledOrConfirmedOrderScreen(
              isForPaymentConfirmation: true,
              eta: estimatedDeliveryTime,
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
    );
  }
}
