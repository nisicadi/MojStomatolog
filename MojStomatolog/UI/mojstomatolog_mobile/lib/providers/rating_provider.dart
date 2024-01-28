import 'dart:convert';
import 'package:mojstomatolog_mobile/models/rating.dart';
import 'base_provider.dart';

class RatingProvider extends BaseProvider<Rating> {
  RatingProvider() : super("Rating");

  Future<double> fetchAverageRating(int productId) async {
    final headers = await createHeaders();
    final response = await http!.get(
        Uri.parse('${baseUrl}Rating/$productId/averageRating'),
        headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      return double.parse(response.body);
    } else {
      throw Exception('Failed to load average rating');
    }
  }

  Future<Rating?> fetchUserRating(int userId, int productId) async {
    final headers = await createHeaders();
    final response = await http!.get(
        Uri.parse('${baseUrl}Rating/user/$userId/product/$productId'),
        headers: headers);

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      return Rating.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  @override
  Rating fromJson(data) {
    return Rating.fromJson(data);
  }
}
