import 'package:equatable/equatable.dart';
import 'package:store_app/model/productmodel/product_model.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddToFavoritesEvent extends FavoriteEvent {
  final Product product;

  AddToFavoritesEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class RemoveFromFavoritesEvent extends FavoriteEvent {
  final Product product;

  RemoveFromFavoritesEvent(this.product);

  @override
  List<Object?> get props => [product];
}

class SearchFavoritesEvent extends FavoriteEvent {
  final String query;

  SearchFavoritesEvent({required this.query});

  @override
  List<Object?> get props => [query];
}