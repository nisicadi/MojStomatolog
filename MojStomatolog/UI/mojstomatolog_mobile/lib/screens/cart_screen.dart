import 'package:flutter/material.dart';
import 'package:mojstomatolog_mobile/models/cart_item.dart';
import 'package:mojstomatolog_mobile/models/order.dart';
import 'package:mojstomatolog_mobile/models/order_item.dart';
import 'package:mojstomatolog_mobile/providers/cart_provider.dart';
import 'package:mojstomatolog_mobile/providers/order_provider.dart';
import 'package:mojstomatolog_mobile/utils/util.dart';
import 'package:provider/provider.dart';
import 'package:mojstomatolog_mobile/widgets/master_screen.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    double calculateTotal() {
      return cartProvider.cart.items.fold(0,
          (total, item) => total + (item.product.price ?? 0) * item.quantity);
    }

    bool isCartEmpty() {
      return cartProvider.cart.items.isEmpty;
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
                  onPressed:
                      isCartEmpty() ? null : () => cartProvider.clearCart(),
                  tooltip: 'Isprazni korpu',
                ),
                ElevatedButton.icon(
                  onPressed: isCartEmpty()
                      ? null
                      : () => _showPaymentOptions(
                          context, cartProvider, calculateTotal),
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

  void _showPaymentOptions(BuildContext context, CartProvider cartProvider,
      double Function() calculateTotal) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('Kreditna kartica'),
                onTap: () {
                  Navigator.of(context).pop();
                  _proceedToCheckout(context, cartProvider, calculateTotal);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _proceedToCheckout(BuildContext context,
      CartProvider cartProvider, double Function() calculateTotal) async {
    final totalAmount = (calculateTotal() * 100).toInt();
    var stripeSecretKey = const String.fromEnvironment("stripeSecretKey",
        defaultValue:
            "sk_test_51OcsSjKDEaPbMijStS3aVvYOCMvJx3xvW6fpMLLBQ9nB6IcYMzMc41sCDoF4JNQR5480hCbL3qbKeR2jaZjDynLy00YNvGVPeH");

    try {
      var paymentIntentUrl = const String.fromEnvironment("paymentIntentUrl",
          defaultValue: "https://api.stripe.com/v1/payment_intents");

      final url = Uri.parse(paymentIntentUrl);
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: {
          'amount': totalAmount.toString(),
          'currency': 'bam',
          'payment_method_types[]': 'card'
        },
      );

      if (response.statusCode == 200) {
        final paymentIntentData = json.decode(response.body);
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: paymentIntentData['client_secret'],
            merchantDisplayName: 'Pero Peric',
          ),
        );

        await Stripe.instance.presentPaymentSheet();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Plaćanje uspješno!')),
        );

        await _createOrder(cartProvider, totalAmount / 100);

        cartProvider.clearCart();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Plaćanje neuspješno: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Greška: $e')),
      );
    }
  }

  Future<void> _createOrder(
      CartProvider cartProvider, double totalAmount) async {
    OrderProvider orderProvider = OrderProvider();

    Order newOrder = Order();
    newOrder.totalAmount = totalAmount;
    newOrder.userId = User.userId;
    newOrder.orderDate = DateTime.now();
    newOrder.orderItems = cartProvider.cart.items.map((cartItem) {
      return OrderItem()
        ..productId = cartItem.product.productId
        ..quantity = cartItem.quantity
        ..price = cartItem.product.price;
    }).toList();

    await orderProvider.createOrder(newOrder);
  }
}
