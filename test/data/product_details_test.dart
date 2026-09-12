import 'package:flutter_test/flutter_test.dart';
import 'package:product_catalog/data/models/product_details.dart';

void main() {
  group('ProductDetails.fromJson', () {
    test('should correctly parse product detail JSON', () {
      final json = {
        'id': 1,
        'title': 'Test Product',
        'description': 'This is a test product.',
        'price': 99.99,
        'rating': 4.5,
        'images': [
          'https://example.com/image1.jpg',
          'https://example.com/image2.jpg',
        ],
      };

      final product = ProductDetails.fromJson(json);

      expect(product.id, 1);
      expect(product.title, 'Test Product');
      expect(product.description, 'This is a test product.');
      expect(product.price, 99.99);
      expect(product.rating, 4.5);
      expect(product.images.length, 2);
      expect(product.images[0], 'https://example.com/image1.jpg');
      expect(product.images[1], 'https://example.com/image2.jpg');
    });
  });
}