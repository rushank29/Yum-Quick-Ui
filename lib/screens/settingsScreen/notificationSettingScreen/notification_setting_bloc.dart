import 'package:flutter/material.dart';
import 'notification_setting_list_dl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/response_util.dart';
import '../../../utils/utils.dart';
import 'notification_setting_json.dart';

class NotificationSettingBloc {
  final BuildContext context;

  NotificationSettingBloc(this.context) {
    getNotificationSettingList();
  }

  final subject = BehaviorSubject<ResponseUtil<NotificationSettingListPojo>>();

  void getNotificationSettingList() async {
    try {
      subject.sink.add(ResponseUtil.loading());
      await Future.delayed(const Duration(seconds: 1));
      var response = NotificationSettingListPojo.fromJson(notificationSettingJson);
      subject.sink.add(ResponseUtil.completed(response));
    } catch (error) {
      subject.sink.add(ResponseUtil.error(error.toString()));
      openSimpleSnackBar(error.toString());
    }
  }

  void toggleSetting(int index, bool enabled) {
    NotificationSettingListPojo? currentPojo = subject.value.data;
    if (currentPojo == null) return;
    List<ItemNotificationSettingList> updatedList =
        List<ItemNotificationSettingList>.from(currentPojo.notificationSettingList);

    updatedList[index].setSettingEnabled = enabled ? 1 : 0;

    subject.sink.add(
      ResponseUtil.completed(
        NotificationSettingListPojo(notificationSettingList: updatedList),
      ),
    );
  }

  void dispose() {
    subject.close();
  }
}
