import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/custom_rounded_button.dart';
import 'package:food_ui/screens/biometricLoginScreen/biometric_login_bloc.dart';

import '../../utils/text_style.dart';

class BiometricLoginScreen extends StatefulWidget {
  const BiometricLoginScreen({super.key});

  @override
  State<BiometricLoginScreen> createState() => _BiometricLoginScreenState();
}

class _BiometricLoginScreenState extends State<BiometricLoginScreen> {
  BiometricLoginBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= BiometricLoginBloc();
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
        pageTitle: "Set Your Fingerprint",
        bodyWidget: StreamBuilder<bool>(
            stream: _bloc?.changeColorSubject,
            builder: (context, snapColorChange) {
              bool isColorToBeChanged = snapColorChange.data ?? false;
            return Column(
              children: [
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  style: bodyText(
                    fontWeight: FontWeight.w300,
                    textColor: colorDarkGrey,
                  ),
                ),
                SizedBox(height: commonPadding300px * 0.25),
                SvgPicture.asset(
                  "assets/svg/big_biometric.svg",
                  colorFilter: ColorFilter.mode(
                    isColorToBeChanged ? colorPrimaryLight : colorPrimary,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(height: commonPadding32px),
                Row(
                  children: [
                    Expanded(
                      child: CustomRoundedButton(
                        buttonText: "Skip",
                        onPressed: () {},
                        backgroundColor: colorPrimaryLight,
                        borderColor: colorPrimaryLight,
                        fontWeight: FontWeight.w400,
                        fontSize: textSize17px,
                        textColor: colorPrimary,
                        margin: EdgeInsetsDirectional.only(end: commonPadding10px),
                      ),
                    ),
                    Expanded(
                      child: CustomRoundedButton(
                        buttonText: "Continue",
                        onPressed: () {
                          _bloc?.changeColorSubject.sink.add(!isColorToBeChanged);
                        },
                        fontWeight: FontWeight.w400,
                        fontSize: textSize17px,
                        margin: EdgeInsetsDirectional.only(start: commonPadding10px),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
