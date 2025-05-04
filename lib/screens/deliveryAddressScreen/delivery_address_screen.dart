import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/shared_pref_util/shared_pref_constants.dart';
import 'package:food_ui/shared_pref_util/shared_pref_util.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../customWidget/no_record_found.dart';
import '../../utils/response_util.dart';
import 'delivery_address_bloc.dart';
import 'delivery_address_dl.dart';
import 'package:food_ui/utils/text_style.dart';

import '../../constant/constant.dart';
import '../../customWidget/custom_rounded_button.dart';
import 'delivery_address_shimmer.dart';

class DeliveryAddressScreen extends StatefulWidget {
  const DeliveryAddressScreen({super.key});

  @override
  State<DeliveryAddressScreen> createState() => _DeliveryAddressScreenState();
}

class _DeliveryAddressScreenState extends State<DeliveryAddressScreen> {
  DeliveryAddressBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= DeliveryAddressBloc(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "Delivery Address",
      bodyPadding: EdgeInsetsDirectional.symmetric(
        horizontal: commonPadding35px,
        vertical: commonPadding300px * 0.16667,
      ),
      bodyWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<ResponseUtil<DeliveryAddressPojo>>(
            stream: _bloc?.subject,
            builder: (context, snapDeliveryAddress) {
              DeliveryAddressPojo? data = snapDeliveryAddress.data?.data;
              switch (snapDeliveryAddress.data?.status ?? Status.loading) {
                case Status.loading:
                  return const DeliveryAddressShimmer();
                case Status.completed:
                  return ((data?.deliveryAddressList ?? []).isNotEmpty)
                      ? _deliveryAddressBody(data)
                      : const NoRecordFound();
                case Status.error:
                  return const NoRecordFound();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _deliveryAddressBody(DeliveryAddressPojo? data) {
    List<ItemDeliveryAddressList> deliveryAddressList = data?.deliveryAddressList ?? [];
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: deliveryAddressList.length,
          padding: EdgeInsetsDirectional.zero,
          separatorBuilder: (context, index) {
            return Divider(color: colorDividerOrange);
          },
          itemBuilder: (context, index) {
            ItemDeliveryAddressList itemDeliveryAddress = deliveryAddressList[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (index == 0) Divider(color: colorDividerOrange),
                StreamBuilder<ItemDeliveryAddressList?>(
                  stream: _bloc?.selectedDeliveryAddressSubject,
                  builder: (context, snapSelectedDeliveryAddress) {
                    return GestureDetector(
                      onTap: () {
                        setJsonString(prefSavedAddress, itemDeliveryAddress);
                        _bloc?.loadAddress();
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  margin: EdgeInsetsDirectional.symmetric(vertical: commonPadding16px),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/svg/home_icon.svg",
                                        height: iconSize33px,
                                        width: iconSize33px,
                                        colorFilter: ColorFilter.mode(
                                          colorPrimary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      SizedBox(width: commonPadding16px),
                                      Flexible(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              itemDeliveryAddress.addressName,
                                              style: bodyText(
                                                fontSize: textSize20px,
                                                fontWeight: FontWeight.w500,
                                                textColor: colorCommonBrown,
                                              ),
                                            ),
                                            Flexible(
                                              child: Text(
                                                itemDeliveryAddress.addressDescription,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: bodyText(
                                                  fontSize: textSize14px,
                                                  fontWeight: FontWeight.w300,
                                                  textColor: colorCommonBrown,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Radio<ItemDeliveryAddressList>(
                                value: itemDeliveryAddress,
                                groupValue: snapSelectedDeliveryAddress.data,
                                onChanged: (value) {
                                  setJsonString(prefSavedAddress, value!);
                                  _bloc?.loadAddress();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
                if (index == deliveryAddressList.length - 1) Divider(color: colorDividerOrange),
              ],
            );
          },
        ),
        CustomRoundedButton(
          buttonText: "Add New Address",
          onPressed: () {
            _bloc?.openAddAddressScreen();
          },
          fontSize: textSize20px,
          fontWeight: FontWeight.w400,
          backgroundColor: colorPrimaryLight,
          textColor: colorPrimary,
          borderColor: colorPrimaryLight,
          margin: EdgeInsetsDirectional.only(top: commonPadding35px),
        )
      ],
    );
  }
}
