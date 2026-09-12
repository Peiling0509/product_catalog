import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/product_controller.dart';
import 'views/product_list_view.dart';

void main() {
  runApp(const ProductCatalogApp());
}

class ProductCatalogApp extends StatelessWidget {
  const ProductCatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Catalog',
      initialBinding: BindingsBuilder(() {
        Get.put(ProductController());
      }),
      home: ProductListView(),
    );
  }
}