import 'package:flutter/material.dart';
import 'package:mobile_cash_manager/componants/cart.dart';
import 'package:mobile_cash_manager/models/article.dart';

class CartProvider extends ChangeNotifier {
  final List<Article> _cartItems = [];

  List<Article> get items => _cartItems;

  clearCart() {
    _cartItems.clear();
  }

  double getTotal() {
    double sum = 0;

    for (Article article in _cartItems) {
      sum += double.parse(article.prix);
    }
    return sum;
  }

  void addItem(Article article) {
    _cartItems.add(article);
    notifyListeners();
  }

  void removeItem(Article article) {
    _cartItems.removeWhere((item) => item == article);
    notifyListeners();
  }
}
