import 'package:shimmer/shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../main.dart';
import '../bestSeller/best_seller_screen.dart';
import '../productDetailScreen/product_detail_screen.dart';
import '../../constant/colors.dart';
import '../../constant/constant.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_image.dart';
import '../../customWidget/custom_text_form_field.dart';
import '../filterScreen/filter_screen.dart';
import '../recommendedScreen/recommended_screen.dart';
import 'home_bloc.dart';
import 'home_dl.dart';
import 'home_shimmer.dart';
import '../../utils/response_util.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc = HomeBloc(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorCommonBackground,
      body: StreamBuilder<ResponseUtil<HomePojo>>(
        stream: _bloc?.subject,
        builder: (context, snapHomeData) {
          HomePojo? data = snapHomeData.data?.data;
          return _homeBody(data);
        },
      ),
    );
  }

  Widget _homeBody(HomePojo? data) {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(minHeight: deviceHeight),
        child: Column(
          children: [
            Container(
              padding:
                  EdgeInsetsDirectional.only(start: commonPadding32px, top: deviceAvgScreenSize * 0.11738),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          backgroundColor: colorWhite,
                          formFieldHeight: commonSize45px * 0.9,
                          hintText: languages.search,
                          suffixPadding: EdgeInsetsDirectional.all(commonPadding10px * 0.5),
                          contentPadding: EdgeInsetsDirectional.symmetric(
                              horizontal: commonPadding10px, vertical: commonPadding10px * 0),
                          suffix: Container(
                            margin: EdgeInsetsDirectional.only(start: commonPadding10px * 0.7),
                            decoration: BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadiusDirectional.all(Radius.circular(borderRadius10px))),
                            child: SvgPicture.asset(
                              "assets/svg/shuffle.svg",
                              height: iconSize20px,
                              width: iconSize20px,
                              colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
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
                      SizedBox(width: commonPadding10px * 0.7),
                      GestureDetector(
                        onTap: () {
                          selectedDrawerIndexSubject.sink.add(2);
                        },
                        child: commonHomeHeaderIcon("assets/svg/bell.svg"),
                      ),
                      SizedBox(width: commonPadding10px * 0.7),
                      GestureDetector(
                          onTap: () {
                            selectedDrawerIndexSubject.sink.add(1);
                          },
                          child: commonHomeHeaderIcon("assets/svg/person.svg")),
                      SizedBox(width: commonPadding32px),
                    ],
                  ),
                  StreamBuilder<ResponseUtil<HomePojo>>(
                    stream: _bloc?.subject,
                    builder: (context, snapStatus) {
                      if (snapStatus.data?.status == Status.loading) {
                        return Shimmer.fromColors(
                          baseColor: colorShimmerBase,
                          highlightColor: colorShimmerHighlight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsetsDirectional.only(top: commonPadding16px),
                                width: deviceWidth * 0.5,
                                height: deviceAvgScreenSize * 0.04,
                                color: colorBlack,
                              ),
                              SizedBox(height: deviceAvgScreenSize * 0.01),
                              Container(
                                margin: EdgeInsetsDirectional.only(bottom: commonPadding16px),
                                width: deviceWidth * 0.35,
                                height: deviceAvgScreenSize * 0.025,
                                color: colorBlack,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          alignment: AlignmentDirectional.topStart,
                          margin:
                              EdgeInsetsDirectional.only(top: commonPadding16px, bottom: commonPadding16px),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data?.greetingMessageMain ?? "",
                                style: bodyText(fontWeight: FontWeight.w700, fontSize: textSize30px),
                              ),
                              Text(
                                data?.greetingMessageSub ?? "",
                                style: bodyText(
                                  fontWeight: FontWeight.w500,
                                  fontSize: textSize13px,
                                  textColor: colorPrimary,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            StreamBuilder<ResponseUtil<HomePojo>>(
                stream: _bloc?.subject,
                builder: (context, snapStatus) {
                  if ((snapStatus.data?.status ?? Status.loading) == Status.loading) {
                    return const HomeShimmer();
                  } else {
                    return Container(
                      constraints: BoxConstraints(minHeight: deviceHeight),
                      padding: EdgeInsetsDirectional.symmetric(horizontal: commonPadding35px),
                      decoration: BoxDecoration(
                        color: colorHomeBackground,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(borderRadius30px),
                          topEnd: Radius.circular(borderRadius30px),
                        ),
                      ),
                      child: Column(
                        children: [
                          _foodCategorySection(data),
                          Divider(color: colorDividerOrange),
                          _bestSellerSection(data),
                          _sliderSection(data),
                          _recommendedSection(data),
                        ],
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget _foodCategorySection(HomePojo? data) {
    return Container(
      margin: EdgeInsetsDirectional.only(
        top: commonPadding32px,
        bottom: commonPadding10px * 1.4,
      ),
      height: commonSize75px,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data?.foodCategories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              openScreen(
                context: context,
                screen: FilterScreen(
                  foodCategoryList: data?.foodCategories ?? [],
                  selectedIndex: index,
                ),
              );
            },
            child: Container(
              margin: EdgeInsetsDirectional.only(
                  end: index < (data?.foodCategories.length ?? 0) - 1 ? commonPadding20px : 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.all(commonPadding10px),
                    decoration: BoxDecoration(
                      color: colorPeach,
                      borderRadius: BorderRadiusDirectional.all(
                        Radius.circular(borderRadius30px),
                      ),
                    ),
                    child: SvgPicture.asset(
                      data?.foodCategories[index].categoryIcon ?? "",
                      height: iconSize37px,
                      width: iconSize33px,
                      colorFilter: ColorFilter.mode(colorPrimary, BlendMode.srcIn),
                    ),
                  ),
                  Text(
                    data?.foodCategories[index].categoryName ?? "",
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
    );
  }

  Widget _bestSellerSection(HomePojo? data) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: commonPadding10px * 1.4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languages.bestseller2,
                style: bodyText(
                  fontSize: textSize20px,
                  fontWeight: FontWeight.w500,
                  textColor: colorCommonBrown,
                ),
              ),
              if ((data?.bestSellerFoodItems.length ?? 0) >= 4)
                GestureDetector(
                  onTap: () {
                    openScreen(context: context, screen: const BestSellerScreen());
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        languages.viewAll,
                        style: bodyText(
                          fontWeight: FontWeight.w600,
                          textColor: colorPrimary,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: colorPrimary,
                        size: iconSize24px,
                      ),
                    ],
                  ),
                ),
            ],
          ),
          Container(
            margin: EdgeInsetsDirectional.only(
              top: commonPadding10px * 1.4,
              bottom: commonPadding20px,
            ),
            height: commonSize120px,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: data?.bestSellerFoodItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsetsDirectional.only(end: index < 3 ? commonPadding10px : 0),
                  child: Stack(
                    children: [
                      CustomImage(
                        imagePath: data?.bestSellerFoodItems[index].itemImage ?? "",
                        height: commonSize120px,
                        width: commonSize75px,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        bottom: commonPadding10px * 1.2,
                        right: -commonPadding10px * 0.132,
                        child: Container(
                          padding: EdgeInsetsDirectional.all(commonPadding10px * 0.5),
                          decoration: BoxDecoration(
                            color: colorPrimary,
                            borderRadius: BorderRadiusDirectional.only(
                              topStart: Radius.circular(borderRadius30px),
                              bottomStart: Radius.circular(borderRadius30px),
                            ),
                          ),
                          child: Text(
                            getAmountWithCurrency(data?.bestSellerFoodItems[index].itemPrice ?? 0),
                            style: bodyText(fontSize: textSize12px),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _sliderSection(HomePojo? data) {
    return StreamBuilder<int>(
      stream: _bloc?.selectedIndexSubject,
      builder: (context, snapSelectedIndex) {
        int selectedIndex = snapSelectedIndex.data ?? 0;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider.builder(
              itemCount: data?.homePageSlider.length,
              options: CarouselOptions(
                height: commonSize128px,
                enableInfiniteScroll: true,
                viewportFraction: 1,
                autoPlay: true,
                onPageChanged: (position, reason) {
                  _bloc?.selectedIndexSubject.sink.add(position);
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return GestureDetector(
                  onTap: () {
                    openScreen(
                      context: context,
                      screen: ProductDetailScreen(productItem: data!.homePageSlider[index].productItem[0]),
                    );
                  },
                  child: Stack(
                    children: [
                      CustomImage(
                        imagePath: data?.homePageSlider[index].sliderImage ?? '',
                        height: commonSize120px,
                        borderRadius: BorderRadius.all(Radius.circular(borderRadius20px)),
                      ),
                      Positioned(
                        top: commonPadding28px,
                        left: commonPadding10px * 1.25,
                        child: SizedBox(
                          width: deviceWidth * 0.35,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                data?.homePageSlider[index].sliderMsg1 ?? '',
                                textAlign: TextAlign.center,
                                style: bodyText(
                                  fontWeight: FontWeight.w400,
                                  fontSize: textSize16px,
                                ),
                              ),
                              Text(
                                data?.homePageSlider[index].sliderMsg2 ?? '',
                                textAlign: TextAlign.center,
                                style: bodyText(
                                  fontWeight: FontWeight.w700,
                                  fontSize: textSize32px,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            customCarouselIndicator(selectedIndex, 5),
          ],
        );
      },
    );
  }

  Widget _recommendedSection(HomePojo? data) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: commonPadding20px),
      alignment: AlignmentDirectional.topStart,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                languages.recommended,
                style: bodyText(
                  textColor: colorCommonBrown,
                  fontSize: textSize20px,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: () {
                  openScreen(context: context, screen: const RecommendedScreen());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      languages.viewAll,
                      style: bodyText(
                        fontWeight: FontWeight.w600,
                        textColor: colorPrimary,
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: colorPrimary,
                      size: iconSize24px,
                    ),
                  ],
                ),
              ),
            ],
          ),
          GridView.builder(
            itemCount: data?.recommendedFoodItems.length,
            shrinkWrap: true,
            padding: EdgeInsetsDirectional.symmetric(vertical: commonPadding10px),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: commonPadding10px * 0.8,
              mainAxisSpacing: commonPadding10px * 1.6,
            ),
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  CustomImage(
                    imagePath: data?.recommendedFoodItems[index].itemImage ?? "",
                    borderRadius: BorderRadius.all(
                      Radius.circular(borderRadius20px),
                    ),
                  ),
                  Positioned(
                    bottom: commonPadding10px * 1.2,
                    right: -commonPadding10px * 0.132,
                    child: Container(
                      padding: EdgeInsetsDirectional.all(commonPadding10px * 0.5),
                      decoration: BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(borderRadius30px),
                          bottomStart: Radius.circular(borderRadius30px),
                        ),
                      ),
                      child: Text(
                        getAmountWithCurrency(data?.recommendedFoodItems[index].itemPrice ?? 0),
                        style: bodyText(fontSize: textSize12px),
                      ),
                    ),
                  ),
                  Positioned(
                    top: commonPadding10px,
                    left: commonPadding10px * 1.1,
                    child: Container(
                      padding: EdgeInsetsDirectional.all(commonPadding10px * 0.5),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadiusDirectional.all(
                          Radius.circular(borderRadius30px),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            (data?.recommendedFoodItems[index].itemRating ?? 0).toStringAsFixed(2),
                            style: bodyText(
                              fontSize: textSize12px,
                              textColor: colorCommonBrown,
                            ),
                          ),
                          Container(
                            margin: EdgeInsetsDirectional.only(
                              start: commonPadding10px * 0.4,
                              bottom: commonPadding10px * 0.2,
                            ),
                            child: SvgPicture.asset(
                              "assets/svg/rating_star_filled.svg",
                              colorFilter: ColorFilter.mode(colorRatingStar, BlendMode.srcIn),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
