import 'package:flutter/material.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/customWidget/custom_rounded_button.dart';
import 'package:food_ui/customWidget/custom_text_form_field.dart';
import 'package:food_ui/main.dart';
import 'package:food_ui/screens/settingsScreen/passwordSettingScreen/password_setting_bloc.dart';
import 'package:food_ui/utils/validator_util.dart';

import '../../../customWidget/common_bg_screen.dart';

class PasswordSettingScreen extends StatefulWidget {
  const PasswordSettingScreen({super.key});

  @override
  State<PasswordSettingScreen> createState() => _PasswordSettingScreenState();
}

class _PasswordSettingScreenState extends State<PasswordSettingScreen> {
  PasswordSettingBloc? _bloc;

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _bloc ??= PasswordSettingBloc(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: languages.passwordSetting,
      bodyWidget: Column(
        children: [
          CustomTextFormField(
            controller: _bloc?.oldPasswordController,
            formFieldLabel: languages.oldPassword,
            validator: (value) {
              return validatePassword(value);
            },
          ),
          SizedBox(height: commonPadding16px),
          CustomTextFormField(
            controller: _bloc?.newPasswordController,
            formFieldLabel: languages.newPassword,
            validator: (value) {
              return validatePassword(value);
            },
          ),
          SizedBox(height: commonPadding16px),
          CustomTextFormField(
            controller: _bloc?.codeController,
            formFieldLabel: languages.code,
            validator: (value) {
              return validateEmptyField(value, languages.enterCodeSentToEmail);
            },
          ),
          SizedBox(height: commonPadding32px),
          CustomRoundedButton(
            buttonText: languages.changePassword,
            onPressed: () {
              _bloc?.userChangePassword();
            },
          ),
        ],
      ),
    );
  }
}
