import 'dart:convert';
import 'package:mojstomatolog_mobile/models/product.dart';
import 'base_provider.dart';

class ProductProvider extends BaseProvider<Product> {
  ProductProvider() : super("Product");

  Future<List<Product>> getRecommendedProducts(int productId) async {
    var headers = await createHeaders();

    var response = await http!.get(
        Uri.parse('${baseUrl}Product/$productId/recommend'),
        headers: headers);

    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load recommended products');
    }
  }

  @override
  Product fromJson(data) {
    return Product.fromJson(data);
  }
}
