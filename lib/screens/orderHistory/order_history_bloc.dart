import 'package:rxdart/rxdart.dart';

import '../../customWidget/networkConnectivityChecker/internet_service.dart';
import '../../utils/response_util.dart';
import '../../utils/utils.dart';
import 'order_history_list_dl.dart';
import 'order_history_json.dart';

class OrderHistoryBloc {
  OrderHistoryBloc() {
    getOrderHistory();
  }

  final subject = BehaviorSubject<ResponseUtil<OrderHistoryPojo>>();

  void getOrderHistory() async {
    subject.sink.add(ResponseUtil.loading());
    InternetService().runWhenOnline(() async {
      try {
        await Future.delayed(const Duration(seconds: 3));
        var response = OrderHistoryPojo.fromJson(orderHistoryJson);
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
