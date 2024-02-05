import 'package:mojstomatolog_desktop/models/product.dart';
import 'base_provider.dart';

class ProductProvider extends BaseProvider<Product> {
  ProductProvider() : super("Product");

  Future<void> retrainModel() async {
    var headers = await createHeaders();

    final response = await http!
        .post(Uri.parse('${baseUrl}Product/retrain'), headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to initiate retraining: ${response.body}');
    }
  }

  @override
  Product fromJson(data) {
    return Product.fromJson(data);
  }
}
