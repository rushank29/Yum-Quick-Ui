import 'package:flutter/material.dart';

import '../../main.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../shared_pref_util/shared_pref_constants.dart';
import '../../shared_pref_util/shared_pref_util.dart';
import '../../constant/colors.dart';
import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../customWidget/no_record_found.dart';
import '../../utils/response_util.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import 'payment_methods_bloc.dart';
import 'payment_methods_dl.dart';
import 'payment_screen_shimmer.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  PaymentMethodsBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= PaymentMethodsBloc(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: languages.paymentMethods,
      bodyWidget: Column(
        children: [
          StreamBuilder<ResponseUtil<PaymentMethodsPojo>>(
            stream: _bloc?.subject,
            builder: (context, snapPaymentMethods) {
              PaymentMethodsPojo? data = snapPaymentMethods.data?.data;
              switch (snapPaymentMethods.data?.status ?? Status.loading) {
                case Status.loading:
                  // return Container();
                return const PaymentScreenShimmer();
                case Status.completed:
                  return ((data?.paymentMethodsList ?? []).isNotEmpty)
                      ? _paymentMethodsBody(data)
                      : const NoRecordFound();
                case Status.error:
                  return NoRecordFound(message: snapPaymentMethods.data?.message);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _paymentMethodsBody(PaymentMethodsPojo? data) {
    List<ItemPaymentMethodsList> paymentMethodsList = data?.paymentMethodsList ?? [];
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: paymentMethodsList.length,
          padding: EdgeInsetsDirectional.zero,
          separatorBuilder: (context, index) {
            return Divider(color: colorDividerOrange);
          },
          itemBuilder: (context, index) {
            ItemPaymentMethodsList itemPaymentMethods = paymentMethodsList[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (index == 0) Divider(color: colorDividerOrange),
                _itemPaymentMethodList(itemPaymentMethods),
                if (index == paymentMethodsList.length - 1) Divider(color: colorDividerOrange),
              ],
            );
          },
        ),
        _addCardButton(),
      ],
    );
  }

  Widget _itemPaymentMethodList(ItemPaymentMethodsList itemPaymentMethods) {
    return StreamBuilder<ItemPaymentMethodsList?>(
      stream: _bloc?.selectedPaymentMethodSubject,
      builder: (context, snapSelectedPaymentType) {
        return InkWell(
          onTap: () {
            _bloc?.selectedPaymentMethodSubject.sink.add(itemPaymentMethods);
            setJsonString(prefSavedPaymentType, itemPaymentMethods);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: commonSize45px,
                alignment: AlignmentDirectional.center,
                child: getPaymentMethodIcon(itemPaymentMethods.paymentType),
              ),
              SizedBox(width: commonPadding10px),
              Expanded(
                child: Text(
                  getPaymentMethodName(
                    itemPaymentMethods.paymentType,
                    cardNumber: itemPaymentMethods.cardNumber,
                  ),
                  style: bodyText(
                    fontSize: textSize15px,
                    fontWeight: FontWeight.w400,
                    textColor: colorCommonBrown,
                  ),
                ),
              ),
              Radio<ItemPaymentMethodsList>(
                value: itemPaymentMethods,
                groupValue: snapSelectedPaymentType.data,
                onChanged: (value) {
                  _bloc?.selectedPaymentMethodSubject.sink.add(itemPaymentMethods);
                  setJsonString(prefSavedPaymentType, itemPaymentMethods);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _addCardButton() {
    return CustomRoundedButton(
      buttonText: languages.addNewCard,
      onPressed: () {
        _bloc?.addNewCardScreen();
      },
      fontSize: textSize20px,
      fontWeight: FontWeight.w400,
      backgroundColor: colorPrimaryLight,
      minBtnHeight: 0.048,
      minBtnWidth: 0.4,
      textColor: colorPrimary,
      borderColor: colorPrimaryLight,
      margin: EdgeInsetsDirectional.only(top: commonPadding35px),
    );
  }
}
