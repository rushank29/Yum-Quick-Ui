import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'faqTab/faq_data_dl.dart';
import 'faqTab/faq_json.dart';
import 'contactUsTab/contact_us_data_dl.dart';
import 'contactUsTab/contact_us_json.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';

class ContactUsBloc {
  final BuildContext context;
  final int selectedMainTab;

  ContactUsBloc(this.context, this.selectedMainTab) {
    getContactUsData();
    getFAQData();
    selectedMainTabSubject.sink.add(selectedMainTab);
  }

  final subjectContactUs = BehaviorSubject<ResponseUtil<ContactUsDataPojo>>();
  final subjectFAQ = BehaviorSubject<ResponseUtil<FaqDataPojo>>();
  final selectedMainTabSubject = BehaviorSubject<int>();
  final selectedSubTabSubject = BehaviorSubject<int>();
  final expandedTileSubject = BehaviorSubject<int?>();

  void getContactUsData() async {
    try {
      subjectContactUs.sink.add(ResponseUtil.loading());
      var response = ContactUsDataPojo.fromJson(contactUsJson);
      subjectContactUs.sink.add(ResponseUtil.completed(response));
    } catch (error) {
      subjectContactUs.sink.add(ResponseUtil.error(error.toString()));
      openSimpleSnackBar(error.toString());
    }
  }

  void getFAQData() async {
    try {
      subjectFAQ.sink.add(ResponseUtil.loading());
      var response = FaqDataPojo.fromJson(faqJson);
      subjectFAQ.sink.add(ResponseUtil.completed(response));
    } catch (error) {
      subjectFAQ.sink.add(ResponseUtil.error(error.toString()));
      openSimpleSnackBar(error.toString());
    }
  }

  void dispose() {
    selectedMainTabSubject.close();
    subjectContactUs.close();
    subjectFAQ.close();
    expandedTileSubject.close();
  }
}
