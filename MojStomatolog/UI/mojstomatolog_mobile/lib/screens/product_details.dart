import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mojstomatolog_mobile/models/product.dart';
import 'package:mojstomatolog_mobile/models/rating.dart';
import 'package:mojstomatolog_mobile/providers/cart_provider.dart';
import 'package:mojstomatolog_mobile/providers/product_provider.dart';
import 'package:mojstomatolog_mobile/providers/rating_provider.dart';
import 'package:mojstomatolog_mobile/utils/util.dart';
import 'package:mojstomatolog_mobile/widgets/recommended_product_card.dart';
import 'package:provider/provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;

  ProductDetailsPage({required this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  double averageRating = 0.0;
  double userRating = 0.0;
  int? userRatingId;
  List<Product> recommendedProducts = [];
  bool isLoadingRecommended = true;

  @override
  void initState() {
    super.initState();
    _loadAverageRating();
    _loadUserRating();
    _loadRecommendedProducts();
  }

  void _loadAverageRating() async {
    try {
    var ratingProvider = RatingProvider();
    double rating =
        await ratingProvider.fetchAverageRating(widget.product.productId!);
    setState(() {
      averageRating = rating;
    });
    } catch (e) {
      print('Error fetching rating: $e');
  }
  }

  void _loadUserRating() async {
    try {
    var ratingProvider = RatingProvider();
    int userId = User.userId!;
      var userRatingData = await ratingProvider.fetchUserRating(
          userId, widget.product.productId!);
    if (userRatingData != null) {
      setState(() {
        userRating = userRatingData.ratingValue!.toDouble();
        userRatingId = userRatingData.ratingId;
      });
    }
    } catch (e) {
      print('Error fetching user rating: $e');
  }
  }

  void _submitRating() async {
    try {
    var ratingProvider = RatingProvider();
    int userId = User.userId!;

    Rating newRating = Rating()
      ..ratingId = userRatingId
      ..productId = widget.product.productId
      ..userId = userId
      ..ratingValue = userRating.toInt();

    if (userRatingId == null) {
      await ratingProvider.insert(newRating.toJson());
    } else {
      await ratingProvider.update(newRating.ratingId!, newRating.toJson());
    }

    _loadUserRating();
    _loadAverageRating();
    } catch (e) {
      print('Error submitting rating: $e');
  }
  }

  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? Colors.amber : Colors.grey,
        );
      }),
    );
  }

  Widget _buildRecommendedProductsSection() {
    if (isLoadingRecommended) {
      return Center(child: CircularProgressIndicator());
    }

    if (recommendedProducts.isEmpty) {
      return Text('Nema preporučenih proizvoda', textAlign: TextAlign.center);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Preporučeni proizvodi:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: recommendedProducts.length,
            itemBuilder: (context, index) {
              var product = recommendedProducts[index];
              return _buildProductCard(product);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(Product product) {
    return RecommendedProductCard(
      product: product,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product)),
        );
      },
    );
  }

  void _loadRecommendedProducts() async {
    try {
      var productProvider = ProductProvider();
      var products = await productProvider
          .getRecommendedProducts(widget.product.productId!);
      setState(() {
        recommendedProducts = products;
        isLoadingRecommended = false;
      });
    } catch (e) {
      print('Error fetching recommended products: $e');
      setState(() {
        isLoadingRecommended = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name ?? 'Detalji proizvoda'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                widget.product.imageUrl ?? '',
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset('assets/images/no_image.jpg'),
              ),
            ),
            SizedBox(height: 16),
            Text(
              widget.product.name ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Divider(),
            Text(
              'Opis:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.product.description ?? 'Nema opisa'),
            SizedBox(height: 8),
            Text(
              'Kategorija: ${widget.product.category ?? 'N/A'}',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8),
            Text(
              'Cijena: ${widget.product.price?.toStringAsFixed(2) ?? ''} KM',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            _buildRatingStars(averageRating),
            SizedBox(height: 16),
            Text(
              'Vaša ocjena:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: RatingBar.builder(
                initialRating: userRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) =>
                    Icon(Icons.star, color: Theme.of(context).primaryColor),
                onRatingUpdate: (rating) {
                  setState(() {
                    userRating = rating;
                  });
                },
              ),
            ),
            ElevatedButton(
              onPressed: _submitRating,
              child: Text('Potvrdi ocjenu'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).hintColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: () {
                Provider.of<CartProvider>(context, listen: false)
                    .addToCart(widget.product);
                Navigator.pop(context);
              },
              child: Text(
                'Dodaj u korpu',
                style: TextStyle(fontSize: 16),
              ),
            ),
            _buildRecommendedProductsSection(),
          ],
        ),
      ),
    );
  }
}
