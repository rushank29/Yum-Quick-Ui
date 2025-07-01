import 'package:flutter/material.dart';

import '../../customWidget/custom_image.dart';
import '../../main.dart';
import '../../constant/colors.dart';
import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../customWidget/keyValuePair/item_key_value_list.dart';
import '../../customWidget/keyValuePair/item_key_value_pair_dl.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import '../cancelOrderScreen/cancel_order_screen.dart';
import '../orderHistory/order_history_list_dl.dart';
import 'order_details_bloc.dart';

class OrderDetailsScreen extends StatefulWidget {
  final ItemOrderList item;

  const OrderDetailsScreen({super.key, required this.item});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  OrderDetailsBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= OrderDetailsBloc(widget.item);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: languages.orderDetails,
      bodyWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${languages.orderNo} ${widget.item.orderNo}",
            style: bodyText(
              fontWeight: FontWeight.w500,
              fontSize: textSize20px,
              textColor: colorCommonBrown,
            ),
          ),
          Text(
            getFormattedDateTime(inputDateTime: widget.item.orderDateTime, format: "dd-MM-yyyy hh:mm"),
            style: bodyText(
              fontWeight: FontWeight.w300,
              fontSize: textSize14px,
              textColor: colorCommonBrown,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: commonPadding10px, bottom: commonPadding10px),
            child: Divider(color: colorPrimaryLight),
          ),
          ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsetsDirectional.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.item.orderItems.length,
            itemBuilder: (context, index) {
              OrderItems orderItem = widget.item.orderItems[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CustomImage(
                          imagePath: orderItem.productImage,
                          height: commonSize80px,
                          width: commonSize80px,
                          fit: BoxFit.cover,
                          borderRadius: BorderRadius.circular(borderRadius20px),
                        ),
                        Flexible(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(start: commonPadding10px),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Text(
                                    orderItem.productName,
                                    style: bodyText(
                                      fontWeight: FontWeight.w500,
                                      fontSize: textSize15px,
                                      textColor: colorCommonBrown,
                                    ),
                                  ),
                                ),
                                Text(
                                  getAmountWithCurrency(orderItem.productPrice),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: commonPadding10px),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          getFormattedDateTime(
                            inputDateTime: orderItem.productAddedTime,
                            format: "dd-MM-yyyy hh:mm",
                            returnFormat: "dd/MM/yyyy",
                          ),
                          style: bodyText(
                            fontWeight: FontWeight.w500,
                            fontSize: textSize13px,
                            textColor: colorCommonBrown,
                          ),
                        ),
                        Text(
                          getFormattedDateTime(
                            inputDateTime: orderItem.productAddedTime,
                            format: "dd-MM-yyyy hh:mm",
                            returnFormat: "HH:mm",
                          ),
                          style: bodyText(
                            fontWeight: FontWeight.w500,
                            fontSize: textSize13px,
                            textColor: colorCommonBrown,
                          ),
                        ),
                        Text(
                          "${orderItem.productQuantity} ${languages.items}",
                          style: bodyText(
                            fontWeight: FontWeight.w400,
                            fontSize: textSize13px,
                            textColor: colorCommonBrown,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) {
              return Padding(
                padding: EdgeInsetsDirectional.symmetric(vertical: commonPadding10px),
                child: Divider(color: colorPrimaryLight),
              );
            },
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(top: commonPadding10px, bottom: commonPadding28px),
            child: Divider(color: colorPrimaryLight),
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
          if (widget.item.orderStatus == 3 || widget.item.orderStatus == 1)
            Center(
              child: CustomRoundedButton(
                buttonText: (widget.item.orderStatus == 3) ? languages.orderAgain : languages.cancelOrder,
                onPressed: () {
                  if (widget.item.orderStatus == 3) {
                    selectedDrawerIndexSubject.sink.add(3);
                  } else {
                    openScreen(context: context, screen: const CancelOrderScreen());
                  }
                },
                fontSize: textSize20px,
                fontWeight: FontWeight.w400,
                backgroundColor: colorPrimaryLight,
                textColor: colorPrimary,
                borderColor: colorPrimaryLight,
                margin: EdgeInsetsDirectional.only(top: commonPadding50px),
                padding: EdgeInsetsDirectional.only(
                  start: commonPadding10px,
                  end: commonPadding10px,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
