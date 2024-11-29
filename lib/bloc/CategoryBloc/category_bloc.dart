import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/response/api_response.dart';
import 'package:store_app/repository/CategoryRepository/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryState(categoriesResponse: ApiResponse.loading())) {
    on<FetchCategoriesEvent>(_fetchCategories);
    on<SearchCategoriesEvent>(_searchCategories);
  }

  /// Handles the `FetchCategoriesEvent` to fetch the categories list
  Future<void> _fetchCategories(
      FetchCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(state.copyWith(categoriesResponse: ApiResponse.loading()));
    try {
      final categories = await _categoryRepository.fetchCategories();
      emit(state.copyWith(categoriesResponse: ApiResponse.completed(categories)));
    } catch (e) {
      emit(state.copyWith(categoriesResponse: ApiResponse.error(e.toString())));
    }
  }

  /// Handles the `SearchCategoriesEvent` to filter categories by query
  Future<void> _searchCategories(
      SearchCategoriesEvent event, Emitter<CategoryState> emit) async {
    try {
      final allCategories = state.allCategories ??
          await _categoryRepository.fetchCategories(); // Ensure all categories are cached

      emit(state.copyWith(allCategories: allCategories)); // Cache the full list if not already

      // Perform search by filtering locally
      final query = event.query.toLowerCase();
      final filteredCategories = allCategories.where((category) {
        return category.name.toLowerCase().contains(query);
      }).toList();

      emit(state.copyWith(
        categoriesResponse: ApiResponse.completed(filteredCategories),
      ));
    } catch (e) {
      emit(state.copyWith(categoriesResponse: ApiResponse.error(e.toString())));
    }
  }
}
