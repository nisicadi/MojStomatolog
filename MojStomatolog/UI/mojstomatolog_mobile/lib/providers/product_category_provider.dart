import 'package:mojstomatolog_mobile/models/product_category.dart';
import 'base_provider.dart';

class ProductCategoryProvider extends BaseProvider<ProductCategory> {
  ProductCategoryProvider() : super("ProductCategory");

  @override
  ProductCategory fromJson(data) {
    return ProductCategory.fromJson(data);
  }
}
