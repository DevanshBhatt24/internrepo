import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

final iconVisibleProvider = ChangeNotifierProvider<FloatIconService>((ref) {
  return FloatIconService();
});

class FloatIconService with ChangeNotifier {
  bool iconVisible = true;
  void setNavbarVisible(bool v) {
    iconVisible = v;
    notifyListeners();
  }
}
