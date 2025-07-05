import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../customWidget/custom_text_form_field.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../main.dart';
import '../loginScreen/login_screen.dart';
import 'sign_up_bloc.dart';
import '../../utils/response_util.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import '../../utils/validator_util.dart';
import '../../utils/social_login_util.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  SignUpBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= SignUpBloc(context);
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
        pageTitle: languages.newAccount,
        bodyWidget: Form(
          key: _bloc?.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _fullNameField(),
              SizedBox(height: deviceAvgScreenSize * 0.0268425),
              _passwordField(),
              SizedBox(height: deviceAvgScreenSize * 0.0268425),
              _emailField(),
              SizedBox(height: deviceAvgScreenSize * 0.0268425),
              _mobileField(),
              SizedBox(height: deviceAvgScreenSize * 0.0268425),
              _birthDateField(),
              SizedBox(height: commonPadding20px),
              Align(
                alignment: AlignmentDirectional.center,
                child: _termsAndConditionsSection(),
              ),
              SizedBox(height: deviceAvgScreenSize * 0.008945),
              Align(
                alignment: AlignmentDirectional.center,
                child: _signUpButton(),
              ),
              SizedBox(height: commonPadding32px),
              const Align(
                alignment: AlignmentDirectional.center,
                child: SocialLoginUtil(),
              ),
              SizedBox(height: commonPadding10px),
              Align(
                alignment: AlignmentDirectional.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "${languages.alreadyHaveAccount}  ",
                      style: bodyText(fontWeight: FontWeight.w500, textColor: colorDarkGrey),
                    ),
                    GestureDetector(
                      onTap: () {
                        openScreenWithReplacePrevious(
                          context: context,
                          screen: const LoginScreen(),
                        );
                      },
                      child: Text(
                        languages.logIn,
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

  Widget _fullNameField() {
    return CustomTextFormField(
      formFieldLabel: languages.fullName,
      controller: _bloc?.fullNameController,
      keyboardType: TextInputType.name,
      validator: (value) {
        return validateEmptyField(value, languages.enterYourName);
      },
    );
  }

  Widget _passwordField() {
    return CustomTextFormField(
      formFieldLabel: languages.password,
      controller: _bloc?.passwordController,
      setPassword: true,
      keyboardType: TextInputType.text,
      validator: (value) {
        return validatePassword(value);
      },
    );
  }

  Widget _emailField() {
    return CustomTextFormField(
      formFieldLabel: languages.email,
      controller: _bloc?.emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        return validateEmail(value);
      },
    );
  }

  Widget _mobileField() {
    return CustomTextFormField(
      formFieldLabel: languages.mobileNumber,
      controller: _bloc?.mobileNumberController,
      keyboardType: TextInputType.phone,
      prefix: CountryCodePicker(
        showFlagMain: false,
        initialSelection: "+91",
        onInit: (value) {
          _bloc?.selectedCountrySubject.sink.add(value);
        },
        onChanged: (value) {
          _bloc?.selectedCountrySubject.sink.add(value);
        },
      ),
      validator: (value) {
        return validateEmptyField(value, languages.enterMobileNumber);
      },
    );
  }

  Widget _birthDateField() {
    return CustomTextFormField(
      formFieldLabel: languages.dateOfBirth,
      controller: _bloc?.birthDateController,
      readOnly: true,
      onTap: () {
        showDateSelector(context: context, controller: _bloc!.birthDateController);
      },
      keyboardType: TextInputType.datetime,
      validator: (value) {
        return validateEmptyField(value, languages.selectDateOfBirth);
      },
    );
  }

  Widget _termsAndConditionsSection() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: languages.byContinuing,
        style: bodyText(
          fontWeight: FontWeight.w300,
          fontSize: textSize12px,
          textColor: colorDarkGrey,
        ),
        children: [
          TextSpan(
            text: "${languages.termsOfUse} ",
            style: TextStyle(
              color: colorPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(text: "${languages.and} "),
          TextSpan(
            text: "${languages.privacyPolicy}.",
            style: TextStyle(
              color: colorPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signUpButton() {
    return StreamBuilder<ResponseUtil>(
      stream: _bloc?.subjectStatus,
      builder: (context, snapStatus) {
        return CustomRoundedButton(
          buttonText: languages.signUp,
          fontSize: textSize24px,
          setProgress: snapStatus.data?.status == Status.loading,
          minBtnHeight: 0.052,
          minBtnWidth: 0.45,
          onPressed: () {
            _bloc?.userSignUp();
          },
        );
      },
    );
  }
}
