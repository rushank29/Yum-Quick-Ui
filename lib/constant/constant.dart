import 'package:rxdart/rxdart.dart';

enum Status { loading, completed, error }

enum BottomNavBarItem { home, dishes, favorite, orderHistory, helpAndSupport }

enum DrawerItem {
  myOrders,
  myProfile,
  deliveryAddress,
  paymentMethods,
  contactUs,
  helpAndFAQs,
  settings,
  logOut
}

enum SettingItem { notificationSetting, passwordSetting, deleteAccount }

final selectedDrawerIndexSubject = BehaviorSubject<int>.seeded(1);
