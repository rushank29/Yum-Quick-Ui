import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/custom_image.dart';
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
      pageTitle: "Leave A Review",
      bodyWidget: Column(
        children: [
          SizedBox(height: commonPadding10px * 1.6),
          CustomImage(
            imagePath: widget.orderItemImage,
            height: deviceAvgScreenSize * 0.280859,
            width: deviceAvgScreenSize * 0.280859,
            fit: BoxFit.cover,
          ),
          SizedBox(height: commonPadding20px * 1.2),
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
            "We'd love to know what you think of your dish.",
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
            "Leave us your comment!",
            textAlign: TextAlign.center,
            style: bodyText(
              fontSize: textSize25px,
              fontWeight: FontWeight.w300,
              textColor: colorCommonBrown,
            ),
          ),
          SizedBox(height: commonPadding10px * 0.5),
          CustomTextFormField(
            controller: reviewCommentController,
            maxLines: 3,
            hintText: "Write Review...",
            margin: EdgeInsetsDirectional.only(bottom: commonPadding10px),
          ),
          SizedBox(height: commonPadding20px),
          Row(
            children: [
              Expanded(
                child: CustomRoundedButton(
                  buttonText: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  fontWeight: FontWeight.w400,
                  backgroundColor: colorPrimaryLight,
                  textColor: colorPrimary,
                  borderColor: colorPrimaryLight,
                  padding: EdgeInsetsDirectional.only(
                    start: commonPadding10px,
                    end: commonPadding10px,
                  ),
                ),
              ),
              SizedBox(width: commonPadding10px * 1.5),
              Expanded(
                child: CustomRoundedButton(
                  buttonText: "Submit",
                  onPressed: () {
                    if (userReview <= 0) {
                      openSimpleSnackBar("Please review your order");
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  padding: EdgeInsetsDirectional.only(
                    start: commonPadding10px,
                    end: commonPadding10px,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
