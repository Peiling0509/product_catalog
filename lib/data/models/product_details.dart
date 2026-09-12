class ProductDetails {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final List<String> images;

  const ProductDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.images,
  });

  factory ProductDetails.fromJson(Map<String, dynamic> json) {
    return ProductDetails(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      images: List<String>.from(json['images'] as List),
    );
  }
}