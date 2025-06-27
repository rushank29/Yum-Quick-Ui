import 'package:flutter/material.dart';
import 'package:food_ui/screens/orderDetailsScreen/order_details_screen.dart';
import 'package:food_ui/screens/orderHistory/order_history_shimmer.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/no_record_found.dart';
import '../../utils/text_style.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../constant/constant.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../utils/utils.dart';
import 'order_history_list_dl.dart';
import 'order_history_bloc.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  OrderHistoryBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= OrderHistoryBloc();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "Order History",
      showBackButton: false,
      bodyWidget: Column(
        children: [
          StreamBuilder(
            stream: _bloc?.subject,
            builder: (context, snapshot) {
              switch (snapshot.data?.status ?? Status.loading) {
                case Status.loading:
                  return const OrderHistoryShimmer();
                case Status.completed:
                  OrderHistoryPojo? data = snapshot.data?.data;
                  return _orderHistoryList(data);
                case Status.error:
                  return const NoRecordFound();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _orderHistoryList(OrderHistoryPojo? data) {
    List<ItemOrderList> orderHistory = data?.orderHistory ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsetsDirectional.zero,
          itemCount: orderHistory.length,
          itemBuilder: (context, index) {
            ItemOrderList itemOrderList = orderHistory[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(vertical: commonPadding24px),
                  child: Divider(color: colorPrimaryLight),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Order No. ${itemOrderList.orderNo}",
                          style: bodyText(
                            fontWeight: FontWeight.w500,
                            fontSize: textSize20px,
                            textColor: colorCommonBrown,
                          ),
                        ),
                        Text(
                          getFormattedDateTime(
                              inputDateTime: itemOrderList.orderDateTime, format: "dd-MM-yyyy hh:mm"),
                          style: bodyText(
                            fontWeight: FontWeight.w300,
                            fontSize: textSize14px,
                            textColor: colorCommonBrown,
                          ),
                        ),
                        getOrderStatusWidget(itemOrderList.orderStatus),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          getAmountWithCurrency(itemOrderList.billingAmount),
                          style: bodyText(
                            fontWeight: FontWeight.w500,
                            fontSize: textSize20px,
                            textColor: colorPrimary,
                          ),
                        ),
                        Text(
                          "${itemOrderList.orderItems.length} items",
                          style: bodyText(
                            fontWeight: FontWeight.w300,
                            textColor: colorCommonBrown,
                          ),
                        ),
                        CustomRoundedButton(
                          buttonText: "Details",
                          onPressed: () {
                            openScreen(context: context, screen: OrderDetailsScreen(item: itemOrderList));
                          },
                          fontSize: textSize15px,
                          padding: EdgeInsetsDirectional.symmetric(
                            horizontal: commonPadding28px,
                            vertical: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        SizedBox(height: commonPadding24px),
        Divider(color: colorPrimaryLight),
      ],
    );
  }
}
