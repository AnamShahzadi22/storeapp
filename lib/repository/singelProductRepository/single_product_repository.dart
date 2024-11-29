
import 'package:store_app/config/res/appurl/appurl.dart';
import 'package:store_app/data/network/network_api_service.dart';
import 'package:store_app/model/productmodel/product_model.dart';

class SingleProductRepository {

  Future<Product> fetchProductById(int productId) async {
    NetworkApiServices _api = NetworkApiServices();
    try{
      dynamic response =  await _api.getApi("$baseUrl/$productId");
      return response = Product.fromJson(response);

    }
    catch (e) {
      throw Exception("Failed to fetch product: $e");
    }


  }
}
