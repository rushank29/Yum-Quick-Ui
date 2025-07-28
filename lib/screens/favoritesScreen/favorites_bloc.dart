import 'package:rxdart/rxdart.dart';

import '../../customWidget/networkConnectivityChecker/internet_service.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';
import 'favorites_dl.dart';
import 'favorites_json.dart';

class FavoritesBloc {
  FavoritesBloc() {
    getFavoritesData();
  }

  final subject = BehaviorSubject<ResponseUtil<FavoritesPojo>>();

  void getFavoritesData() async {
    InternetService().runWhenOnline(() async {
      try {
        subject.sink.add(ResponseUtil.loading());
        await Future.delayed(const Duration(seconds: 2));
        var response = FavoritesPojo.fromJson(favoritesJson);
        subject.sink.add(ResponseUtil.completed(response));
      } catch (error) {
        subject.sink.add(ResponseUtil.error(error.toString()));
        openSimpleSnackBar(error.toString());
      }
    });
  }
}
