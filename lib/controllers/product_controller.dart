import 'dart:async';

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

  // for infinite scroll pagination
  final isLoadingMore = false.obs;
  final hasMore = true.obs;
  int _skip = 0;
  static const int _limit = 20;

  // for debounced search
  final searchQuery = ''.obs;
  final isSearching = false.obs;
  Timer? _searchDebounce;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  @override
  void onClose() {
    _searchDebounce?.cancel();
    super.onClose();
  }

  Future<void> fetchProducts() async {
    state.value = LoaderState.loading;

    //Refresh always resets the list to the default product catalog.
    searchQuery.value = '';
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
    if (searchQuery.value.isNotEmpty) {
      return;
    }

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

  void searchProducts(String query) {
    searchQuery.value = query;
    _searchDebounce?.cancel();
    if (query.trim().isEmpty) {
      fetchProducts();
      return;
    }
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      _performSearch(query.trim());
    });
  }

  Future<void> _performSearch(String query) async {
    isSearching.value = true;
    hasMore.value = false;

    state.value = LoaderState.loading;

    try {
      final result = await _apiService.searchProducts(query);

      if (result.isEmpty) {
        products.clear();
        state.value = LoaderState.empty;
      } else {
        products.assignAll(result);
        state.value = LoaderState.success;
      }
    } catch (e) {
      state.value = LoaderState.error;
    } finally {
      isSearching.value = false;
    }
  }
}
