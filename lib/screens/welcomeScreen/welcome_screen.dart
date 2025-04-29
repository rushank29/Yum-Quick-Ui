import 'package:flutter/material.dart';
import 'package:food_ui/customWidget/custom_rounded_button.dart';
import 'package:food_ui/screens/welcomeScreen/welcome_bloc.dart';
import 'package:food_ui/screens/welcomeScreen/welcome_dl.dart';
import 'package:food_ui/utils/text_style.dart';

import '../../customWidget/custom_image.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  WelcomeBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= WelcomeBloc(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WelcomePojo>(
      stream: _bloc?.subject,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsetsDirectional.only(start: deviceWidth * 0.2, end: deviceWidth * 0.2),
          color: colorPrimary,
          alignment: AlignmentDirectional.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(
                imagePath: snapshot.data?.welcomeImage ?? "",
                width: deviceWidth * 0.57,
                height: deviceHeight * 0.34,
              ),
              SizedBox(height: deviceHeight * 0.045),
              Text(
                snapshot.data?.welcomeText ?? "",
                textAlign: TextAlign.center,
                style: bodyText(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: deviceHeight * 0.06),
              CustomRoundedButton(
                buttonText: "Log In",
                onPressed: () {
                  _bloc?.onButtonClickedEvent(true);
                },
                fontSize: textSize24px,
                backgroundColor: colorCommonBackground,
                padding: EdgeInsetsDirectional.only(
                  start: deviceWidth * 0.125,
                  end: deviceWidth * 0.125,
                  top: deviceHeight * 0.01,
                  bottom: deviceHeight * 0.01,
                ),
                textColor: colorPrimary,
                borderRadius: deviceAvgScreenSize * 0.05367,
              ),
              SizedBox(height: deviceHeight * 0.001),
              CustomRoundedButton(
                buttonText: "Sign Up",
                onPressed: () {
                  _bloc?.onButtonClickedEvent(false);
                },
                fontSize: textSize24px,
                backgroundColor: colorPeach,
                padding: EdgeInsetsDirectional.only(
                  start: deviceWidth * 0.125,
                  end: deviceWidth * 0.125,
                  top: deviceHeight * 0.01,
                  bottom: deviceHeight * 0.01,
                ),
                textColor: colorPrimary,
                borderRadius: deviceAvgScreenSize * 0.05367,
              ),
            ],
          ),
        );
      },
    );
  }
}
