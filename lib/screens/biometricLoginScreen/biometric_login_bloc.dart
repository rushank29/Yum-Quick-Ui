import 'package:rxdart/rxdart.dart';

class BiometricLoginBloc {
  final changeColorSubject = BehaviorSubject<bool>.seeded(false);

  void dispose() {
    changeColorSubject.close();
  }
}