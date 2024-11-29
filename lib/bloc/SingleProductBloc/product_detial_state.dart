import 'package:equatable/equatable.dart';
import 'package:store_app/model/productmodel/product_model.dart';

abstract class ProductDetailsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsState {}

class ProductDetailsLoaded extends ProductDetailsState {
  final  Product  product;

  ProductDetailsLoaded({required this.product});

  @override
  List<Object?> get props => [product];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;

  ProductDetailsError({required this.message});

  @override
  List<Object?> get props => [message];
}
