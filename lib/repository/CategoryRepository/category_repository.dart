import 'package:store_app/config/res/appurl/appurl.dart';
import 'package:store_app/data/network/network_api_service.dart';
import '../../model/category_model/category_model.dart';

class CategoryRepository {
  final _api = NetworkApiServices();

  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final response = await _api.getApi(categoryUrl);

      if (response is List) {
        return response.map((data) => CategoryModel.fromJson(data)).toList();
      } else if (response is Map && response.containsKey('categories')) {
        final List<dynamic> categoriesList = response['categories'];
        return categoriesList.map((data) => CategoryModel.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected API response format. Expected List or Map with "categories" key.');
      }
    } catch (e) {
      print('Error occurred while fetching categories: $e');
      throw Exception('Error fetching categories: $e');
    }
  }
}
