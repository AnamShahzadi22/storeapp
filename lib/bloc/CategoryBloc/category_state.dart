import 'package:equatable/equatable.dart';
import 'package:store_app/data/response/api_response.dart';
import 'package:store_app/model/category_model/category_model.dart';

class CategoryState extends Equatable {
  final ApiResponse<List<CategoryModel>> categoriesResponse;
  final List<CategoryModel>? allCategories; // Cached full category list

  CategoryState({required this.categoriesResponse, this.allCategories});

  /// CopyWith Method
  CategoryState copyWith({
    ApiResponse<List<CategoryModel>>? categoriesResponse,
    List<CategoryModel>? allCategories,
  }) {
    return CategoryState(
      categoriesResponse: categoriesResponse ?? this.categoriesResponse,
      allCategories: allCategories ?? this.allCategories,
    );
  }

  @override
  List<Object?> get props => [categoriesResponse, allCategories];
}
