import 'package:flutter/material.dart';
import 'package:food_ui/screens/splashScreen/splash_dl.dart';
import 'package:food_ui/screens/splashScreen/splash_bloc.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/customWidget/custom_image.dart';
import 'package:food_ui/constant/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= SplashBloc(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SplashPojo>(
      stream: _bloc?.subject,
      builder: (context, snapshot) {
        return Container(
          color: colorCommonBackground,
          alignment: AlignmentDirectional.center,
          child: CustomImage(
            imagePath: snapshot.data?.splashImage ?? "",
            width: deviceWidth * 0.57,
            height: deviceHeight * 0.34,
          ),
        );
      },
    );
  }
}
