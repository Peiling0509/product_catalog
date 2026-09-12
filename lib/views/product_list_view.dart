import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_catalog/views/product_detail_view.dart';

import '../controllers/product_controller.dart';
import '../widgets/product_card.dart';

class ProductListView extends StatefulWidget {
  const ProductListView({super.key});

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  late final ScrollController _scrollController;

  ProductController get controller => Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      controller.loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              onChanged: controller.searchProducts,
              decoration: InputDecoration(
                hintText: 'Search products',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
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
                  return RefreshIndicator(
                    onRefresh: controller.fetchProducts,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount:
                          controller.products.length +
                          (controller.isLoadingMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.products.length) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                    
                        final product = controller.products[index];
                    
                        return ProductCard(
                          product: product,
                          onTap: () {
                            Get.to(
                              () => ProductDetailView(productId: product.id),
                            );
                          },
                        );
                      },
                    ),
                  );
              }
            }),
          ),
        ],
      ),
    );
  }
}
