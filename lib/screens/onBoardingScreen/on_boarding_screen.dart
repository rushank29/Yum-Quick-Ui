import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/customWidget/custom_image.dart';
import '../../customWidget/custom_rounded_button.dart';
import '../../main.dart';
import '../loginScreen/login_screen.dart';
import 'on_boarding_bloc.dart';
import 'on_boarding_dl.dart';
import '../signUpScreen/sign_up_screen.dart';
import '../../shared_pref_util/shared_pref_constants.dart';
import '../../shared_pref_util/shared_pref_util.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';

class OnBoardingScreen extends StatefulWidget {
  final bool isRedirectedToLogin;

  const OnBoardingScreen({super.key, required this.isRedirectedToLogin});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  OnBoardingBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= OnBoardingBloc(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: StreamBuilder<OnBoardingPojo>(
          stream: _bloc?.subject,
          builder: (context, snapshot) {
            List<OnBoardingPages> onBoardingList = snapshot.data?.onBoardingPages ?? [];
            return onBoardingList.isNotEmpty
                ? StreamBuilder<int>(
                    stream: _bloc?.selectedIndexSubject,
                    builder: (context, snapSelectedIndex) {
                      int selectedIndex = snapSelectedIndex.data ?? 0;
                      final page = onBoardingList[selectedIndex];
                      final bool isLastPage = (selectedIndex) == onBoardingList.length - 1;
                      return Stack(
                        children: [
                          CarouselSlider.builder(
                            carouselController: _bloc?.carouselSliderController,
                            itemCount: onBoardingList.length,
                            options: CarouselOptions(
                              height: double.maxFinite,
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                              onPageChanged: (position, reason) {
                                _bloc?.selectedIndexSubject.sink.add(position);
                              },
                            ),
                            itemBuilder: (context, index, realIndex) {
                              OnBoardingPages onBoarding = onBoardingList[index];
                              return Stack(
                                children: [
                                  Positioned.fill(
                                    child: CustomImage(
                                      imagePath: onBoarding.onBoardingImage,
                                      fit: BoxFit.cover,
                                      borderRadius: BorderRadius.zero,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          _skipButton(isLastPage),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: StreamBuilder<int>(
                              stream: _bloc?.selectedIndexSubject,
                              builder: (context, snapIndex) {
                                return Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: commonPadding24px, vertical: commonPadding32px),
                                  decoration: BoxDecoration(
                                    color: colorMainBackground,
                                    borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(borderRadius32px),
                                      topEnd: Radius.circular(borderRadius32px),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        page.onBoardingIcon,
                                        height: iconSize48px,
                                      ),
                                      SizedBox(height: commonPadding20px),
                                      Text(
                                        page.onBoardingHeader,
                                        style: headerText(
                                          fontSize: textSize24px,
                                          fontWeight: FontWeight.w900,
                                          textColor: colorPrimary,
                                        ),
                                      ),
                                      SizedBox(height: commonPadding20px),
                                      Text(
                                        page.onBoardingBody,
                                        textAlign: TextAlign.center,
                                        style: bodyText(
                                          fontSize: textSize14px,
                                          fontWeight: FontWeight.w500,
                                          textColor: colorCommonBrown,
                                        ),
                                      ),
                                      SizedBox(height: commonPadding32px),
                                      customCarouselIndicator(snapIndex.data ?? 0, onBoardingList.length),
                                      SizedBox(height: commonPadding32px),
                                      _actionButton(isLastPage),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    },
                  )
                : Container();
          },
        ),
      ),
    );
  }

  Widget _actionButton(bool isLastPage) {
    return CustomRoundedButton(
      onPressed: () {
        if (isLastPage) {
          setBool(prefIsOnBoardingVisited, true);
          if (widget.isRedirectedToLogin) {
            openScreenWithReplacePrevious(
                context: context, screen: const LoginScreen());
          } else {
            openScreenWithReplacePrevious(
                context: context, screen: const SignUpScreen());
          }
        } else {
          _bloc?.carouselSliderController?.nextPage();
        }
      },
      minBtnHeight: 0.055,
      minBtnWidth: 0.4,
      buttonText: isLastPage ? languages.getStarted : languages.next,
    );
  }

  Widget _skipButton(bool isLastPage) {
    return Positioned(
      top: deviceHeight * 0.05277,
      right: deviceWidth * 0.05555,
      child: isLastPage
          ? const SizedBox()
          : GestureDetector(
        onTap: () {
          openScreenWithReplacePrevious(
              context: context,
              screen: widget.isRedirectedToLogin
                  ? const LoginScreen()
                  : const SignUpScreen());
        },
        child: Row(
          children: [
            Text(
              languages.skip,
              style: bodyText(
                fontWeight: FontWeight.w600,
                textColor: colorPrimary,
                fontSize: textSize16px,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: colorPrimary,
              size: iconSize24px,
            ),
          ],
        ),
      ),
    );
  }
}
