import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/bloc/FavouriteBloc/favourite_event.dart';
import 'package:store_app/bloc/FavouriteBloc/favourite_state.dart';
import 'package:store_app/model/productmodel/product_model.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<AddToFavoritesEvent>(_addToFavorites);
    on<RemoveFromFavoritesEvent>(_removeFromFavorites);
    on<SearchFavoritesEvent>(_searchFavorites);
  }

  List<Product> _favorites = [];
  List<Product> _filteredFavorites = [];

  void _addToFavorites(AddToFavoritesEvent event, Emitter<FavoriteState> emit) {
    if (!_favorites.contains(event.product)) {
      _favorites.add(event.product);
      _filteredFavorites = List.from(_favorites);
    }
    emit(FavoriteLoaded(_filteredFavorites));
  }

  void _removeFromFavorites(RemoveFromFavoritesEvent event, Emitter<FavoriteState> emit) {
    _favorites.remove(event.product);
    _filteredFavorites = List.from(_favorites);
    emit(FavoriteLoaded(_filteredFavorites));
  }

  void _searchFavorites(SearchFavoritesEvent event, Emitter<FavoriteState> emit) {
    _filteredFavorites = _favorites
        .where((product) => product.title.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(FavoriteLoaded(_filteredFavorites));
  }
}
