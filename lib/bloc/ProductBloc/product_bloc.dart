import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/response/api_response.dart';
import 'package:store_app/model/productmodel/product_model.dart';
import 'package:store_app/repository/productRepository/product_repository.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductState(productsResponse: ApiResponse.loading())) {
    on<FetchProductsEvent>(_fetchProducts);
    on<SearchProductsEvent>(_searchProducts);
  }

  /// Handles the `FetchProductsEvent` to fetch products list
  Future<void> _fetchProducts(
      FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(state.copyWith(productsResponse: ApiResponse.loading()));
    try {
      final products = await _productRepository.fetchProducts();
      emit(state.copyWith(productsResponse: ApiResponse.completed(products as List<Product>?)));
    } catch (e) {
      emit(state.copyWith(productsResponse: ApiResponse.error(e.toString())));
    }
  }

  /// Handles the `SearchProductsEvent` to filter products by query
  Future<void> _searchProducts(
      SearchProductsEvent event, Emitter<ProductState> emit) async {
    try {
      final allProducts = state.allProducts ??
          await _productRepository.fetchProducts(); // Ensure all products are cached

      emit(state.copyWith(allProducts: allProducts)); // Cache the full list if not already

      // Perform search by filtering locally
      final query = event.query.toLowerCase();
      final filteredProducts = allProducts.where((product) {
        return product.title.toLowerCase().contains(query);
      }).toList();

      emit(state.copyWith(
        productsResponse: ApiResponse.completed(filteredProducts),
      ));
    } catch (e) {
      emit(state.copyWith(productsResponse: ApiResponse.error(e.toString())));
    }
  }




}
