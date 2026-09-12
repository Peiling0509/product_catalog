import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';

class ProductListView extends GetView<ProductController> {
  const ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Obx(() {
        switch (controller.state.value) {
          case LoaderState.initial:
          case LoaderState.loading:
            return const Center(child: CircularProgressIndicator());

          case LoaderState.error:
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to load products'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: controller.fetchProducts,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );

          case LoaderState.empty:
            return const Center(child: Text('No products found'));

          case LoaderState.success:
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.products.length,
              itemBuilder: (context, index) {
                final product = controller.products[index];

                return ProductCard(product: product);
              },
            );
        }
      }),
    );
  }
}
