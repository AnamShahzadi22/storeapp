import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/bloc/SingleProductBloc/product_detial_event.dart';
import 'package:store_app/bloc/SingleProductBloc/product_detial_state.dart';
import 'package:store_app/repository/singelProductRepository/single_product_repository.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final SingleProductRepository repository;

  ProductDetailsBloc({required this.repository}) : super(ProductDetailsInitial()) {
    on<FetchProductDetailsEvent>(_onFetchProductDetails);
  }

  Future<void> _onFetchProductDetails(
      FetchProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoading());
    try {
      final product = await repository.fetchProductById(event.productId);
      emit(ProductDetailsLoaded(product: product));
    } catch (e) {
      emit(ProductDetailsError(message: e.toString()));
    }
  }
}
