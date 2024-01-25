import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/models/cart_item.dart';
import 'package:mojstomatolog_mobile/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    double calculateTotal() {
      return cartProvider.cart.items.fold(0,
          (total, item) => total + (item.product.price ?? 0) * item.quantity);
    }

    return MasterScreenWidget(
      currentIndex: 3,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.cart.items.length,
                itemBuilder: (context, index) {
                  final item = cartProvider.cart.items[index];
                  return ListTile(
                    leading: Image.network(
                      item.product.imageUrl ?? '',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/no_image.jpg',
                          width: 50,
                          height: 50),
                    ),
                    title: Text(item.product.name ?? ''),
                    subtitle: Text('Cijena: ${item.product.price ?? 0} KM'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () =>
                                _updateQuantity(cartProvider, item, false)),
                        Text('${item.quantity}'),
                        IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () =>
                                _updateQuantity(cartProvider, item, true)),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ukupno:', style: TextStyle(fontSize: 20)),
                  Text('${calculateTotal().toStringAsFixed(2)} KM',
                      style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.delete_outline),
                  onPressed: () => cartProvider.clearCart(),
                  tooltip: 'Isprazni korpu',
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Implement
                  },
                  icon: Icon(Icons.payment),
                  label: Text('Nastavi na plaćanje'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateQuantity(CartProvider provider, CartItem item, bool increment) {
    if (increment) {
      item.quantity++;
    } else if (item.quantity > 1) {
      item.quantity--;
    } else {
      provider.removeFromCart(item.product);
    }
    provider.notifyListeners();
  }
}
