import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ui/customWidget/common_bg_screen.dart';
import 'package:food_ui/customWidget/customBottomNavBar/custom_nav_bar_dl.dart';
import 'package:food_ui/screens/settingsScreen/settings_bloc.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../utils/text_style.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  SettingsBloc? _bloc;
  late List<ItemSettings> settingList;

  @override
  void didChangeDependencies() {
    _bloc ??= SettingsBloc(context);
    settingList = _bloc?.getSettingsList() ?? [];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "Settings",
      bodyWidget: Column(
        children: settingList.asMap().entries.map((entry) {
          int settingIndex = entry.key;
          ItemSettings item = entry.value;
          return Container(
            color: Colors.transparent,
            margin: EdgeInsets.symmetric(
              horizontal: commonPadding16px,
            ),
            child: GestureDetector(
              onTap: item.onTap,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        width: commonSize45px * 0.75,
                        alignment: AlignmentDirectional.center,
                        child: SvgPicture.asset(
                          item.iconPath,
                          height: commonSize45px * 0.75,
                          width: commonSize45px * 0.75,
                        ),
                      ),
                      SizedBox(width: commonPadding16px),
                      Expanded(
                        child: Text(
                          item.title,
                          style: bodyText(
                            fontSize: textSize20px,
                            fontWeight: FontWeight.w500,
                            textColor: colorCommonBrown,
                          ),
                        ),
                      ),
                      SizedBox(width: commonPadding16px),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: iconSize24px,
                        color: colorPrimary,
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      vertical: (settingIndex != settingList.length - 1) ?commonPadding10px: 0,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
