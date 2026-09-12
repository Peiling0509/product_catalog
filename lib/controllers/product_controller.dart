import 'package:get/get.dart';

import '../data/models/product.dart';
import '../data/models/product_details.dart';
import '../data/services/product_api_service.dart';

enum LoaderState { initial, loading, success, error, empty }

class ProductController extends GetxController {
  final ProductApiService _apiService = ProductApiService();

  final products = <Product>[].obs;
  final productDetails = Rxn<ProductDetails>();

  final state = LoaderState.initial.obs;
  final detailState = LoaderState.initial.obs;

  final isLoadingMore = false.obs;

  final hasMore = true.obs;

  int _skip = 0;

  static const int _limit = 20;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    state.value = LoaderState.loading;

    _skip = 0;
    hasMore.value = true;

    try {
      final result = await _apiService.getProducts(limit: _limit, skip: _skip);

      if (result.isEmpty) {
        products.clear();
        state.value = LoaderState.empty;
      } else {
        products.assignAll(result);
        _skip = result.length;
        state.value = LoaderState.success;
      }
    } catch (e) {
      state.value = LoaderState.error;
    }
  }

  Future<void> loadMoreProducts() async {
    if (isLoadingMore.value || !hasMore.value) {
      return;
    }

    isLoadingMore.value = true;

    try {
      final result = await _apiService.getProducts(limit: _limit, skip: _skip);

      if (result.isEmpty || result.length < _limit) {
        hasMore.value = false;
      }

      if (result.isNotEmpty) {
        products.addAll(result);
        _skip += result.length;
      }
    } catch (e) {
      // Keep existing products visible.
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> fetchProductDetails(int id) async {
    detailState.value = LoaderState.loading;

    try {
      final result = await _apiService.getProductDetails(id);

      productDetails.value = result;
      detailState.value = LoaderState.success;
    } catch (e) {
      detailState.value = LoaderState.error;
    }
  }

}
