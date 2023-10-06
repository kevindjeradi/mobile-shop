import 'package:flutter/material.dart';

class UtilsProvider extends ChangeNotifier {
  int _menuNavIndex = 0;
  int get menuNavIndex => _menuNavIndex;
  int _teamViewId = 1;
  int get teamViewId => _teamViewId;

  void changeNavIndex(int index) {
    _menuNavIndex = index;
    notifyListeners();
  }

  void changeTeamViewIndex(int index) {
    _teamViewId = index;
    notifyListeners();
  }
}
