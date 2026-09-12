import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../models/product_details.dart';

class ProductApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getProducts({
    required int limit,
    required int skip,
  }) async {
    final uri = Uri.parse('$_baseUrl/products?limit=$limit&skip=$skip');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load products');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    final products = data['products'] as List;

    return products
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<ProductDetails> getProductDetails(int id) async {
    final uri = Uri.parse('$_baseUrl/products/$id');

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to load product details');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    return ProductDetails.fromJson(data);
  }

  Future<List<Product>> searchProducts(String query) async {
    final uri = Uri.parse(
      '$_baseUrl/products/search?q=${Uri.encodeQueryComponent(query)}',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Failed to search products');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    final products = data['products'] as List;

    return products
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
