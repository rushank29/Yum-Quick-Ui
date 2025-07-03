import 'package:flutter/material.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/custom_rounded_button.dart';
import 'package:food_ui/customWidget/custom_text_form_field.dart';
import 'package:food_ui/screens/loginScreen/login_bloc.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/screens/setPasswordScreen/set_password_screen.dart';
import 'package:food_ui/screens/signUpScreen/sign_up_screen.dart';
import 'package:food_ui/utils/response_util.dart';
import 'package:food_ui/utils/text_style.dart';
import 'package:food_ui/utils/utils.dart';
import 'package:food_ui/utils/validator_util.dart';

import '../../constant/constant.dart';
import '../../main.dart';
import '../../utils/social_login_util.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= LoginBloc(context);
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
        pageTitle: "Log In",
        bodyWidget: Form(
          key: _bloc?.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                languages.welcome,
                style: bodyText(
                  fontSize: textSize24px,
                  fontWeight: FontWeight.w600,
                  textColor: colorCommonBrown,
                ),
              ),
              SizedBox(height: commonPadding20px),
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
              SizedBox(height: commonPadding24px),
              CustomTextFormField(
                formFieldLabel: languages.password,
                controller: _bloc?.passwordController,
                setPassword: true,
                keyboardType: TextInputType.text,
                validator: (value) => validatePassword(value),
              ),
              SizedBox(height: commonPadding20px),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: GestureDetector(
                  onTap: () {
                    openScreenWithResult(context: context, screen: const SetPasswordScreen());
                    Future.delayed(
                      const Duration(seconds: 3),
                      () {
                        _bloc?.emailController.text = "";
                        _bloc?.passwordController.text = "";
                      },
                    );
                  },
                  child: Text(
                    languages.forgotPassword,
                    style: bodyText(fontWeight: FontWeight.w500, textColor: colorPrimary),
                  ),
                ),
              ),
              SizedBox(height: commonPadding20px * 3),
              Align(
                alignment: AlignmentDirectional.center,
                child: StreamBuilder<ResponseUtil>(
                  stream: _bloc?.subjectStatus,
                  builder: (context, snapStatus) {
                    return CustomRoundedButton(
                      buttonText: languages.logIn,
                      fontSize: textSize24px,
                      setProgress: snapStatus.data?.status == Status.loading,
                      minBtnHeight: 0.052,
                      minBtnWidth: 0.45,
                      onPressed: () {
                        _bloc?.userLogin();
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: commonPadding32px),
              const Align(alignment: AlignmentDirectional.center, child: SocialLoginUtil(isFromLogin: true)),
              SizedBox(height: commonPadding32px),
              Align(
                alignment: AlignmentDirectional.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${languages.doNotHaveAnAccount}  ",
                      style: bodyText(fontWeight: FontWeight.w500, textColor: colorDarkGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        openScreenWithReplacePrevious(
                          context: context,
                          screen: const SignUpScreen(),
                        );
                      },
                      child: Text(
                        languages.signUp,
                        style: bodyText(fontWeight: FontWeight.w500, textColor: colorPrimary),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
