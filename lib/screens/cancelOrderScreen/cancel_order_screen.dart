import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/custom_text_form_field.dart';
import 'package:food_ui/customWidget/no_record_found.dart';
import 'package:food_ui/screens/cancelOrderScreen/cancel_order_bloc.dart';
import 'package:food_ui/screens/cancelOrderScreen/cancel_order_shimmer.dart';
import 'package:food_ui/screens/cancelOrderScreen/cancellation_reason_list_dl.dart';
import 'package:food_ui/utils/text_style.dart';

import '../../constant/constant.dart';
import '../../customWidget/custom_rounded_button.dart';

class CancelOrderScreen extends StatefulWidget {
  const CancelOrderScreen({super.key});

  @override
  State<CancelOrderScreen> createState() => _CancelOrderScreenState();
}

class _CancelOrderScreenState extends State<CancelOrderScreen> {
  CancelOrderBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= CancelOrderBloc(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "Cancel Order",
      bodyPadding: EdgeInsetsDirectional.symmetric(
        horizontal: commonPadding35px,
        vertical: commonPadding300px * 0.16667,
      ),
      bodyWidget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent pellentesque congue lorem, vel tincidunt tortor.",
            style: bodyText(textColor: colorCommonBrown, fontWeight: FontWeight.w300, fontSize: textSize14px),
          ),
          StreamBuilder<Status>(
            stream: _bloc?.subjectStatus,
            builder: (context, snapStatus) {
              return StreamBuilder<CancellationReasonListPojo>(
                stream: _bloc?.subject,
                builder: (context, snapCancelReason) {
                  CancellationReasonListPojo? data = snapCancelReason.data;
                  switch (snapStatus.data ?? Status.loading) {
                    case Status.loading:
                      return const CancelOrderShimmer();
                    case Status.completed:
                      return ((data?.cancellationReasonList ?? []).isNotEmpty)
                          ? _cancelReasonBody(data)
                          : const NoRecordFound();
                    case Status.error:
                      return const NoRecordFound();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _cancelReasonBody(CancellationReasonListPojo? data) {
    List<ItemCancellationReasonList> reasonList = data?.cancellationReasonList ?? [];
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reasonList.length,
          padding: EdgeInsetsDirectional.zero,
          separatorBuilder: (context, index) {
            return Divider(color: colorDividerOrange);
          },
          itemBuilder: (context, index) {
            ItemCancellationReasonList itemReason = reasonList[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (index == 0) Divider(color: colorDividerOrange),
                StreamBuilder<ItemCancellationReasonList?>(
                  stream: _bloc?.selectedReasonSubject,
                  builder: (context, snapSelectedReason) {
                    return GestureDetector(
                      onTap: () {
                        if (index != reasonList.length - 1) {
                          _bloc?.selectedReasonSubject.sink.add(itemReason);
                        } else {
                          _bloc?.selectedReasonSubject.sink.add(null);
                        }
                      },
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: (index == reasonList.length - 1)
                                    ? EdgeInsetsDirectional.symmetric(vertical: commonPadding10px)
                                    : null,
                                child: Text(
                                  itemReason.reasonMessage,
                                  style: bodyText(
                                    fontSize: textSize15px,
                                    fontWeight: FontWeight.w400,
                                    textColor: colorCommonBrown,
                                  ),
                                ),
                              ),
                              if (index != reasonList.length - 1) ...[
                                Radio<ItemCancellationReasonList>(
                                  value: itemReason,
                                  groupValue: snapSelectedReason.data,
                                  onChanged: (value) {
                                    _bloc?.selectedReasonSubject.sink.add(value);
                                  },
                                ),
                              ],
                            ],
                          ),
                          (index == reasonList.length - 1)
                              ? CustomTextFormField(
                                  controller: _bloc?.otherReasonController,
                                  maxLines: 3,
                                  hintText: "Others reason...",
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
        CustomRoundedButton(
          buttonText: "Submit",
          onPressed: () {
            _bloc?.onSubmitCancelledReason();
          },
          fontWeight: FontWeight.w600,
          margin: EdgeInsetsDirectional.only(top: commonPadding32px),

        )
      ],
    );
  }
}
