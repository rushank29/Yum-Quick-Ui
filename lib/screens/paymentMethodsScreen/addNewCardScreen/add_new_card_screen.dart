import 'package:flutter/material.dart';

import '../../../constant/colors.dart';
import '../../../main.dart';
import '../../../utils/text_style.dart';
import '../../../utils/utils.dart';
import '../../../constant/dimensions.dart';
import '../../../customWidget/common_bg_screen.dart';
import '../../../customWidget/custom_rounded_button.dart';
import '../../../customWidget/custom_text_form_field.dart';
import '../../../utils/validator_util.dart';
import 'add_new_card_bloc.dart';

class AddNewCardScreen extends StatefulWidget {
  final int paymentTypeListLength;

  const AddNewCardScreen({super.key, required this.paymentTypeListLength});

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  AddNewCardBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= AddNewCardBloc(context, widget.paymentTypeListLength);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: languages.addNewAddress,
      bodyWidget: Form(
        key: _bloc?.formKey,
        child: Column(
          children: [
            _cardSection(),
            SizedBox(height: commonPadding300px * 0.1667),
            _cardHolderField(),
            SizedBox(height: commonPadding32px),
            _cardNumberField(),
            SizedBox(height: commonPadding32px),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: _expiryDateField(),
                ),
                Flexible(
                  child: _cvvField(),
                ),
              ],
            ),
            _applyButton(),
          ],
        ),
      ),
    );
  }

  Widget _cardHolderField() {
    return CustomTextFormField(
      formFieldLabel: languages.cardHolderName,
      controller: _bloc?.cardHolderNameController,
      validator: (value) {
        return validateEmptyField(value, languages.enterCardHolderName);
      },
      onChanged: (value) {
        _bloc?.cardHolderNameSubject.sink.add(value.trim());
      },
    );
  }

  Widget _cardSection() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(top: commonPadding10px * 0.8),
          height: deviceHeight * 0.248,
          decoration: BoxDecoration(
              color: colorCommonBackground,
              image: const DecorationImage(
                image: AssetImage("assets/images/card_bg.png"),
                alignment: AlignmentDirectional.center,
              ),
              borderRadius: BorderRadiusDirectional.circular(borderRadius20px)),
        ),
        Positioned(
          top: commonPadding10px * 1.8,
          right: commonPadding10px * 1.7,
          child: Container(
            height: deviceAvgScreenSize * 0.021468,
            width: commonSize50px,
            decoration: BoxDecoration(border: Border.all(width: strokeWidth2px, color: colorCommonBrown)),
          ),
        ),
        Positioned(
          bottom: commonPadding28px,
          left: commonPadding16px,
          right: commonPadding16px,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder<String>(
                stream: _bloc?.cardNumberSubject,
                builder: (context, snapCardNo) {
                  return Text(
                    (snapCardNo.data ?? "").isNotEmpty
                        ? getArrangedCardNumber(snapCardNo.data ?? "", mask: false)
                        : "000 000 000 00",
                    style: bodyText(
                      fontSize: textSize14px,
                      fontWeight: FontWeight.w700,
                      textColor: colorCommonBrown,
                    ),
                  );
                },
              ),
              SizedBox(height: commonPadding16px),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        languages.cardHolderName,
                        style: bodyText(
                          fontSize: textSize12px,
                          textColor: colorCommonBrown,
                        ),
                      ),
                      StreamBuilder<String>(
                          stream: _bloc?.cardHolderNameSubject,
                          builder: (context, snapCardHolderName) {
                            return Text(
                              (snapCardHolderName.data ?? "").isNotEmpty
                                  ? (snapCardHolderName.data ?? "")
                                  : "John Smith",
                              style: bodyText(
                                fontSize: textSize14px,
                                fontWeight: FontWeight.w700,
                                textColor: colorCommonBrown,
                              ),
                            );
                          }),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        languages.expiryDate,
                        style: bodyText(
                          fontSize: textSize12px,
                          textColor: colorCommonBrown,
                        ),
                      ),
                      StreamBuilder<String>(
                          stream: _bloc?.expiryDateSubject,
                          builder: (context, snapExpiryDate) {
                            print("snapExpiryDate ==============> ${snapExpiryDate.data}");
                            return Text(
                              (snapExpiryDate.data ?? "").isNotEmpty ? (snapExpiryDate.data ?? "") : "04/28",
                              style: bodyText(
                                fontSize: textSize14px,
                                fontWeight: FontWeight.w700,
                                textColor: colorCommonBrown,
                              ),
                            );
                          }),
                    ],
                  ),
                  Image.asset(
                    "assets/images/card_chip.png",
                    height: iconSize28px,
                    width: iconSize33px * 0.933,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _expiryDateField() {
    return CustomTextFormField(
      formFieldWidth: commonSize120px,
      formFieldLabel: languages.expiryDate,
      validator: (value) {
        return validateEmptyField(value, languages.enterExpiryDate);
      },
      readOnly: true,
      onTap: () {
        showDateSelector(
          context: context,
          controller: _bloc!.expiryDateController,
          initialDate: DateTime.now(),
          lastDate: DateTime(2042),
          firstDate: DateTime.now(),
          format: "MM/yyyy",
          onDateSelected: (value) {
            _bloc?.expiryDateSubject.sink.add(value.trim());
          },
        );
      },
      controller: _bloc?.expiryDateController,
    );
  }

  Widget _cvvField() {
    return CustomTextFormField(
      formFieldWidth: commonSize120px,
      formFieldLabel: languages.cvv,
      validator: (value) {
        return validateEmptyField(value, languages.enterCVV);
      },
      controller: _bloc?.cvvController,
      onChanged: (value) {
        _bloc?.cvvSubject.sink.add(value.trim());
      },
    );
  }

  Widget _cardNumberField() {
    return CustomTextFormField(
      formFieldLabel: languages.cardNumber,
      validator: (value) {
        return validateEmptyField(value, languages.enterCardNumber);
      },
      controller: _bloc?.cardNumberController,
      keyboardType: TextInputType.number,
      maxLength: 11,
      onChanged: (value) {
        _bloc?.cardNumberSubject.sink.add(value.trim());
      },
    );
  }

  Widget _applyButton() {
    return CustomRoundedButton(
      buttonText: languages.apply,
      onPressed: () {
        if (_bloc!.formKey.currentState!.validate()) {
          _bloc?.addNewCard();
        }
      },
      fontSize: textSize20px,
      minBtnHeight: 0.044,
      minBtnWidth: 0.3,
      margin: EdgeInsetsDirectional.only(top: commonPadding35px),
    );
  }
}
