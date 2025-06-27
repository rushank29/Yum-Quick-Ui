import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../constant/dimensions.dart';
import '../utils/text_style.dart';

class CommonBackgroundWidget extends StatelessWidget {
  final String? pageTitle;
  final String? pageSubtitle;
  final EdgeInsetsDirectional? bodyPadding;
  final Widget bodyWidget;
  final Widget? pageTitleWidget;
  final Color? bodyBgColor;
  final void Function()? onBackPressed;
  final bool showBackButton;

  const CommonBackgroundWidget({
    super.key,
    this.pageTitle,
    this.pageSubtitle,
    this.bodyPadding,
    required this.bodyWidget,
    this.bodyBgColor,
    this.onBackPressed, this.pageTitleWidget, this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCommonBackground,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsetsDirectional.only(
                      top: commonPadding300px * 0.25,
                      bottom: pageSubtitle != null ? 0 : commonPadding300px * 0.175,
                      start: commonPadding24px,
                      end: commonPadding24px,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (pageTitle != null) ...[
                          if (showBackButton)
                            GestureDetector(
                              onTap: onBackPressed ??
                                  () {
                                    Navigator.pop(context);
                                  },
                              child: Icon(Icons.chevron_left_rounded, color: colorPrimary),
                            ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  pageTitle!,
                                  textAlign: TextAlign.center,
                                  style: bodyText(
                                    fontWeight: FontWeight.w700,
                                    fontSize: textSize28px,
                                    textColor: colorWhite,
                                  ),
                                ),
                                if (pageSubtitle != null) ...[
                                  SizedBox(height: commonPadding10px * 0.6),
                                  Text(
                                    pageSubtitle!,
                                    textAlign: TextAlign.center,
                                    style: bodyText(
                                      fontSize: textSize16px,
                                      textColor: colorPrimary,
                                    ),
                                  ),
                                  SizedBox(height: commonPadding10px * 0.6),
                                ]
                              ],
                            ),
                          ),
                        ],
                        if (pageTitleWidget != null) ...[
                          if (showBackButton)
                            GestureDetector(
                              onTap: onBackPressed ??
                                  () {
                                    Navigator.pop(context);
                                  },
                              child: Icon(Icons.chevron_left_rounded, color: colorPrimary),
                            ),
                          Expanded(
                            child: pageTitleWidget!,
                          )
                        ],
                      ],
                    ),
                  ),

                  /// Scrollable Body with Rounded Corners
                  Container(
                    constraints: BoxConstraints(
                        minHeight: pageSubtitle != null
                            ? constraints.maxHeight * 0.8025
                            : constraints.maxHeight * 0.775,
                        minWidth: deviceWidth),
                    padding: bodyPadding ??
                        EdgeInsetsDirectional.symmetric(
                          horizontal: commonPadding24px,
                          vertical: commonPadding24px,
                        ),
                    decoration: BoxDecoration(
                      color: bodyBgColor ?? colorHomeBackground,
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(borderRadius30px),
                        topEnd: Radius.circular(borderRadius30px),
                      ),
                    ),
                    child: bodyWidget,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
