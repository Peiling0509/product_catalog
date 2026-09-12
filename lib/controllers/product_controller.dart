import 'package:get/get.dart';

import '../data/models/product.dart';
import '../data/services/product_api_service.dart';

enum LoaderState { initial, loading, success, error, empty }

class ProductController extends GetxController {
  final ProductApiService _apiService = ProductApiService();

  final products = <Product>[].obs;

  final state = LoaderState.initial.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    state.value = LoaderState.loading;

    try {
      final result = await _apiService.getProducts(limit: 20, skip: 0);

      if (result.isEmpty) {
        state.value = LoaderState.empty;
      } else {
        products.assignAll(result);
        state.value = LoaderState.success;
      }
    } catch (e) {
      state.value = LoaderState.error;
    }
  }
}
