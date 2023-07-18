import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/product.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await Dio().get('https://fakestoreapi.com/products');

      if (response.statusCode == 200) {
        final List<Product> fetchedProducts = [];

        for (var productData in response.data) {
          final product = Product(
            id: productData['id'],
            title: productData['title'],
            price: productData['price'].toDouble(),
            description: productData['description'],
            category: productData['category'],
            image: productData['image'],
            rating: productData['rating'],
          );

          fetchedProducts.add(product);
        }

        products.assignAll(fetchedProducts);
      }
    } catch (e) {
      // Handle error
      print('Error fetching products: $e');
    }
  }
}
