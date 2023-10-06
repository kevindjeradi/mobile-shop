import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/views/load_data.dart';
import 'package:mobile_cash_manager/views/login.dart';
import 'package:mobile_cash_manager/views/menu_nav.dart';

// Route Names
// Menu_navigation_bottom
const String menuNav = 'menu_nav';
// Login
const String loginPage = 'login';
const String loadData = 'loadData';

// Control our page route flow
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case menuNav:
      List<dynamic> argMenuNavDetail = settings.arguments as List<dynamic>;
      return MaterialPageRoute(
          builder: (context) => MenuNav(firstIndex: argMenuNavDetail[0]));
    case loadData:
      return MaterialPageRoute(builder: (context) => const LoadData());
    case loginPage:
      return MaterialPageRoute(builder: (context) => const Login());
    default:
      throw ('This route name does not exit');
  }
}
