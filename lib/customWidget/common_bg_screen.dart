import 'package:flutter/material.dart';

import '../constant/colors.dart';
import '../constant/dimensions.dart';
import '../utils/text_style.dart';

class CommonBackgroundWidget extends StatelessWidget {
  final String? pageTitle;
  final Widget? pageHeaderWidget;
  final EdgeInsetsDirectional? bodyPadding;
  final Widget bodyWidget;
  final Color? bodyBgColor;

  const CommonBackgroundWidget({
    super.key,
    this.pageTitle,
    this.pageHeaderWidget,
    this.bodyPadding,
    required this.bodyWidget,
    this.bodyBgColor,
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
                children: [
                  // Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsetsDirectional.only(
                      top: commonPadding300px * 0.25,
                      bottom: commonPadding300px * 0.175,
                      start: commonPadding24px,
                      end: commonPadding24px,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (pageHeaderWidget != null) pageHeaderWidget!,
                        if (pageTitle != null && pageHeaderWidget == null) ...[
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.chevron_left_rounded, color: colorPrimary),
                          ),
                          Expanded(
                            child: Text(
                              pageTitle!,
                              textAlign: TextAlign.center,
                              style: bodyText(
                                fontWeight: FontWeight.w700,
                                fontSize: textSize28px,
                                textColor: colorWhite,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  /// Scrollable Body with Rounded Corners
                  Container(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight * 0.8, minWidth: deviceWidth),
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
