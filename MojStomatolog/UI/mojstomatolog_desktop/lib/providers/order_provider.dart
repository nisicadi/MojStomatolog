import 'dart:convert';
import 'package:http/http.dart';
import 'package:mojstomatolog_desktop/models/order.dart';
import 'base_provider.dart';

class OrderProvider extends BaseProvider<Order> {
  OrderProvider() : super("Order");

    Future<Response?> changeStatus(int orderId, int orderStatus) async {
    var headers = await createHeaders();
    return await http?.patch(Uri.parse("${baseUrl}Order"),
        body: json
            .encode({"orderId": orderId, "orderStatus": orderStatus}),
        headers: headers);
  }

  @override
  Order fromJson(data) {
    return Order.fromJson(data);
  }
}
