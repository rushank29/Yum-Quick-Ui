import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tab_container/tab_container.dart';

import '../../customWidget/custom_image.dart';
import '../../customWidget/networkConnectivityChecker/connectivity_banner.dart';
import '../../customWidget/no_record_found.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';
import '../../constant/colors.dart';
import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_text_form_field.dart';
import '../../main.dart';
import '../../utils/text_style.dart';
import '../productDetailScreen/product_detail_screen.dart';
import 'dishes_bloc.dart';
import 'dishes_dl.dart';
import 'dishes_shimmer.dart';

class DishesScreen extends StatefulWidget {
  const DishesScreen({super.key});

  @override
  State<DishesScreen> createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> with TickerProviderStateMixin {
  DishesBloc? _bloc;
  TabController? _tabController;

  @override
  void didChangeDependencies() {
    _bloc ??= DishesBloc(context);
    _tabController ??= TabController(length: 5, vsync: this);
    _tabController!.addListener(() {
      if (_tabController!.indexIsChanging == false) {
        _bloc?.currentIndexSubject.sink.add(_tabController!.index);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController?.removeListener(() {});
    _tabController?.dispose();
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCommonBackground,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsetsDirectional.only(start: commonPadding32px, top: deviceHeight * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _topSection(),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(top: commonPadding20px),
                  width: deviceWidth,
                  decoration: BoxDecoration(
                    color: colorPrimary,
                    borderRadius: BorderRadiusDirectional.only(
                      topStart: Radius.circular(borderRadius30px),
                      topEnd: Radius.circular(borderRadius30px),
                    ),
                  ),
                  child: StreamBuilder<ResponseUtil<DishesPojo>>(
                    stream: _bloc?.subject,
                    builder: (context, snapDishes) {
                      switch (snapDishes.data?.status ?? Status.loading) {
                        case Status.loading:
                          return const DishesShimmer();
                        case Status.completed:
                          DishesPojo? data = snapDishes.data?.data;
                          List<FoodCategories> foodCategoryList = data?.foodCategories ?? [];
                          _tabController ??= TabController(length: foodCategoryList.length, vsync: this);
                          return _dishesBody(_tabController!, data, foodCategoryList);
                        case Status.error:
                          return const NoRecordFound();
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ConnectivityBanner(),
          ),
        ],
      ),
    );
  }

  Widget _dishesBody(TabController tabController, DishesPojo? data, List<FoodCategories> foodCategoryList) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: commonPadding20px),
      child: TabContainer(
        controller: tabController,
        tabEdge: TabEdge.top,
        tabsStart: 0.1,
        tabsEnd: 0.9,
        tabMaxLength: 400,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius30px),
          bottomRight: Radius.circular(borderRadius30px),
        ),
        tabBorderRadius: BorderRadius.circular(borderRadius30px),
        // childPadding: EdgeInsets.all(commonPadding20px),
        selectedTextStyle: bodyText(fontSize: textSize12px, textColor: colorCommonBrown),
        unselectedTextStyle: bodyText(fontSize: textSize12px, textColor: colorCommonBrown),
        colors: [
          colorMainBackground,
          colorMainBackground,
          colorMainBackground,
          colorMainBackground,
          colorMainBackground,
        ],
        tabs: List.generate(
          foodCategoryList.length,
          (i) {
            return Text(
              foodCategoryList[i].categoryName,
              style: bodyText(
                fontSize: textSize12px,
                textColor: colorCommonBrown,
              ),
            );
          },
        ),
        children: List.generate(
          foodCategoryList.length,
          (pos) {
            return StreamBuilder<int>(
              stream: _bloc?.currentIndexSubject,
              builder: (context, snapCurrentIndex) {
                int currentIndex = snapCurrentIndex.data ?? 0;
                if (pos != currentIndex) return const SizedBox.shrink();
                return _tabBody(foodCategoryList, currentIndex, pos);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _topSection() {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            backgroundColor: colorWhite,
            formFieldHeight: commonSize45px * 0.9,
            hintText: languages.search,
            suffixPadding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.008945),
            borderRadius: BorderRadius.circular(deviceAvgScreenSize * 0.05),
            contentPadding: EdgeInsetsDirectional.symmetric(
                horizontal: commonPadding10px, vertical: commonPadding10px * 0),
            suffix: Container(
              margin: EdgeInsetsDirectional.only(start: deviceAvgScreenSize * 0.012523),
              padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.0175),
              decoration: BoxDecoration(
                color: colorPrimary,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                "assets/svg/shuffle.svg",
                height: iconSize15px,
                width: iconSize15px,
                colorFilter: ColorFilter.mode(colorWhite, BlendMode.srcIn),
              ),
            ),
          ),
        ),
        SizedBox(width: commonPadding32px),
        GestureDetector(
          onTap: () {
            selectedDrawerIndexSubject.sink.add(3);
          },
          child: commonHomeHeaderIcon("assets/svg/cart.svg"),
        ),
        SizedBox(width: deviceAvgScreenSize * 0.012523),
        GestureDetector(
          onTap: () {
            selectedDrawerIndexSubject.sink.add(2);
          },
          child: commonHomeHeaderIcon("assets/svg/bell.svg"),
        ),
        SizedBox(width: deviceAvgScreenSize * 0.012523),
        GestureDetector(
            onTap: () {
              selectedDrawerIndexSubject.sink.add(1);
            },
            child: commonHomeHeaderIcon("assets/svg/person.svg")),
        SizedBox(width: commonPadding32px),
      ],
    );
  }

  Widget _tabBody(List<FoodCategories> foodCategoryList, int currentIndex, int pos) {
    return Container(
      width: deviceWidth,
      decoration: BoxDecoration(
        color: colorMainBackground,
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(borderRadius30px),
          topEnd: Radius.circular(borderRadius30px),
        ),
      ),
      padding: EdgeInsetsDirectional.only(
          start: commonPadding32px, end: commonPadding32px, top: commonPadding20px),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    languages.sortBy,
                    style: bodyText(
                      fontSize: textSize12px,
                      textColor: colorTextCommonBlack,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(width: commonPadding10px),
                  Text(
                    languages.popular,
                    style: bodyText(
                      fontSize: textSize12px,
                      textColor: colorPrimary,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.015),
                decoration: BoxDecoration(
                  color: colorPrimary,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  "assets/svg/shuffle.svg",
                  height: deviceAvgScreenSize * 0.015,
                  width: deviceAvgScreenSize * 0.015,
                  colorFilter: ColorFilter.mode(colorWhite, BlendMode.srcIn),
                ),
              )
            ],
          ),
          SizedBox(height: commonPadding16px),
          ListView.separated(
            itemCount: foodCategoryList[pos].productItem.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsetsDirectional.zero,
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Container(
                margin: EdgeInsetsDirectional.only(bottom: commonPadding10px),
                child: Divider(color: colorPrimaryLight),
              );
            },
            itemBuilder: (context, position) {
              ProductItem productItem = foodCategoryList[pos].productItem[position];
              return GestureDetector(
                onTap: () {
                  openScreen(
                    context: context,
                    screen: ProductDetailScreen(
                      productItem: productItem,
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsetsDirectional.only(bottom: commonPadding10px),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImage(
                        imagePath: productItem.dishImage,
                        width: deviceWidth,
                        height: deviceHeight * 0.2,
                        borderRadius: BorderRadius.circular(borderRadius36px),
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: commonPadding10px),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        productItem.dishName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: bodyText(
                                          fontSize: textSize18px,
                                          textColor: colorCommonBrown,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: deviceAvgScreenSize * 0.008,
                                      width: deviceAvgScreenSize * 0.008,
                                      margin: EdgeInsetsDirectional.symmetric(
                                        horizontal: commonPadding10px,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorPrimary,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.0075),
                                      decoration: BoxDecoration(
                                        color: colorPrimary,
                                        borderRadius: BorderRadiusDirectional.circular(borderRadius30px),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "${productItem.dishRating}",
                                            style: bodyText(
                                              fontSize: textSize12px,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(width: deviceWidth * 0.01),
                                          Container(
                                            padding: EdgeInsetsDirectional.only(
                                              bottom: deviceHeight * 0.005,
                                            ),
                                            child: SvgPicture.asset(
                                              "assets/svg/rating_star_filled.svg",
                                              colorFilter: ColorFilter.mode(colorRatingStar, BlendMode.srcIn),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: deviceHeight * 0.002),
                                Flexible(
                                  child: Text(
                                    productItem.shortDescription,
                                    style: bodyText(
                                      fontSize: textSize12px,
                                      textColor: colorCommonBrown,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(start: commonPadding28px),
                            child: Text(
                              getAmountWithCurrency(productItem.dishPrice),
                              style: bodyText(
                                fontSize: textSize18px,
                                textColor: colorPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

// Widget _triedCode() {
// return Column(
//   children: [
//     Container(
//       margin: EdgeInsetsDirectional.only(top: commonPadding20px),
//       height: deviceAvgScreenSize * 0.15,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: foodCategoryList.length,
//         itemBuilder: (context, index) {
//           return StreamBuilder<int>(
//             stream: _bloc?.selectedIndexSubject,
//             builder: (context, snapSelectedIndex) {
//               int selectedIndex = snapSelectedIndex.data ?? 0;
//               bool isIndexSelected = selectedIndex == index;
//               return GestureDetector(
//                 onTap: () {
//                   _bloc?.selectedIndexSubject.sink.add(index);
//                 },
//                 child: Container(
//                   margin: EdgeInsetsDirectional.only(
//                     start: isIndexSelected ? commonPadding10px : commonPadding20px,
//                     end: isIndexSelected ? commonPadding10px : commonPadding20px,
//                     top: isIndexSelected ? 0 : commonPadding10px,
//                   ),
//                   padding: EdgeInsetsDirectional.only(
//                     start: isIndexSelected ? commonPadding10px : 0,
//                     end: isIndexSelected ? commonPadding10px : 0,
//                     top: isIndexSelected ? commonPadding10px : 0,
//                   ),
//                   decoration: BoxDecoration(
//                     color: isIndexSelected ? colorMainBackground : Colors.transparent,
//                     borderRadius: BorderRadiusDirectional.only(
//                       topStart: isIndexSelected ? Radius.circular(borderRadius30px) : Radius.zero,
//                       topEnd: isIndexSelected ? Radius.circular(borderRadius30px) : Radius.zero,
//                       bottomStart: isIndexSelected ? Radius.circular(borderRadius30px) : Radius.zero,
//                       bottomEnd: isIndexSelected ? Radius.circular(borderRadius30px) : Radius.zero,
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         padding: EdgeInsetsDirectional.all(commonPadding10px),
//                         decoration: BoxDecoration(
//                           color: isIndexSelected ? colorCommonBackground : colorPeach,
//                           borderRadius: BorderRadiusDirectional.all(
//                             Radius.circular(borderRadius30px),
//                           ),
//                         ),
//                         child: SvgPicture.asset(
//                           foodCategoryList[index].categoryIcon,
//                           height: iconSize37px,
//                           width: iconSize33px,
//                           colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
//                         ),
//                       ),
//                       Text(
//                         foodCategoryList[index].categoryName,
//                         style: bodyText(
//                           fontSize: textSize12px,
//                           textColor: colorCommonBrown,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     ),
//     Container(
//       width: deviceWidth,
//       decoration: BoxDecoration(
//         color: colorMainBackground,
//         borderRadius: BorderRadiusDirectional.only(
//           topStart: Radius.circular(borderRadius30px),
//           topEnd: Radius.circular(borderRadius30px),
//         ),
//       ),
//       padding: EdgeInsetsDirectional.only(
//           start: commonPadding32px, end: commonPadding32px, top: commonPadding20px),
//       child: StreamBuilder<int>(
//         stream: _bloc?.selectedIndexSubject,
//         builder: (context, snapSelectedIndex) {
//           int selectedIndex = snapSelectedIndex.data ?? 0;
//           return Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         "Sort by",
//                         style: bodyText(
//                           fontSize: textSize12px,
//                           textColor: colorTextCommonBlack,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                       SizedBox(width: commonPadding10px),
//                       Text(
//                         "Popular",
//                         style: bodyText(
//                           fontSize: textSize12px,
//                           textColor: colorPrimary,
//                           fontWeight: FontWeight.w300,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Container(
//                     padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.015),
//                     decoration: BoxDecoration(
//                       color: colorPrimary,
//                       shape: BoxShape.circle,
//                     ),
//                     child: SvgPicture.asset(
//                       "assets/svg/shuffle.svg",
//                       height: deviceAvgScreenSize * 0.015,
//                       width: deviceAvgScreenSize * 0.015,
//                       colorFilter: ColorFilter.mode(colorWhite, BlendMode.srcIn),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(height: commonPadding16px),
//               ListView.separated(
//                 itemCount: foodCategoryList[selectedIndex].productItem.length,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: EdgeInsetsDirectional.zero,
//                 shrinkWrap: true,
//                 separatorBuilder: (context, index) {
//                   return Container(
//                     margin: EdgeInsetsDirectional.only(bottom: commonPadding10px),
//                     child: Divider(color: colorPrimaryLight),
//                   );
//                 },
//                 itemBuilder: (context, position) {
//                   ProductItem productItem = foodCategoryList[selectedIndex].productItem[position];
//                   return GestureDetector(
//                     onTap: () {
//                       openScreen(
//                         context: context,
//                         screen: ProductDetailScreen(
//                           productItem: productItem,
//                         ),
//                       );
//                     },
//                     child: Container(
//                       margin: EdgeInsetsDirectional.only(bottom: commonPadding10px),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           CustomImage(
//                             imagePath: productItem.dishImage,
//                             width: deviceWidth,
//                             height: deviceHeight * 0.2,
//                             borderRadius: BorderRadius.circular(borderRadius36px),
//                             fit: BoxFit.cover,
//                           ),
//                           SizedBox(height: commonPadding10px),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Flexible(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisSize: MainAxisSize.min,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Text(
//                                           productItem.dishName,
//                                           style: bodyText(
//                                             fontSize: textSize18px,
//                                             textColor: colorCommonBrown,
//                                             fontWeight: FontWeight.w600,
//                                           ),
//                                         ),
//                                         Container(
//                                           height: deviceAvgScreenSize * 0.008,
//                                           width: deviceAvgScreenSize * 0.008,
//                                           margin: EdgeInsetsDirectional.symmetric(
//                                             horizontal: commonPadding10px,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             shape: BoxShape.circle,
//                                             color: colorPrimary,
//                                           ),
//                                         ),
//                                         Container(
//                                           padding:
//                                           EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.0075),
//                                           decoration: BoxDecoration(
//                                             color: colorPrimary,
//                                             borderRadius:
//                                             BorderRadiusDirectional.circular(borderRadius30px),
//                                           ),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Text(
//                                                 "${productItem.dishRating}",
//                                                 style: bodyText(
//                                                   fontSize: textSize12px,
//                                                   fontWeight: FontWeight.w400,
//                                                 ),
//                                               ),
//                                               SizedBox(width: deviceWidth * 0.01),
//                                               Container(
//                                                 padding: EdgeInsetsDirectional.only(
//                                                   bottom: deviceHeight * 0.005,
//                                                 ),
//                                                 child: SvgPicture.asset(
//                                                   "assets/svg/rating_star_filled.svg",
//                                                   colorFilter:
//                                                   ColorFilter.mode(colorRatingStar, BlendMode.srcIn),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     SizedBox(height: deviceHeight * 0.002),
//                                     Flexible(
//                                       child: Text(
//                                         productItem.shortDescription,
//                                         style: bodyText(
//                                           fontSize: textSize12px,
//                                           textColor: colorCommonBrown,
//                                           fontWeight: FontWeight.w300,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsetsDirectional.only(start: commonPadding28px),
//                                 child: Text(
//                                   getAmountWithCurrency(productItem.dishPrice),
//                                   style: bodyText(
//                                     fontSize: textSize18px,
//                                     textColor: colorPrimary,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ],
//           );
//         },
//       ),
//     ),
//   ],
// );
// }
}
