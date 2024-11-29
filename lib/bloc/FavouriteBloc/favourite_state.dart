import 'package:equatable/equatable.dart';
import 'package:store_app/model/productmodel/product_model.dart';

abstract class FavoriteState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {}
class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Product> favorites;

  FavoriteLoaded(this.favorites);

  @override
  List<Object?> get props => [favorites];
}
