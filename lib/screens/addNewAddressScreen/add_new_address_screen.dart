import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/custom_text_form_field.dart';
import 'package:food_ui/screens/addNewAddressScreen/add_new_address_bloc.dart';
import 'package:food_ui/utils/validator_util.dart';

import '../../constant/colors.dart';
import '../../customWidget/custom_rounded_button.dart';

class AddNewAddressScreen extends StatefulWidget {
  final int deliveryAddressListLength;

  const AddNewAddressScreen({super.key, required this.deliveryAddressListLength});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  AddNewAddressBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= AddNewAddressBloc(context, widget.deliveryAddressListLength);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "Add New Address",
      bodyWidget: Form(
        key: _bloc?.formKey,
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/svg/home_icon.svg",
              height: commonSize62px,
              width: commonSize62px,
              colorFilter: ColorFilter.mode(
                colorPrimary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: commonPadding300px * 0.1667),
            CustomTextFormField(
              formFieldLabel: "Name",
              controller: _bloc?.nameController,
              validator: (value) {
                return validateEmptyField(value, "Please enter the address name");
              },
            ),
            SizedBox(height: commonPadding32px),
            CustomTextFormField(
              formFieldLabel: "Address",
              validator: (value) {
                return validateEmptyField(value, "Please enter the full address in descriptive form!");
              },
              controller: _bloc?.descriptionController,
            ),
            CustomRoundedButton(
              buttonText: "Apply",
              onPressed: () {
                if (_bloc!.formKey.currentState!.validate()) {
                  _bloc?.addNewAddress();
                }
              },
              fontSize: textSize20px,
              margin: EdgeInsetsDirectional.only(top: commonPadding35px),
            )
          ],
        ),
      ),
    );
  }
}
