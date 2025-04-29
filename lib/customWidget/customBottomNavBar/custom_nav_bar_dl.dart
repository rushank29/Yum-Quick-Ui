import 'dart:ui';

class ItemBottomNavBar {
  final String iconPath;
  final VoidCallback onTap;

  ItemBottomNavBar({required this.iconPath, required this.onTap});
}

class ItemDrawer {
  final String title;
  final String iconPath;
  final VoidCallback onTap;

  ItemDrawer({required this.title, required this.iconPath, required this.onTap});
}
