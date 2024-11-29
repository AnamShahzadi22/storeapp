import 'package:equatable/equatable.dart';
import 'package:store_app/data/response/api_response.dart';
import 'package:store_app/model/productmodel/product_model.dart';

class ProductState extends Equatable {
  final ApiResponse<List<Product>> productsResponse;
  final List<Product>? allProducts; // Cached full product list

  ProductState({required this.productsResponse, this.allProducts,});

  /// CopyWith Method
  ProductState copyWith({
    ApiResponse<List<Product>>? productsResponse,
    List<Product>? allProducts,
  }) {
    return ProductState(
      productsResponse: productsResponse ?? this.productsResponse,
      allProducts: allProducts ?? this.allProducts,

    );
  }

  @override
  List<Object?> get props => [productsResponse];
}