import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/custom_image.dart';
import 'package:food_ui/main.dart';
import 'package:food_ui/utils/utils.dart';

import '../../customWidget/custom_rounded_button.dart';
import '../../customWidget/custom_text_form_field.dart';
import '../../utils/text_style.dart';

class LeaveReviewScreen extends StatefulWidget {
  final String orderItemImage;
  final String orderItemName;

  const LeaveReviewScreen({super.key, required this.orderItemImage, required this.orderItemName});

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  final reviewCommentController = TextEditingController();
  double userReview = 0;

  @override
  void dispose() {
    reviewCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: languages.leaveAReview,
      bodyWidget: Column(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: deviceAvgScreenSize * 0.028624,
              bottom: commonPadding20px * 1.2,
            ),
            child: CustomImage(
              imagePath: widget.orderItemImage,
              height: deviceAvgScreenSize * 0.280859,
              width: deviceAvgScreenSize * 0.280859,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            widget.orderItemName,
            style: bodyText(
              fontSize: textSize24px,
              fontWeight: FontWeight.w700,
              textColor: colorCommonBrown,
            ),
          ),
          SizedBox(height: commonPadding32px),
          Text(
            languages.weWouldLoveToKnow,
            textAlign: TextAlign.center,
            style: bodyText(
              fontSize: textSize25px,
              fontWeight: FontWeight.w300,
              textColor: colorCommonBrown,
            ),
          ),
          SizedBox(height: commonPadding24px),
          RatingBar(
            filledIcon: Icons.star,
            emptyIcon: Icons.star_border,
            onRatingChanged: (value) {
              debugPrint('reviews ================> $value');
              userReview = value;
            },
            initialRating: 0,
            alignment: Alignment.center,
            size: iconSize33px,
            halfFilledColor: colorRatingStar,
            maxRating: 5,
          ),
          SizedBox(height: commonPadding32px),
          Text(
            languages.leaveUsComment,
            textAlign: TextAlign.center,
            style: bodyText(
              fontSize: textSize25px,
              fontWeight: FontWeight.w300,
              textColor: colorCommonBrown,
            ),
          ),
          SizedBox(height: deviceAvgScreenSize * 0.008945),
          CustomTextFormField(
            controller: reviewCommentController,
            maxLines: 3,
            hintText: languages.writeReview,
            margin: EdgeInsetsDirectional.only(bottom: commonPadding10px),
          ),
          SizedBox(height: commonPadding20px),
          Row(
            children: [
              Expanded(
                child: CustomRoundedButton(
                  buttonText: languages.cancel,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  fontWeight: FontWeight.w400,
                  backgroundColor: colorPrimaryLight,
                  textColor: colorPrimary,
                  borderColor: colorPrimaryLight,
                  minBtnHeight: 0.048,
                  minBtnWidth: 0.4,
                ),
              ),
              SizedBox(width: deviceAvgScreenSize * 0.0268425),
              Expanded(
                child: CustomRoundedButton(
                  buttonText: languages.submit,
                  onPressed: () {
                    if (userReview <= 0) {
                      openSimpleSnackBar(languages.pleaseReviewYourOrder);
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  minBtnHeight: 0.048,
                  minBtnWidth: 0.4,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
