import 'package:flutter/material.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/custom_rounded_button.dart';
import 'package:food_ui/customWidget/custom_text_form_field.dart';
import 'package:food_ui/screens/loginScreen/login_bloc.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/screens/setPasswordScreen/set_password_screen.dart';
import 'package:food_ui/screens/signUpScreen/sign_up_screen.dart';
import 'package:food_ui/utils/text_style.dart';
import 'package:food_ui/utils/utils.dart';
import 'package:food_ui/utils/validator_util.dart';

import '../../constant/constant.dart';
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
                "Welcome",
                style: bodyText(
                  fontSize: textSize24px,
                  fontWeight: FontWeight.w600,
                  textColor: colorCommonBrown,
                ),
              ),
              SizedBox(height: commonPadding20px),
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
              SizedBox(height: commonPadding24px),
              CustomTextFormField(
                formFieldLabel: "Password",
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
                    "Forgot Password",
                    style: bodyText(fontWeight: FontWeight.w500, textColor: colorPrimary),
                  ),
                ),
              ),
              SizedBox(height: commonPadding20px * 3),
              Align(
                alignment: AlignmentDirectional.center,
                child: StreamBuilder<Status>(
                  stream: _bloc?.subjectStatus,
                  builder: (context, snapStatus) {
                    return CustomRoundedButton(
                      buttonText: "Log In",
                      fontSize: textSize24px,
                      setProgress: snapStatus.data == Status.loading,
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
                      "Don’t have an account?  ",
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
                        "Sign Up",
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
