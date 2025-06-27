import 'package:rxdart/rxdart.dart';

import '../../utils/response_util.dart';
import '../../utils/utils.dart';
import 'best_seller_dl.dart';
import 'best_seller_json.dart';

class BestSellerBloc {
  BestSellerBloc() {
    getBestSellerData();
  }

  final subject = BehaviorSubject<ResponseUtil<BestSellerPojo>>();

  void getBestSellerData() async {
    try {
      subject.sink.add(ResponseUtil.loading());
      await Future.delayed(const Duration(seconds: 2));
      var response = BestSellerPojo.fromJson(bestSellerJson);
      subject.sink.add(ResponseUtil.completed(response));
    } catch (error) {
      subject.sink.add(ResponseUtil.error(error.toString()));
      openSimpleSnackBar(error.toString());
    }
  }

  void dispose() {
    subject.close();
  }
}
