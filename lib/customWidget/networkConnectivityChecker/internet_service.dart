import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

class InternetService {
  // Singleton setup
  static final InternetService _instance = InternetService._internal();
  factory InternetService() => _instance;
  InternetService._internal();

  Timer? _timer;
  final Connectivity _connectivity = Connectivity();
  final InternetConnectionChecker _checker = InternetConnectionChecker();

  final BehaviorSubject<bool?> _statusSubject = BehaviorSubject<bool?>();
  Stream<bool?> get connectionStatusStream => _statusSubject.stream;
  bool? get isNetworkConnected => _statusSubject.valueOrNull;
  bool _lastStatus = true;
  Timer? _onlineResetTimer;

  void startMonitoring() {
    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen((_) async {
      final result = await _checker.hasConnection;
      _updateStatus(result);
    });

    // Also check periodically
    if (_timer != null && _timer!.isActive) return;
    _timer = Timer.periodic(const Duration(seconds: 10), (_) async {
      final result = await _checker.hasConnection;
      _updateStatus(result);
    });
  }

  void _updateStatus(bool currentStatus) {
    if (currentStatus != _lastStatus) {
      _statusSubject.sink.add(currentStatus);
      _lastStatus = currentStatus;

      if (currentStatus == true) {
        // Automatically reset to hide banner after 3 seconds
        _onlineResetTimer?.cancel();
        _onlineResetTimer = Timer(const Duration(seconds: 3), () {
          _statusSubject.sink.add(null); // reset the banner
        });
      }
    }
  }

  void runWhenOnline(void Function() callback) {
    if (isNetworkConnected == true || isNetworkConnected == null) {
      print("networkConnected =============> ");
      callback.call();
      return;
    }

    late final StreamSubscription<bool?> subscription;
    subscription = connectionStatusStream.listen((status) {
      if (status == true) {
        print("status =============> ");
        callback.call();
        subscription.cancel();
      }
    });
  }

  void dispose() {
    if (_timer != null && _timer!.isActive) _timer?.cancel();
    if (_onlineResetTimer != null && _onlineResetTimer!.isActive) _onlineResetTimer?.cancel();
    _statusSubject.close();
  }
}
