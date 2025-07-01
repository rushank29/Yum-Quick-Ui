import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_ui/customWidget/custom_rounded_button.dart';
import 'package:food_ui/main.dart';

import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../utils/text_style.dart';
import '../homeScreen/home_dl.dart';
import 'filter_bloc.dart';

class FilterScreen extends StatefulWidget {
  final List<FoodCategories> foodCategoryList;
  final int selectedIndex;

  const FilterScreen({super.key, required this.foodCategoryList, required this.selectedIndex});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  FilterBloc? _bloc;
  List<int> subCategoryListToBeAdded = [];

  @override
  void didChangeDependencies() {
    _bloc ??= FilterBloc();
    _bloc?.selectedIndexSubject.sink.add(widget.selectedIndex);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: "Filter",
      bodyWidget: StreamBuilder<int>(
        stream: _bloc?.selectedIndexSubject,
        builder: (context, snapSelectedIndex) {
          int selectedPosition = snapSelectedIndex.data ?? widget.selectedIndex;
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _categoriesSection(selectedPosition),
              _ratingSection(selectedPosition),
              _subCategorySection(selectedPosition),
              _sliderSection(selectedPosition),
              Align(
                alignment: AlignmentDirectional.center,
                child: CustomRoundedButton(
                  buttonText: languages.apply,
                  onPressed: () {},
                  margin: EdgeInsetsDirectional.only(top: commonPadding32px, bottom: commonPadding10px),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _categoriesSection(int selectedPosition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          languages.categories,
          style: bodyText(fontSize: textSize20px, textColor: colorCommonBrown, fontWeight: FontWeight.w500),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(
            top: commonPadding20px,
            bottom: commonPadding10px * 1.4,
          ),
          height: commonSize75px,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.foodCategoryList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  _bloc?.selectedIndexSubject.sink.add(index);
                  subCategoryListToBeAdded.clear();
                },
                child: Container(
                  margin: EdgeInsetsDirectional.only(
                      end: index < (widget.foodCategoryList.length) - 1 ? commonPadding20px : 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.all(commonPadding10px),
                        decoration: BoxDecoration(
                          color: index == selectedPosition ? colorCommonBackground : colorPeach,
                          borderRadius: BorderRadiusDirectional.all(
                            Radius.circular(borderRadius30px),
                          ),
                        ),
                        child: SvgPicture.asset(
                          widget.foodCategoryList[index].categoryIcon,
                          height: iconSize37px,
                          width: iconSize33px,
                          colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                        ),
                      ),
                      Text(
                        widget.foodCategoryList[index].categoryName,
                        style: bodyText(
                          fontSize: textSize12px,
                          textColor: colorCommonBrown,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Divider(color: colorDividerOrange),
        SizedBox(height: commonPadding20px)
      ],
    );
  }

  Widget _ratingSection(int selectedPosition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          languages.sortBy,
          style: bodyText(fontSize: textSize20px, textColor: colorCommonBrown, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: commonPadding10px),
        Container(
          height: deviceAvgScreenSize * 0.03579,
          margin: EdgeInsetsDirectional.only(bottom: commonPadding10px * 1.4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                languages.topRated,
                style: bodyText(
                    fontSize: textSize14px, textColor: colorCommonBrown, fontWeight: FontWeight.w300),
              ),
              SizedBox(width: commonPadding10px),
              ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.foodCategoryList[selectedPosition].topRated,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(width: deviceAvgScreenSize * 0.012);
                },
                itemBuilder: (context, index) {
                  return SvgPicture.asset(
                    "assets/svg/rating_star_filled.svg",
                    height: iconSize15px,
                    width: iconSize15px,
                    colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                  );
                },
              ),
              SizedBox(width: deviceAvgScreenSize * 0.012),
              ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 5 - int.parse("${widget.foodCategoryList[selectedPosition].topRated}"),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) {
                  return SizedBox(width: deviceAvgScreenSize * 0.012);
                },
                itemBuilder: (context, index) {
                  return SvgPicture.asset(
                    "assets/svg/rating_star.svg",
                    height: iconSize15px,
                    width: iconSize15px,
                    colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                  );
                },
              )
            ],
          ),
        ),
        Divider(color: colorPrimaryLight)
      ],
    );
  }

  Widget _subCategorySection(int selectedPosition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsetsDirectional.symmetric(vertical: commonPadding10px),
          child: Text(
            languages.categories,
            style: bodyText(fontSize: textSize14px, textColor: colorCommonBrown, fontWeight: FontWeight.w300),
          ),
        ),
        StreamBuilder<List<int>>(
          stream: _bloc?.selectedSubCategorySubject,
          builder: (context, snapSelectedSubCategory) {
            List<int> selectedSubCategoryList = snapSelectedSubCategory.data ?? [];
            return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.zero,
              itemCount: widget.foodCategoryList[selectedPosition].subCategories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: commonPadding10px,
                childAspectRatio: 26 / 9,
                mainAxisSpacing: commonPadding10px,
              ),
              itemBuilder: (BuildContext context, int subCategoryIndex) {
                bool isSubCatIdSelected = selectedSubCategoryList
                    .contains(widget.foodCategoryList[selectedPosition].subCategories[subCategoryIndex].id);
                int subCategoryId =
                    widget.foodCategoryList[selectedPosition].subCategories[subCategoryIndex].id;
                return GestureDetector(
                  onTap: () {
                    if (subCategoryListToBeAdded.contains(subCategoryId)) {
                      subCategoryListToBeAdded.remove(subCategoryId);
                    } else {
                      subCategoryListToBeAdded.add(subCategoryId);
                    }
                    print("subCategoryList===================> $subCategoryListToBeAdded");
                    _bloc?.selectedSubCategorySubject.sink.add(subCategoryListToBeAdded);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSubCatIdSelected ? colorPrimary : colorPrimaryLight,
                      borderRadius: BorderRadiusDirectional.circular(borderRadius30px),
                    ),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      widget.foodCategoryList[selectedPosition].subCategories[subCategoryIndex].name,
                      style: bodyText(
                        fontSize: textSize15px,
                        textColor: isSubCatIdSelected ? colorWhite : colorPrimary,
                        fontWeight: isSubCatIdSelected ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        SizedBox(height: commonPadding10px),
        Divider(color: colorPrimaryLight),
        SizedBox(height: commonPadding20px),
      ],
    );
  }

  Widget _sliderSection(int selectedPosition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          languages.price,
          style: bodyText(fontSize: textSize20px, textColor: colorPrimary, fontWeight: FontWeight.w500),
        ),
        StreamBuilder<num>(
          stream: _bloc?.selectedRangeSubject,
          builder: (context, snapSelectedRange) {
            final List<double> priceSteps = [1, 10, 50, 100];
            num selectedValue =
                snapSelectedRange.data ?? widget.foodCategoryList[selectedPosition].selectedPrice;
            int index = priceSteps.indexOf(selectedValue.toDouble());
            if (index == -1) index = 0;
            return Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackShape: const RoundedRectSliderTrackShape(),
                    trackHeight: 2.0,
                    activeTrackColor: colorPrimary,
                    inactiveTrackColor: Colors.grey[300],
                    thumbColor: colorPrimary,
                    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 9),
                    overlayColor: colorPrimary.withOpacity(0.2),
                    valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                    valueIndicatorColor: colorPrimary,
                    valueIndicatorTextStyle: bodyText(fontSize: textSize14px),
                    showValueIndicator: ShowValueIndicator.onlyForDiscrete,
                  ),
                  child: Slider(
                    min: 0,
                    max: 3,
                    divisions: 3,
                    label: "\$${priceSteps[index].toInt()}",
                    value: index.toDouble(),
                    onChanged: (value) {
                      int newIndex = value.round();
                      double newPrice = priceSteps[newIndex];
                      _bloc?.selectedRangeSubject.sink.add(newPrice);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(horizontal: commonPadding20px),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$1", style: bodyText(textColor: colorCommonBrown)),
                      Text("\$10", style: bodyText(textColor: colorCommonBrown)),
                      Text("\$50", style: bodyText(textColor: colorCommonBrown)),
                      Text("\$100 >", style: bodyText(textColor: colorCommonBrown)),
                    ],
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}
