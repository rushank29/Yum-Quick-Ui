import 'package:rxdart/rxdart.dart';
import '../dishesScreen/dishes_dl.dart';

class ProductDetailBloc {
  final selectedToppingSubject = BehaviorSubject<ItemToppingList?>();

  void dispose() {
    selectedToppingSubject.close();
  }
}
