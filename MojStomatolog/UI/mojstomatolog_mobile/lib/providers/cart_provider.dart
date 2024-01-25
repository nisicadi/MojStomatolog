import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/models/cart.dart';
import 'package:mojstomatolog_mobile/models/product.dart';

class CartProvider with ChangeNotifier {
  Cart _cart = Cart();

  Cart get cart => _cart;

  void addToCart(Product product) {
    _cart.addItem(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.removeItem(product);
    notifyListeners();
  }

  void clearCart() {
    _cart.clearCart();
    notifyListeners();
  }
}
