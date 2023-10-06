import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/models/user.dart';

class ClientProvider extends ChangeNotifier {
  User? _user;
  User? get user => _user;

  void setUser(User u) => _user = u;

  void changeUser(User u) {
    _user = u;
    notifyListeners();
  }
}
