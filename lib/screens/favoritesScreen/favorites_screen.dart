import 'package:flutter/material.dart';

import '../../constant/constant.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../customWidget/no_record_found.dart';
import '../../main.dart';
import '../../utils/response_util.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/custom_image.dart';
import '../../utils/text_style.dart';
import '../../utils/utils.dart';
import 'favorites_bloc.dart';
import 'favorites_dl.dart';
import 'favorites_shimmer.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoritesBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= FavoritesBloc();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      showBackButton: false,
      pageTitle: languages.favorites,
      bodyWidget: Column(
        children: [
          Text(
            languages.itsTimeToBuyFavoriteDish,
            style: bodyText(
              fontSize: textSize20px,
              fontWeight: FontWeight.w500,
              textColor: colorPrimary,
            ),
          ),
          SizedBox(height: commonPadding10px),
          StreamBuilder<ResponseUtil<FavoritesPojo>>(
            stream: _bloc?.subject,
            builder: (context, snapshot) {
              switch (snapshot.data?.status ?? Status.loading) {
                case Status.loading:
                  return const FavoritesShimmer();
                case Status.completed:
                  return _favoritesBody(snapshot.data?.data);
                case Status.error:
                  return const NoRecordFound();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _favoritesBody(FavoritesPojo? data) {
    List<ItemFavoriteList> favorites = data?.favoriteList ?? [];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: commonPadding10px,
        mainAxisSpacing: commonPadding10px,
        childAspectRatio: 0.71,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        ItemFavoriteList itemFavorites = favorites[index];
        return _itemFavoritesGrid(itemFavorites);
      },
    );
  }

  Widget _itemFavoritesGrid(ItemFavoriteList itemFavorites) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            CustomImage(
              imagePath: itemFavorites.productImage,
              width: deviceWidth,
              height: deviceHeight * 0.2,
              borderRadius: BorderRadius.circular(borderRadius20px),
              fit: BoxFit.cover,
            ),
            Container(
              margin: EdgeInsetsDirectional.only(top: commonPadding10px, start: commonPadding10px),
              padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.008945),
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadiusDirectional.circular(borderRadius10px),
              ),
              child: getFoodCategoryTypeIcon(itemFavorites.foodCategoryType),
            ),
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: Container(
                margin: EdgeInsetsDirectional.only(top: commonPadding10px, end: commonPadding10px),
                padding: EdgeInsetsDirectional.all(deviceAvgScreenSize * 0.008945),
                decoration: BoxDecoration(
                  color: colorWhite,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.favorite,
                  color: colorPrimary,
                  size: iconSize15px,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: commonPadding10px),
        Text(
          itemFavorites.productName,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: bodyText(
            fontSize: textSize16px,
            textColor: colorPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          itemFavorites.productDescription,
          maxLines: 2,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: bodyText(
            fontSize: textSize12px,
            textColor: colorCommonBrown,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
