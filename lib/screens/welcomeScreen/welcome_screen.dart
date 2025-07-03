import 'package:flutter/material.dart';

import '../../customWidget/custom_rounded_button.dart';
import '../../main.dart';
import 'welcome_bloc.dart';
import 'welcome_dl.dart';
import '../../utils/text_style.dart';
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
  void dispose() {
    _bloc?.dispose();
    super.dispose();
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
                buttonText: languages.logIn,
                onPressed: () {
                  _bloc?.onButtonClickedEvent(true);
                },
                fontSize: textSize24px,
                backgroundColor: colorCommonBackground,
                minBtnHeight: 0.048,
                minBtnWidth: 0.4,
                textColor: colorPrimary,
                borderRadius: deviceAvgScreenSize * 0.05367,
              ),
              SizedBox(height: deviceHeight * 0.001),
              CustomRoundedButton(
                buttonText: languages.signUp,
                onPressed: () {
                  _bloc?.onButtonClickedEvent(false);
                },
                fontSize: textSize24px,
                backgroundColor: colorPeach,
                minBtnHeight: 0.048,
                minBtnWidth: 0.4,
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
