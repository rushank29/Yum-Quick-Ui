import 'package:flutter/material.dart';

import '../../customWidget/common_bg_screen.dart';
import '../../main.dart';
import '../../utils/response_util.dart';
import '../../constant/colors.dart';
import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../customWidget/custom_text_form_field.dart';
import '../../utils/text_style.dart';
import '../../utils/validator_util.dart';
import 'set_password_bloc.dart';

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
      body: CommonBackgroundWidget(
        pageTitle: languages.setPassword,
        bodyWidget: Form(
          key: _bloc?.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                languages.loremIpsum,
                style: bodyText(
                  fontWeight: FontWeight.w300,
                  textColor: colorDarkGrey,
                ),
              ),
              SizedBox(height: commonPadding24px * 2),
              CustomTextFormField(
                formFieldLabel: "${languages.email} ${languages.or} ${languages.mobileNumber}",
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
                      buttonText: languages.createNewPassword,
                      fontSize: textSize17px,
                      setProgress: snapStatus.data?.status == Status.loading,
                      minBtnHeight: 0.052,
                      minBtnWidth: 0.5,
                      onPressed: () {
                        _bloc?.setNewPassword();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
