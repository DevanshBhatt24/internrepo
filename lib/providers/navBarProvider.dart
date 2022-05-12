import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

final navBarVisibleProvider = ChangeNotifierProvider<NavBarService>((ref) {
  return NavBarService(navBarVisible: false);
});

class NavBarService with ChangeNotifier {
  bool navBarVisible;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);
  NavBarService({this.navBarVisible});

  bool get isNavBarVisible => navBarVisible;

  void setNavbarVisible(bool v) {
    navBarVisible = v;
    notifyListeners();
  }
}
