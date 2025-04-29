import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/custom_image.dart';
import 'package:food_ui/customWidget/custom_rounded_button.dart';
import 'package:food_ui/customWidget/no_record_found.dart';
import 'package:food_ui/screens/myOrdersScreen/my_orders_bloc.dart';
import 'package:food_ui/screens/myOrdersScreen/my_orders_dl.dart';
import 'package:food_ui/screens/myOrdersScreen/my_orders_shimmer.dart';
import 'package:food_ui/utils/text_style.dart';
import 'package:food_ui/utils/utils.dart';

import '../../constant/colors.dart';
import '../../constant/constant.dart';
import '../cancelOrderScreen/cancel_order_screen.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with AutomaticKeepAliveClientMixin {
  MyOrdersBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= MyOrdersBloc(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _myOrdersBody();
  }

  Widget _myOrdersBody() {
    return CommonBackgroundWidget(
      pageTitle: "My Orders",
      bodyWidget: StreamBuilder<int>(
        stream: _bloc?.selectedTabIndex,
        builder: (context, snapSelectedTab) {
          int selectedTab = snapSelectedTab.data ?? 0;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _orderFilterButton(
                      "Active",
                      selectedTab == 0,
                      onTabSelected: () {
                        _bloc?.selectedTabIndex.sink.add(0);
                      },
                    ),
                  ),
                  SizedBox(width: commonPadding10px),
                  Expanded(
                    child: _orderFilterButton(
                      "Completed",
                      selectedTab == 1,
                      onTabSelected: () {
                        _bloc?.selectedTabIndex.sink.add(1);
                      },
                    ),
                  ),
                  SizedBox(width: commonPadding10px),
                  Expanded(
                    child: _orderFilterButton(
                      "Cancelled",
                      selectedTab == 2,
                      onTabSelected: () {
                        _bloc?.selectedTabIndex.sink.add(2);
                      },
                    ),
                  ),
                ],
              ),
              StreamBuilder<Status>(
                stream: _bloc?.subjectStatus,
                builder: (context, snapStatus) {
                  return StreamBuilder<MyOrdersPojo>(
                    stream: _bloc?.subject,
                    builder: (context, snapMyOrders) {
                      MyOrdersPojo? data = snapMyOrders.data;
                      switch (snapStatus.data ?? Status.loading) {
                        case Status.loading:
                          return const MyOrdersShimmer();
                        case Status.completed:
                          return ((data?.itemOrderHistory ?? []).isNotEmpty)
                              ? _myOrdersList(selectedTab, data)
                              : _emptyOrderHistory();
                        case Status.error:
                          return _emptyOrderHistory();
                      }
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _myOrdersList(int selectedTab, MyOrdersPojo? data) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: (data?.itemOrderHistory ?? []).length,
      padding: EdgeInsetsDirectional.zero,
      separatorBuilder: (context, index) {
        return Divider(color: colorDividerOrange);
      },
      itemBuilder: (context, index) {
        ItemOrderHistory? itemOrderHistory = data?.itemOrderHistory[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (index == 0) Divider(color: colorDividerOrange),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImage(
                  imagePath: itemOrderHistory?.itemImage ?? "",
                  height: deviceHeight * 0.15,
                  width: deviceWidth * 0.2,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: commonPadding10px),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              itemOrderHistory?.itemName ?? "",
                              style: bodyText(
                                fontWeight: FontWeight.w500,
                                fontSize: textSize20px,
                                textColor: colorCommonBrown,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          Text(
                            getAmountWithCurrency(itemOrderHistory?.orderAmount ?? 0),
                            style: bodyText(
                              fontWeight: FontWeight.w500,
                              fontSize: textSize20px,
                              textColor: colorPrimary,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getFormattedDateTime(inputDateTime: itemOrderHistory?.orderDateTime ?? ""),
                            style: bodyText(
                              fontWeight: FontWeight.w300,
                              fontSize: textSize14px,
                              textColor: colorCommonBrown,
                            ),
                          ),
                          Text(
                            "${itemOrderHistory?.orderItemCount ?? 0} items",
                            style: bodyText(
                              fontWeight: FontWeight.w300,
                              fontSize: textSize14px,
                              textColor: colorCommonBrown,
                            ),
                          ),
                        ],
                      ),
                      if (selectedTab != 0)
                        Row(
                          children: [
                            SvgPicture.asset(
                              (selectedTab == 1)
                                  ? "assets/svg/order_delivered_tick.svg"
                                  : "assets/svg/order_cancelled_cross.svg",
                              height: iconSize24px * 0.5,
                              width: iconSize24px * 0.5,
                            ),
                            SizedBox(width: commonPadding10px * 0.5),
                            Text(
                              (selectedTab == 1) ? "Order delivered" : "Order cancelled",
                              style: bodyText(
                                fontSize: textSize14px,
                                fontWeight: FontWeight.w300,
                                textColor: colorPrimary,
                              ),
                            )
                          ],
                        ),
                      if (selectedTab != 2)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: CustomRoundedButton(
                                buttonText: selectedTab == 0 ? "Cancel Order" : "Leave a review",
                                onPressed: () {
                                  if (selectedTab == 0) {
                                    openScreen(context: context, screen: const CancelOrderScreen());
                                  }
                                },
                                fontSize: textSize15px,
                                padding: EdgeInsetsDirectional.only(
                                  start: commonPadding10px,
                                  end: commonPadding10px,
                                ),
                              ),
                            ),
                            SizedBox(width: commonPadding10px * 1.5),
                            Expanded(
                              child: CustomRoundedButton(
                                buttonText: selectedTab == 0 ? "Track Driver" : "Order Again",
                                onPressed: () {},
                                fontSize: textSize15px,
                                fontWeight: FontWeight.w400,
                                backgroundColor: colorPrimaryLight,
                                textColor: colorPrimary,
                                borderColor: colorPrimaryLight,
                                padding: EdgeInsetsDirectional.only(
                                  start: commonPadding10px,
                                  end: commonPadding10px,
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
            if (index == (data?.itemOrderHistory.length ?? 0) - 1) Divider(color: colorDividerOrange),
          ],
        );
      },
    );
  }

  Widget _orderFilterButton(String tabTxt, bool isTabSelected, {required void Function()? onTabSelected}) {
    return CustomRoundedButton(
      buttonText: tabTxt,
      onPressed: () {
        onTabSelected?.call();
        _bloc?.getMyOrders();
      },
      padding: EdgeInsetsDirectional.only(start: commonPadding10px * 0.5, end: commonPadding10px * 0.5),
      backgroundColor: isTabSelected ? null : colorPrimaryLight,
      textColor: isTabSelected ? null : colorPrimary,
      borderColor: isTabSelected ? null : colorPrimaryLight,
    );
  }

  Widget _emptyOrderHistory({String? message}) {
    return NoRecordFound(
      message: message ?? "You don't have any active orders at this time",
    );
  }

  @override
  bool get wantKeepAlive => true;
}
