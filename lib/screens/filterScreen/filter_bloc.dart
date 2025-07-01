import 'package:rxdart/rxdart.dart';

class FilterBloc {
  final selectedIndexSubject = BehaviorSubject<int>();
  final selectedRangeSubject = BehaviorSubject<num>();
  final selectedSubCategorySubject = BehaviorSubject<List<int>>();

  void dispose() {
    selectedIndexSubject.close();
    selectedRangeSubject.close();
    selectedSubCategorySubject.close();
  }
}