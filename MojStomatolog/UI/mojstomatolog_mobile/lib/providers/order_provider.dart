import 'dart:convert';
import 'package:mojstomatolog_mobile/models/order.dart';
import 'base_provider.dart';

class OrderProvider extends BaseProvider<Order> {
  OrderProvider() : super("Order");

  Future<bool> createOrder(Order request) async {
    try {
      const url = 'https://10.0.2.2:7043/Order';
      final uri = Uri.parse(url);

      final headers = await createHeaders();
      final jsonRequest = jsonEncode(request.toJson());

      final response =
          await http!.post(uri, headers: headers, body: jsonRequest);

      print(response.body);

      if (isValidResponseCode(response)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  @override
  Order fromJson(data) {
    return Order.fromJson(data);
  }
}
