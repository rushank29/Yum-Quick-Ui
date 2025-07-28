import 'package:flutter/material.dart';
import 'package:food_ui/utils/response_util.dart';

import '../../constant/colors.dart';
import '../../customWidget/custom_image.dart';
import '../../constant/dimensions.dart';
import 'splash_dl.dart';
import 'splash_bloc.dart';

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
    return StreamBuilder<ResponseUtil<SplashPojo>>(
      stream: _bloc?.subject,
      builder: (context, snapshot) {
        return Container(
          color: colorCommonBackground,
          alignment: AlignmentDirectional.center,
          child: CustomImage(
            imagePath: snapshot.data?.data?.splashImage ?? "",
            width: deviceWidth * 0.57,
            height: deviceHeight * 0.34,
          ),
        );
      },
    );
  }
}
