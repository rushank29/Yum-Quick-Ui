import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'item_key_value_pair_dl.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../utils/text_style.dart';

class ItemKeyValueList extends StatelessWidget {
  final ItemKeyValuePair itemKeyValue;
  final TextStyle? fontStyle;
  final Color? dividerColor;
  const ItemKeyValueList({super.key, required this.itemKeyValue, this.fontStyle, this.dividerColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsetsDirectional.symmetric(
            vertical: itemKeyValue.showDivider ? commonPadding10px : commonPadding10px * 0.8,
          ),
          child: itemKeyValue.showDivider
              ? DottedLine(dashColor: dividerColor ?? colorTextCommon)
              : const SizedBox.shrink(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemKeyValue.title,
              style: fontStyle?? bodyText(fontSize: textSize20px, fontWeight: FontWeight.w500),
            ),
            Text(
              itemKeyValue.value,
              style:fontStyle?? bodyText(fontSize: textSize20px, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ],
    );
  }
}
