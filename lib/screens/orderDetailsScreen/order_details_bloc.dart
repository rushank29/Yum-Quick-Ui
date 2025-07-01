import 'package:food_ui/main.dart';
import 'package:rxdart/rxdart.dart';

import '../orderHistory/order_history_list_dl.dart';
import '../../customWidget/keyValuePair/item_key_value_pair_dl.dart';
import '../../utils/utils.dart';

class OrderDetailsBloc {
  final ItemOrderList item;

  OrderDetailsBloc(this.item) {
    setKeyValueData();
  }

  final subjectKeyValueList = BehaviorSubject<List<ItemKeyValuePair>>();

  void setKeyValueData() {
    List<ItemKeyValuePair> keyValueList = [];
    dynamic subtotal = item.subTotal ?? 0;
    dynamic taxAndFees = item.taxAndFees ?? 0;
    dynamic deliveryFees = item.deliveryFees ?? 0;
    dynamic total = subtotal + taxAndFees + deliveryFees;
    keyValueList.add(ItemKeyValuePair(title: languages.subTotal, value: getAmountWithCurrency(subtotal)));
    keyValueList.add(
      ItemKeyValuePair(title: languages.taxAndFees, value: getAmountWithCurrency(taxAndFees)),
    );
    keyValueList.add(
      ItemKeyValuePair(title: languages.delivery, value: getAmountWithCurrency(deliveryFees)),
    );
    keyValueList.add(
        ItemKeyValuePair(title: languages.total, value: getAmountWithCurrency(total), showDivider: true));
    subjectKeyValueList.sink.add(keyValueList);
  }
}
