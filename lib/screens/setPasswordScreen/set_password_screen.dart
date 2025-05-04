import 'package:flutter/material.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/screens/setPasswordScreen/set_password_bloc.dart';
import 'package:food_ui/utils/response_util.dart';

import '../../constant/colors.dart';
import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../customWidget/custom_text_form_field.dart';
import '../../utils/text_style.dart';
import '../../utils/validator_util.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  SetPasswordBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= SetPasswordBloc(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorMainBackground,
      body: CommonBackgroundWidget(pageTitle: "Set Password", bodyWidget: Form(
        key: _bloc?.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              style: bodyText(
                fontWeight: FontWeight.w300,
                textColor: colorDarkGrey,
              ),
            ),
            SizedBox(height: commonPadding24px * 2),
            CustomTextFormField(
              formFieldLabel: "Email or Mobile Number",
              controller: _bloc?.emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => validateEmail(value),
            ),
            SizedBox(height: commonPadding32px),
            Align(
              alignment: AlignmentDirectional.center,
              child: StreamBuilder<ResponseUtil>(
                stream: _bloc?.subjectStatus,
                builder: (context, snapStatus) {
                  return CustomRoundedButton(
                    buttonText: "Create New Password",
                    fontSize: textSize17px,
                    setProgress: snapStatus.data?.status == Status.loading,
                    onPressed: () {
                      _bloc?.setNewPassword();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),),
    );
  }
}
