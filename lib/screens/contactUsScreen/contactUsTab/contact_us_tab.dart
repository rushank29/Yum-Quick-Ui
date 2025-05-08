import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/constant/dimensions.dart';
import 'package:food_ui/utils/text_style.dart';

import 'contact_us_data_dl.dart';

class ContactUsTab extends StatelessWidget {
  final ContactUsDataPojo? data;

  const ContactUsTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    List<ItemContactUsDataList> contactUsDataList = data?.contactUsDataList ?? [];
    return ListView.builder(
      itemCount: contactUsDataList.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            leading: SvgPicture.asset(
              contactUsDataList[index].itemIcon,
              height: iconSize33px,
              width: iconSize33px,
              colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
            ),
            title: Text(
              contactUsDataList[index].itemTitle,
              style: bodyText(
                fontSize: textSize20px,
                fontWeight: FontWeight.w500,
                textColor: colorCommonBrown,
              ),
            ),
          ),
        );
      },
    );
  }
}
