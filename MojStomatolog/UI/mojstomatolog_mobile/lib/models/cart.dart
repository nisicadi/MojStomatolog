import 'package:collection/collection.dart';
import 'package:mojstomatolog_mobile/models/cart_item.dart';
import 'package:mojstomatolog_mobile/models/product.dart';

class Cart {
  List<CartItem> items = [];

  void addItem(Product product) {
    var existingItem = items.firstWhereOrNull(
        (item) => item.product.productId == product.productId);
    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      items.add(CartItem(product: product));
    }
  }

  void removeItem(Product product) {
    items.removeWhere((item) => item.product.productId == product.productId);
  }

  void clearCart() {
    items.clear();
  }
}
