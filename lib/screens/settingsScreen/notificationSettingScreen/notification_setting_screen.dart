import 'package:flutter/material.dart';
import 'package:food_ui/constant/colors.dart';
import 'package:food_ui/screens/settingsScreen/notificationSettingScreen/notification_setting_shimmer.dart';
import '../../../constant/dimensions.dart';
import '../../../customWidget/common_bg_screen.dart';
import 'notification_setting_bloc.dart';
import 'notification_setting_list_dl.dart';
import '../../../utils/response_util.dart';
import '../../../utils/text_style.dart';

import '../../../constant/constant.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() => _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  NotificationSettingBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= NotificationSettingBloc(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "Notification Setting",
      bodyWidget: StreamBuilder<ResponseUtil<NotificationSettingListPojo>>(
        stream: _bloc?.subject,
        builder: (context, snapNotificationSetting) {
          NotificationSettingListPojo? data = snapNotificationSetting.data?.data;
          List<ItemNotificationSettingList> notificationSettingList = data?.notificationSettingList ?? [];
          switch (snapNotificationSetting.data?.status ?? Status.loading) {
            case Status.loading:
              return const NotificationSettingShimmer();
            case Status.completed:
              return _notificationSettingBody(notificationSettingList);
            case Status.error:
              return _notificationSettingBody(notificationSettingList);
          }
        },
      ),
    );
  }

  Widget _notificationSettingBody(List<ItemNotificationSettingList> notificationSettingList) {
    return ListView.builder(
      itemCount: notificationSettingList.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.only(top: commonPadding10px * 0.5),
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
              child: Text(
                notificationSettingList[index].notificationSettingName,
                style: bodyText(
                    fontSize: textSize20px, fontWeight: FontWeight.w500, textColor: colorCommonBrown),
              ),
            ),
            Transform.scale(
              // scale: 0.75,
              scaleX: 0.9,
              scaleY: 0.725,
              alignment: AlignmentDirectional.center,
              child: Theme(
                data: Theme.of(context).copyWith(
                  switchTheme: SwitchThemeData(
                    thumbColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) return colorWhite;
                      return colorWhite;
                    }),
                    trackColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) return colorPrimaryLight.withOpacity(0.6);
                      if (states.contains(MaterialState.selected)) return colorPrimary;
                      return colorOffGrey;
                    }),
                  ),
                ),
                child: Switch(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: notificationSettingList[index].isSettingEnabled == 1,
                  onChanged: notificationSettingList[index].isSettingChangeable == 1
                      ? (value) {
                    _bloc?.toggleSetting(index, value);
                  }
                      : null,
                ),
              ),
            ),

          ],
        );
      },
    );
  }
}
