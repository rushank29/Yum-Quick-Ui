import 'package:flutter/material.dart';

import 'item_best_seller_widget.dart';
import '../../constant/colors.dart';
import '../../constant/dimensions.dart';
import '../../customWidget/common_bg_screen.dart';
import '../../customWidget/no_record_found.dart';
import '../../main.dart';
import '../../utils/response_util.dart';
import '../../utils/text_style.dart';
import '../../constant/constant.dart';
import 'best_seller_bloc.dart';
import 'best_seller_dl.dart';
import 'best_seller_shimmer.dart';

class BestSellerScreen extends StatefulWidget {
  const BestSellerScreen({super.key});

  @override
  State<BestSellerScreen> createState() => _BestSellerScreenState();
}

class _BestSellerScreenState extends State<BestSellerScreen> {
  BestSellerBloc? _bloc;

  @override
  void didChangeDependencies() {
    _bloc ??= BestSellerBloc();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackgroundWidget(
      pageTitle: languages.bestSeller,
      bodyWidget: Column(
        children: [
          Text(
            languages.discoverPopularDishes,
            style: bodyText(
              fontSize: textSize20px,
              fontWeight: FontWeight.w500,
              textColor: colorPrimary,
            ),
          ),
          SizedBox(height: commonPadding24px),
          StreamBuilder<ResponseUtil<BestSellerPojo>>(
            stream: _bloc?.subject,
            builder: (context, snapshot) {
              BestSellerPojo? data = snapshot.data?.data;
              switch (snapshot.data?.status ?? Status.loading) {
                case Status.loading:
                  return const BestSellerShimmer();
                case Status.completed:
                  return _bestSellerBody(data);
                case Status.error:
                  return const NoRecordFound();
              }
            },
          )
        ],
      ),
    );
  }

  Widget _bestSellerBody(BestSellerPojo? data) {
    List<ItemBestSellerList> bestSellers = data?.bestSellerList ?? [];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsetsDirectional.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: commonPadding10px,
        mainAxisSpacing: commonPadding10px,
        childAspectRatio: 0.635,
      ),
      itemCount: bestSellers.length,
      itemBuilder: (context, index) {
        ItemBestSellerList itemBestSellers = bestSellers[index];
        return ItemBestSellerWidget(itemBestSellers: itemBestSellers);
      },
    );
  }
}
