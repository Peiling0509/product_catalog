import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/data/models/product.dart';

void main() {
  group('Product.fromJson', () {
    test('should correctly parse product JSON', () {
      final json = {
        'id': 1,
        'title': 'Test Product',
        'price': 99.99,
        'thumbnail': 'https://example.com/image.jpg',
      };
      final product = Product.fromJson(json);

      expect(product.id, 1);
      expect(product.title, 'Test Product');
      expect(product.price, 99.99);
      expect(product.thumbnail, 'https://example.com/image.jpg');
    });
  });
}