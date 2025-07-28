import 'package:rxdart/rxdart.dart';

import '../../customWidget/networkConnectivityChecker/internet_service.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';
import 'recommended_dl.dart';
import 'recommended_json.dart';

class RecommendedBloc {
  RecommendedBloc() {
    getRecommendedData();
  }

  final subject = BehaviorSubject<ResponseUtil<RecommendedPojo>>();

  void getRecommendedData() async {
    InternetService().runWhenOnline(() async {
      try {
        subject.sink.add(ResponseUtil.loading());
        await Future.delayed(const Duration(seconds: 2));
        var response = RecommendedPojo.fromJson(recommendedJson);
        subject.sink.add(ResponseUtil.completed(response));
      } catch (error) {
        subject.sink.add(ResponseUtil.error(error.toString()));
        openSimpleSnackBar(error.toString());
      }
    });
  }

  void dispose() {
    subject.close();
  }
}
