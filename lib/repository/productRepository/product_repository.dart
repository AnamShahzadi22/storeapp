import 'package:store_app/config/res/appurl/appurl.dart';
import 'package:store_app/data/network/network_api_service.dart';
import '../../model/productmodel/product_model.dart';

class ProductRepository {
  final _api = NetworkApiServices();

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _api.getApi(productUrl);

      if (response is Map && response.containsKey('products')) {
        final List<dynamic> productsList = response['products'];
        return productsList.map((data) => Product.fromJson(data)).toList();
      } else if (response is List) {
        return response.map((data) => Product.fromJson(data)).toList();
      } else {
        throw Exception('Unexpected API response format');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}

