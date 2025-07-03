import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ui/customWidget/custom_text_form_field.dart';
import 'package:food_ui/screens/contactUsScreen/contact_us_bloc.dart';
import 'package:food_ui/screens/contactUsScreen/faqTab/faq_data_dl.dart';

import '../../../constant/colors.dart';
import '../../../constant/dimensions.dart';
import '../../../main.dart';
import '../../../utils/text_style.dart';
import '../../../utils/utils.dart';

class FAQTab extends StatefulWidget {
  final FaqDataPojo? data;
  final ContactUsBloc contactUsBloc;

  const FAQTab({super.key, required this.contactUsBloc, required this.data});

  @override
  State<FAQTab> createState() => _FAQTabState();
}

class _FAQTabState extends State<FAQTab> with TickerProviderStateMixin {
  late TabController _subTabController;

  @override
  void initState() {
    _subTabController = TabController(length: 3, vsync: this);
    _subTabController.addListener(() {
      // Only emit when the tab index has changed and the animation completed
      if (_subTabController.indexIsChanging == false) {
        widget.contactUsBloc.selectedSubTabSubject.sink.add(_subTabController.index);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(commonPadding10px * 0.4),
          decoration: BoxDecoration(
            color: colorHomeBackground,
            borderRadius: BorderRadius.circular(borderRadius30px),
          ),
          child: StreamBuilder<int>(
            stream: widget.contactUsBloc.selectedSubTabSubject,
            builder: (context, snapSelectedTab) {
              int selectedTabIndex = snapSelectedTab.data ?? 0;
              return Row(
                children: [
                  Expanded(
                    child: commonTabWidget(
                      selectedTabIndex == 0,
                      languages.general,
                      fontSize: textSize15px,
                      onPressed: () {
                        widget.contactUsBloc.selectedSubTabSubject.sink.add(0);
                        _subTabController.animateTo(0);
                      },
                    ),
                  ),
                  SizedBox(width: commonPadding10px * 0.8),
                  Expanded(
                    child: commonTabWidget(
                      selectedTabIndex == 1,
                      languages.account,
                      fontSize: textSize15px,
                      onPressed: () {
                        widget.contactUsBloc.selectedSubTabSubject.sink.add(1);
                        _subTabController.animateTo(1);
                      },
                    ),
                  ),
                  SizedBox(width: commonPadding10px * 0.8),
                  Expanded(
                    child: commonTabWidget(
                      selectedTabIndex == 2,
                      languages.services,
                      fontSize: textSize15px,
                      onPressed: () {
                        widget.contactUsBloc.selectedSubTabSubject.sink.add(2);
                        _subTabController.animateTo(2);
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
            minHeight: deviceHeight * 0.625,
            maxHeight: deviceHeight * 0.625,
          ),
          child: TabBarView(
            controller: _subTabController,
            children: <Widget>[
              _faqData(),
              _faqData(),
              _faqData(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _faqData() {
    List<ItemFaqDataList> faqDataList = widget.data?.faqDataList ?? [];
    return Column(
      children: [
        SizedBox(height: commonPadding16px),
        CustomTextFormField(
          borderRadius: BorderRadius.circular(borderRadius30px),
          hintText: "Search",
          backgroundColor: colorWhite,
          suffix: Container(
            padding: EdgeInsetsDirectional.all(commonPadding10px * 0.7),
            decoration: BoxDecoration(
              color: colorWhite,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              "assets/svg/shuffle.svg",
              height: iconSize20px * 0.75,
              width: iconSize20px * 0.75,
              colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
            ),
          ),
          setError: false,
        ),
        ListView.builder(
          itemCount: faqDataList.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return StreamBuilder<int?>(
              stream: widget.contactUsBloc.expandedTileSubject,
              builder: (context, snapExpandedTileIndex) {
                int? expandedTileIndex = snapExpandedTileIndex.data;
                return ExpansionTile(
                  key: ValueKey('expansion_tile_$index-${expandedTileIndex == index}'),
                  initiallyExpanded: expandedTileIndex == index,
                  onExpansionChanged: (expanded) {
                    final currentIndex = expanded ? index : null;
                    if (widget.contactUsBloc.expandedTileSubject.valueOrNull != currentIndex) {
                      widget.contactUsBloc.expandedTileSubject.sink.add(currentIndex);
                    }
                  },
                  title: Text(
                    faqDataList[index].itemTitle,
                    style: bodyText(
                      fontSize: textSize20px,
                      fontWeight: FontWeight.w500,
                      textColor: colorCommonBrown,
                    ),
                  ),
                  children: [
                    Text(
                      faqDataList[index].itemSubtitle,
                      style: bodyText(
                        fontSize: textSize14px,
                        fontWeight: FontWeight.w300,
                        textColor: colorCommonBrown,
                      ),
                    )
                  ],
                );
              },
            );
          },
        )
      ],
    );
  }
}
