import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../widgets/product_image.dart';

class ProductDetailView extends StatefulWidget {
  final int productId;

  const ProductDetailView({super.key, required this.productId});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final ProductController controller = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();

    controller.fetchProductDetails(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),
      body: Obx(() {
        switch (controller.detailState.value) {
          case LoaderState.initial:
          case LoaderState.loading:
            return const Center(child: CircularProgressIndicator());

          case LoaderState.error:
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to load product'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      controller.fetchProductDetails(widget.productId);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );

          case LoaderState.empty:
            return const Center(child: Text('Product not found'));

          case LoaderState.success:
            final product = controller.productDetails.value!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.images.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        return ProductImage(
                          imageUrl: product.images[index],
                          width: 200,
                          height: 200,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Title
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Price
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
