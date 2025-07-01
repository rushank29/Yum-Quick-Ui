import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/common_bg_screen.dart';
import 'contactUsTab/contact_us_data_dl.dart';
import 'contactUsTab/contact_us_tab.dart';
import 'contact_us_bloc.dart';
import 'faqTab/faq_data_dl.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';
import '../../constant/constant.dart';
import 'faqTab/faq_tab.dart';

class ContactUsScreen extends StatefulWidget {
  final int selectedMainTab;

  const ContactUsScreen({super.key, required this.selectedMainTab});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  late ContactUsBloc _bloc;

  @override
  void initState() {
    _bloc = ContactUsBloc(context, widget.selectedMainTab);
    _tabController = TabController(length: 2, vsync: this);
    _tabController.animateTo(widget.selectedMainTab);
    _tabController.addListener(() {
      // Only emit when the tab index has changed and the animation completed
      if (_tabController.indexIsChanging == false) {
        _bloc.selectedMainTabSubject.sink.add(_tabController.index);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: widget.selectedMainTab == 0 ? "Help & FAQs":"Contact Us",
      pageSubtitle: "How can we help you?",
      bodyWidget: Column(
        children: [
          Container(
            padding: EdgeInsets.all(commonPadding10px * 0.4),
            decoration: BoxDecoration(
              color: colorHomeBackground,
              borderRadius: BorderRadius.circular(borderRadius30px),
            ),
            child: StreamBuilder<int>(
              stream: _bloc.selectedMainTabSubject,
              builder: (context, snapSelectedTab) {
                int selectedTabIndex = snapSelectedTab.data ?? 0;
                return Row(
                  children: [
                    Expanded(
                      child: commonTabWidget(
                        selectedTabIndex == 0,
                        "FAQ",
                        onPressed: () {
                          _bloc.selectedMainTabSubject.sink.add(0);
                          _tabController.animateTo(0);
                        },
                      ),
                    ),
                    SizedBox(width: commonPadding10px * 0.8),
                    Expanded(
                      child: commonTabWidget(
                        selectedTabIndex == 1,
                        "Contact Us",
                        onPressed: () {
                          _bloc.selectedMainTabSubject.sink.add(1);
                          _tabController.animateTo(1);
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Container(
            constraints: BoxConstraints(
              minHeight: deviceHeight * 0.7,
              maxHeight: deviceHeight * 0.7,
            ),
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                StreamBuilder<ResponseUtil<FaqDataPojo>>(
                    stream: _bloc.subjectFAQ,
                    builder: (context, snapFAQData) {
                      switch (snapFAQData.data?.status ?? Status.loading) {
                        case Status.loading:
                          return Container();
                        case Status.completed:
                          return FAQTab(data: snapFAQData.data?.data, contactUsBloc: _bloc);
                        case Status.error:
                          return FAQTab(data: snapFAQData.data?.data, contactUsBloc: _bloc);
                      }
                    }),
                StreamBuilder<ResponseUtil<ContactUsDataPojo>>(
                  stream: _bloc.subjectContactUs,
                  builder: (context, snapContactUsData) {
                    switch (snapContactUsData.data?.status ?? Status.loading) {
                      case Status.loading:
                        return Container();
                      case Status.completed:
                        return ContactUsTab(data: snapContactUsData.data?.data);
                      case Status.error:
                        return ContactUsTab(data: snapContactUsData.data?.data);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
